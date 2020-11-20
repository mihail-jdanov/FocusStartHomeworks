//
//  DateFormatter.swift
//  Homework4
//
//  Created by Михаил Жданов on 08.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static func shortTimeString(from date: Date?) -> String? {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        if let date = date {
            return formatter.string(from: date)
        }
        return nil
    }
    
}
