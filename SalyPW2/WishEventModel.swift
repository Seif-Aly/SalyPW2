//
//  WishEventModel.swift
//  SalyPW2
//
//  Created by seif on 06/02/2024.
//

import UIKit

class WishEventModel{
    let title: String
    let description: String
    let startDate: Date
    let endDate: Date

    init(title: String, description: String, startDate: Date, endDate: Date) {
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
}
