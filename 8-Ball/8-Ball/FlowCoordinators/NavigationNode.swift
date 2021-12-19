//
//  NavigationNode.swift
//  8-Ball
//
//  Created by Никита Хламов on 18.12.2021.
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
        let events = node.eventHandlerContainers.isEmpty ? "" :
        "[\(node.eventHandlerContainers.keys.joined(separator: ", "))]"
        Logger.verbose("\(indent) \(node) \(events)")
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

enum LogLevel: Int {

    case test, verbose, success, warn, fail

    func glyph() -> String {
        switch self {
        case .test: return "💜"
        case .verbose: return "💙"
        case .success: return "💚"
        case .warn: return "💛"
        case .fail: return "💔"
        }
    }
}

public enum Logger {

    static let currentLogLevel = LogLevel.test

    public static func success(_ string: @autoclosure () -> String, file: String = #file, line: Int = #line) {
        log(.success, string, file: file, line: line)
    }

    public static func error(_ string: @autoclosure () -> String, file: String = #file, line: Int = #line) {
        log(.fail, string, file: file, line: line)
    }

    public static func test(_ string: @autoclosure () -> String, file: String = #file, line: Int = #line) {
        log(.test, string, file: file, line: line)
    }

    public static func verbose(_ string: @autoclosure () -> String, file: String = #file, line: Int = #line) {
        log(.verbose, string, file: file, line: line)
    }

    public static func warn(_ string: @autoclosure () -> String, file: String = #file, line: Int = #line) {
        log(.warn, string, file: file, line: line)
    }

    private static func log(_ level: LogLevel, _ string: () -> String, file: String = #file, line: Int = #line) {
        #if DEBUG
            if currentLogLevel.rawValue > level.rawValue {
                return
            }
            let startIndex = file.range(of: "/", options: .backwards)?.upperBound
            let fileName = file[startIndex!...]
            print(" \(level.glyph()) [\(NSDate())] \(fileName)(\(line)) | \(string())")
        #elseif canImport(Firebase)
            if level.rawValue >= LogLevel.warn.rawValue {
                let startIndex = file.range(of: "/", options: .backwards)?.upperBound
                let fileName = file[startIndex!...]
                Crashlytics.crashlytics().log(" \(level.glyph()) [\(NSDate())] \(fileName)(\(line)) | \(string())")
            }
        #endif
    }
}

extension Logger {

    public static func error(_ error: Error, file: String = #file, line: Int = #line) {
        self.error("\(error)", file: file, line: line)
    }

    public static func warn(_ error: Error, file: String = #file, line: Int = #line) {
        self.warn("\(error)", file: file, line: line)
    }
}

extension Logger {

    static func assert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) {
        #if DEBUG
        Swift.assert(condition(), message(), file: file, line: line)
        #endif
    }
}
