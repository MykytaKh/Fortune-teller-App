import UIKit
import PlaygroundSupport

// ● deadlock with two queues
let queue1 = DispatchQueue.global()
let queue2 = DispatchQueue.main
    queue2.sync {
        queue1.async {
            print("first")
        }
        print("second")
    }


// Происходит deadlock. Чтобы избежать этого нужно sync изменить на async:

queue2.async {
    queue1.async {
        print("first")
    }
    print("second")
}

// ● cancellation of DispatchWorkItem - create background queue, create DispatchWorkItem with infinite print(“0”) logic (use “while true” cycle). Schedule asynchronously item on queue and then cancel it after 2 seconds (use async after).
 
let queue3 = DispatchQueue.global(qos: .background)
let dispatchWI = DispatchWorkItem() {
    while true {
        if dispatchWI.isCancelled { break }
        print("0")
    }
}
queue3.asyncAfter(deadline: .now() + .seconds(2), execute: dispatchWI)
dispatchWI.cancel()

