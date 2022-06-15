//
//  StringFormatting.swift
//  TrackX
//
//  Created by Oliver Stenning on 05/06/2022.
//

import Foundation

enum DateFormat {
    case shortDate
    case longDate
    case shortDateAndTime
    case longDateAndTime
    case time
}

func formatDate(from inputDate: String, as dateFormat: DateFormat = DateFormat.shortDateAndTime) -> String {
    let dateFormatterStart = ISO8601DateFormatter()
    dateFormatterStart.formatOptions.insert(.withFractionalSeconds)
    
    let dateFormatterEnd = DateFormatter()
    switch dateFormat {
        case .shortDate:
            dateFormatterEnd.dateFormat = "d MMM yyyy"
        case .longDate:
            dateFormatterEnd.dateFormat = "d MMMM yyyy"
        case .shortDateAndTime:
            dateFormatterEnd.dateFormat = "d MMM yyyy, h:mm a"
        case .longDateAndTime:
            dateFormatterEnd.dateFormat = "d MMM yyyy, h:mm a"
        case .time:
            dateFormatterEnd.dateFormat = "h:mm a"
    }
    
    if let date = dateFormatterStart.date(from: inputDate) {
        return dateFormatterEnd.string(from: date)
    } else {
        print(inputDate)
        return "Bad date"
    }
}
