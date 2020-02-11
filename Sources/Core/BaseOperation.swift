import Foundation
/**
Subclass of Operation to add basic functionality like async operations.
 
Use like:
```
import Foundation
import CoreData

public class ImportEntityOperation: BaseOperation {
    private var context: NSManagedObjectContext!
    private var store: Store!

    override func execute() {
        context = PersistenceManager.shared.newBackgroundContext()
        store = Store(context: context)
        defer { finish() }
        // load from network or from disk ...
        // map data to entity - create new Entity(context: context)
        saveChanges()
    }

    private func saveChanges() {
        context.performAndWait {
            do {
                try context.save()
            } catch {
                print("Error saving changes: \(error.localizedDescription)")
            }
        }
    }
}
 
public class Importer {
    static let shared = Importer()

    private var priorityQueue: OperationQueue = {
        let q = OperationQueue()
        q.maxConcurrentOperationCount = 2
        q.qualityOfService = .userInitiated
        return q
    }()

    private var backgroundQueue: OperationQueue = {
        let q = OperationQueue()
        q.maxConcurrentOperationCount = 2
        q.qualityOfService = .background
        return q
    }()

    // f.e for long running import operations which should not block the main thread
    func doSomethingOnBackground() {
        backgroundQueue.addOperation {
            let context = PersistenceManager.shared.newBackgroundContext()
            let store = Store(context: context)
            do {
                let updateOperation = ImportEntityOperation()
                self.backgroundQueue.addOperation(updateOperation)
            } catch {
                print("Error doing import on background. \(error)")
            }
        }
    }

    //f.e listen on some notification and import entites every time a storeChanged notification is called
    func import() {
        let operation = ImportEntityOperation()
        priorityQueue.addOperation(operation)
    }
}
```
*/
public class BaseOperation: Operation {
    public override var isAsynchronous: Bool {
        return true
    }

    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }

    public override var isExecuting: Bool {
        return _executing
    }

    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }

        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }

    override public var isFinished: Bool {
        return _finished
    }

    override public func start() {
        _executing = true
        execute()
    }

    func execute() {
        fatalError("You must override this")
    }

    func finish() {
        _executing = false
        _finished = true
    }
}
