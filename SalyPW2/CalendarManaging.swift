//
//  CalendarManaging.swift
//  SalyPW2
//
//  Created by seif on 06/02/2024.
//

import EventKit

protocol CalendarManaging {
 func create(eventModel: CalendarEventModel) -> Bool
}
