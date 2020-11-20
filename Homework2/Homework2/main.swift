//
//  main.swift
//  Homework2
//
//  Created by Михаил Жданов on 25.10.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import Foundation

var safeArray = ThreadSafeArray<Int>()

let group = DispatchGroup()
let queue = DispatchQueue.global(qos: .userInteractive)

group.enter()
queue.async {
    for index in 0 ..< 1000 {
        safeArray.append(index)
    }
    group.leave()
}

group.enter()
queue.async {
    for index in 0 ..< 1000 {
        safeArray.append(index)
    }
    group.leave()
}

group.wait()
print("Элементов в потокобезопасном массиве: \(safeArray.count)")
