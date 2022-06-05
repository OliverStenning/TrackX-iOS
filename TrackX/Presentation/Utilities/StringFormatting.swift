//
//  StringFormatting.swift
//  TrackX
//
//  Created by Oliver Stenning on 05/06/2022.
//

import Foundation

func formatDate(from inputDate: String) -> String {
    let dateFormatterStart = ISO8601DateFormatter()
    dateFormatterStart.formatOptions.insert(.withFractionalSeconds)
    
    let dateFormatterEnd = DateFormatter()
    dateFormatterEnd.dateFormat = "MMMM d, h:mm a"
    
    
    if let date = dateFormatterStart.date(from: inputDate) {
        return dateFormatterEnd.string(from: date)
    } else {
        print(inputDate)
        return "Bad date"
    }
}
