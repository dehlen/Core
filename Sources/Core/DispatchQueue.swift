import Foundation

public func callOnMain(_ function: @escaping ()->Void) {
    if !Thread.current.isMainThread {
        DispatchQueue.main.async {
            function()
        }
    } else {
        function()
    }
}

public extension DispatchQueue {
    /**
    ```
    DispatchQueue.main.asyncAfter(duration: 100.milliseconds) {
        print("100 ms later")
    }
    ```
    */
    func asyncAfter(duration: TimeInterval, execute: @escaping () -> Void) {
        asyncAfter(deadline: .now() + duration, execute: execute)
    }
}
