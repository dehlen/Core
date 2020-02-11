# BaseOperation

Use like:

``` swift
public class BaseOperation: Operation
```

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

## Inheritance

`Operation`

## Properties

## isAsynchronous

``` swift
var isAsynchronous: Bool
```

## isExecuting

``` swift
var isExecuting: Bool
```

## isFinished

``` swift
var isFinished: Bool
```

## Methods

## start()

``` swift
override public func start()
```
