//
//  ArticlesProvider.swift
//  Homework4
//
//  Created by Михаил Жданов on 04.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import Foundation

class ArticlesProvider {
    
    static let data: [Article] = [
        .init(
            title: "Заголовок",
            description: "Текст текст",
            date: Date(timeIntervalSince1970: 1604478390),
            text: "Какой-то текст",
            firstImageName: "Article1-1",
            secondImageName: "Article1-2"
        ),
        .init(
            title: "Заголовок 2",
            description: "Много текста",
            date: Date(timeIntervalSince1970: 1604514515),
            text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore "
                + "et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
                + "aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse "
                + "cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
                + "culpa qui officia deserunt mollit anim id est laborum.",
            firstImageName: "Article2-1",
            secondImageName: "Article2-2"
        )
    ]
    
}
