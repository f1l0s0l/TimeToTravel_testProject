//
//  DateManager.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 17.05.2023.
//

import Foundation

final class DateManager {
    
    static func createDateFromString(form dateString: String, dateStringFormatter: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateStringFormatter
        return dateFormatter.date(from: dateString)
    }
    
    static func getDateStringWithFormatter(from date: Date, timeZoneInSecondFromGMT: Int = 0, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZoneInSecondFromGMT)
        
        return dateFormatter.string(from: date)
    }
    
    static func getDifferenceFromDateToDate(from date1: Date, to date2: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: date1, to: date2)

        guard let day = components.day else {
            return ""
        }
        return String(day)
    }
}

