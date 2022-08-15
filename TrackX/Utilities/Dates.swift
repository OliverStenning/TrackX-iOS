//
//  Dates.swift
//  TrackX
//
//  Created by Oliver Stenning on 14/08/2022.
//

import Foundation

struct Dates {
    
    static func dateFromISO8601(_ inputDate: String) -> Date? {
        let dateFormatterStart = ISO8601DateFormatter()
        dateFormatterStart.formatOptions.insert(.withFractionalSeconds)
        
        return dateFormatterStart.date(from: inputDate)
    }
    
}
