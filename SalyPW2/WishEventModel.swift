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
    let startDate: String
    let endDate: String

    init(title: String, description: String, startDate: String, endDate: String) {
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
}
