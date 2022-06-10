//
//  Date+Extensions.swift
//  TrackX
//
//  Created by Oliver Stenning on 10/06/2022.
//

import Foundation

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func startOfYear() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfYear() -> Date {
        return Calendar.current.date(byAdding: DateComponents(year: 1, day: -1), to: self.startOfYear())!
    }
}
