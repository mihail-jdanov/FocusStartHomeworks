//
//  ArticlesProvider.swift
//  Homework4
//
//  Created by Михаил Жданов on 04.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import Foundation

class ArticlesProvider {
    
    static let articles: [Article] = [
        .init(
            title: "Заголовок",
            description: "Какое-то описание статьи.",
            date: Date(timeIntervalSince1970: 1604478390),
            firstImageName: "Article1-1",
            secondImageName: "Article1-2"
        ),
        .init(
            title: "Заголовок 2\nВторая строка заголовка",
            description: "Какое-то описание статьи.",
            date: Date(timeIntervalSince1970: 1604478390),
            firstImageName: "Article2-1",
            secondImageName: "Article2-2"
        ),
        .init(
            title: "Заголовок 3",
            description: "Здесь тоже должно быть какое-то описание, более длинное и подробное.",
            date: nil,
            firstImageName: "Article3-1",
            secondImageName: "Article3-2"
        ),
        .init(
            title: "Заголовок 4",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore "
                + "et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
                + "aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse "
                + "cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
                + "culpa qui officia deserunt mollit anim id est laborum.",
            date: Date(timeIntervalSince1970: 1604514515),
            firstImageName: "Article4-1",
            secondImageName: "Article4-2"
        ),
        .init(
            title: "Заголовок 5",
            description: nil,
            date: nil,
            firstImageName: "Article5-1",
            secondImageName: "Article5-2"
        )
    ]
    
}
