//
//  CalendarHelper.swift
//  NewCalendar
//
//  Created by Victor Capilla Borrego on 23/3/18.
//  Copyright © 2018 Victor Capilla Borrego. All rights reserved.
//

import Foundation

// Return the number of days that have one month in one year
func getNumberOfDaysInMonth(_ month: Int, _ year: Int) -> Int {
    let dateComponents = DateComponents(year: year, month: month + 1)
    let calendar = Calendar.current
    let date = calendar.date(from: dateComponents)!
    
    let range = calendar.range(of: .day, in: .month, for: date)!
    return range.count
}

// Return days names from monday to sunday
func getWeekDaysName() -> [String] {
    let f = DateFormatter()
    f.locale = Locale(identifier: specialLocale)
    var days = f.shortStandaloneWeekdaySymbols
    
    if f.calendar.firstWeekday == 2 {
        let first = days!.removeFirst()
        days!.append(first)
    }
    
    return days!
}

//Return months name from Jenuary to December
func getMonthsNames() -> [String] {
    let f = DateFormatter()
    f.locale = Locale(identifier: specialLocale)
    
    let months = f.monthSymbols
    return months!
}
