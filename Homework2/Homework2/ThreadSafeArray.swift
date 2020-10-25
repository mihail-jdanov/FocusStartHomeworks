//
//  ThreadSafeArray.swift
//  Homework2
//
//  Created by Михаил Жданов on 25.10.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import Foundation

class ThreadSafeArray<Element> {
    
    var isEmpty: Bool {
        var value = true
        self.queue.sync {
            value = self.array.isEmpty
        }
        return value
    }
    
    var count: Int {
        var value = 0
        self.queue.sync {
            value = self.array.count
        }
        return value
    }
    
    private let queue = DispatchQueue(label: "ThreadSafeArray.Queue", attributes: .concurrent)
    
    private var array: [Element] = []
    
    func append(_ item: Element) {
        self.queue.async(flags: .barrier) {
            self.array.append(item)
        }
    }
    
    func remove(at index: Int) {
        self.queue.async(flags: .barrier) {
            self.array.remove(at: index)
        }
    }
    
    subscript(index: Int) -> Element {
        get {
            var value: Element?
            self.queue.sync {
                value = self.array[index]
            }
            return value ?? array[0]
        }
        set {
            self.queue.async(flags: .barrier) {
                self.array[index] = newValue
            }
        }
    }
    
}

extension ThreadSafeArray where Element: Equatable {
    
    func contains(_ element: Element) -> Bool {
        var value = false
        self.queue.sync {
            value = self.array.contains { $0 == element }
        }
        return value
    }
    
}
