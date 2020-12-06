//
//  Observable.swift
//  Homework6
//
//  Created by Михаил Жданов on 06.12.2020.
//

import Foundation

class Observable {
    
    // MARK: - Properties

    var state: Int = {
        return Int(arc4random_uniform(10))
    }()
    
    // MARK: - Private properties

    private var observers = [IObserver]()
    
    // MARK: - Methods

    func add(_ observer: IObserver) {
        print("Observable: added an observer.")
        observers.append(observer)
    }

    func remove(_ observer: IObserver) {
        if let index = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: index)
            print("Observable: removed an observer.")
        }
    }

    func notify() {
        print("Observable: notifying observers...")
        observers.forEach({ $0.update(observable: self) })
    }

    func doSomeStuff() {
        print("Observable: doing something important.")
        state = Int(arc4random_uniform(10))
        print("Observable: state has just changed to: \(state)")
        notify()
    }
    
}
