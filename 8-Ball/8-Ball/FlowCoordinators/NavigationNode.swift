//
//  NavigationNode.swift
//  8-Ball
//
//  Created by Mykyta Khlamov on 18.12.2021.
//

import Foundation

public protocol NavigationEvent {}

public protocol NavigationEventDrivenInterface {

    func raise<T: NavigationEvent>(event: T)
    func addHandler<T: NavigationEvent>(_ handler: @escaping (T) -> Void)
}

public class NavigationNode: NavigationEventDrivenInterface {

    fileprivate final class Configuration {

        /// Determines whether an event should spread along graph
        /// or stop spreading once handled
        static let shouldPassEventsOnceHandled = false

        /// Determine whether events throtteling should be applied
        /// same events will be throtteled with respect to `throttlingThreshold`
        static let shouldThrottleEvents = true
        
        /// Determines throtteling threshold
        /// e.g. how "often" an event can be raised
        static let throttlingThreshold: TimeInterval = 1
    }
    
    private let parent: NavigationNode?
    private let children = NSHashTable<NavigationNode>.weakObjects()
    private var eventHandlerContainers: [String: EventHandleable] = [:]

    init(parent: NavigationNode?) {
        self.parent = parent
        parent?.children.add(self)
    }

    public func addHandler<T: NavigationEvent>(_ handler: @escaping (T) -> Void) {
        let type = String(describing: T.self)
        var container = eventHandlerContainers[type]
        if container == nil {
            container = EventHandlersContainer<T>()
            eventHandlerContainers[type] = container
        }
        if let container = container as? EventHandlersContainer<T> {
            container.add(handler: handler)
        }
    }
    
    public func dump() {
        var rootNode = self
        while rootNode.parent != nil {
            rootNode = rootNode.parent!
        }
        dump(rootNode, 0)
    }
    
    public func raise<T: NavigationEvent>(event: T) {
        // because we're using event for routing only
        // it could be dispatched directly to the main queue
        DispatchQueue.main.async {
            self.raise(event: event, from: self)
        }
    }

    public func raise<T: NavigationEvent>(event: T, from sender: NavigationEventDrivenInterface) {
        // check if we can resolve the event on the same level
        if checkIfCanResolve(event) && !Configuration.shouldPassEventsOnceHandled {
            return
        }
        // if it's not a root node, travers to it
        if let parent = parent {
            parent.raise(event: event, from: sender)
        } else {
            // then narrow down the graph
            propagate(event: event)
        }
    }

    private func propagate<T: NavigationEvent>(event: T) {
        // check if we can resolve the event on the current level
        if checkIfCanResolve(event) && !Configuration.shouldPassEventsOnceHandled {
            return
        }
        // and pass it to child otherwise
        children.allObjects.forEach {
            $0.propagate(event: event)
        }
    }

    private func checkIfCanResolve<T: NavigationEvent>(_ event: T) -> Bool {
        let type = String(describing: T.self)
        if let handler = eventHandlerContainers[type] as? EventHandlersContainer<T> {
            handler.propagate(event: event)
            return true
        }

        return false
    }

    private func dump(_ node: NavigationNode, _ level: Int) {
        let indent = String(repeating: "-", count: level + 1)
        let events = node.eventHandlerContainers.isEmpty ? "" : "[\(node.eventHandlerContainers.keys.joined(separator: ", "))]"
        node.children.objectEnumerator()
            .compactMap { value in value as? NavigationNode }
            .sorted { lhs, rhs -> Bool in lhs.children.count < rhs.children.count }
            .forEach { dump($0, level + 1) }
    }
    
}

private protocol EventHandleable {}

private class EventHandlersContainer<T>: EventHandleable {

    private var handlers: [(T) -> Void] = []
    private var lastOpenedEventDescription = ""
    private var lastTimeEventOpened: TimeInterval = 0

    func add(handler: @escaping (T) -> Void) {
        handlers.append(handler)
    }
    
    func propagate(event: T) {
        guard NavigationNode.Configuration.shouldThrottleEvents else {
            handlers.forEach { $0(event) }

            return
        }
        let now = Date().timeIntervalSince1970
        let currentEventDescription = String(describing: event)
        let shouldSkipEvent = currentEventDescription == lastOpenedEventDescription
            && (now - lastTimeEventOpened < NavigationNode.Configuration.throttlingThreshold)
        if shouldSkipEvent {
            return
        }
        lastTimeEventOpened = now
        lastOpenedEventDescription = currentEventDescription

        handlers.forEach { $0(event) }
    }
    
}
