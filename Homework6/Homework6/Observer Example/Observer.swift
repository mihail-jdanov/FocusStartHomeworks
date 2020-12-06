//
//  Observer.swift
//  Homework6
//
//  Created by Михаил Жданов on 06.12.2020.
//

import Foundation

protocol IObserver: AnyObject {

    func update(observable: Observable)
    
}

class ObserverA: IObserver {

    func update(observable: Observable) {
        let state = observable.state
        print("ObserverA: received state: \(state)")
        if state < 5 {
            print("ObserverA: reacted to the event.")
        }
    }
    
}

class ObserverB: IObserver {

    func update(observable: Observable) {
        let state = observable.state
        print("ObserverB: received state: \(state)")
        if state >= 5 {
            print("ObserverB: reacted to the event.")
        }
    }
    
}
