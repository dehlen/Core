import Foundation

/// Throttle the execution of some function
class Throttler {
    private var workItem: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    private let queue: DispatchQueue
    private let minimumDelay: TimeInterval

    init(minimumDelay: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        self.minimumDelay = minimumDelay
        self.queue = queue
    }

    /// The given block will be throttled and is called only every `minimumDelay` on the given `queue`.
    /// Default is the main queue
    func throttle(_ block: @escaping () -> Void) {
        workItem.cancel()

        workItem = DispatchWorkItem() {
            [weak self] in
            self?.previousRun = Date()
            block()
        }

        let delay = previousRun.timeIntervalSinceNow > minimumDelay ? 0 : minimumDelay
        queue.asyncAfter(deadline: .now() + Double(delay), execute: workItem)
    }
}
