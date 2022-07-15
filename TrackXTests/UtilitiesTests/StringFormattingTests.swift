//
//  StringFormattingTests.swift
//  TrackXTests
//
//  Created by Oliver Stenning on 15/07/2022.
//

import XCTest
@testable import TrackX

class StringFormattingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFormatDate() throws {
        // Given
        let date = "2022-07-11T01:39:00.000Z"

        // When
        let shortDate = formatDate(from: date, as: .shortDate, timeZone: "UTC")
        let longDate = formatDate(from: date, as: .longDate, timeZone: "UTC")
        let shortDateAndTime = formatDate(from: date, as: .shortDateAndTime, timeZone: "UTC")
        let longDateAndTime = formatDate(from: date, as: .longDateAndTime, timeZone: "UTC")
        let time = formatDate(from: date, as: .time, timeZone: "UTC")
        
        // Then
        XCTAssertEqual(shortDate, "11 Jul 2022")
        XCTAssertEqual(longDate, "11 July 2022")
        XCTAssertEqual(shortDateAndTime, "11 Jul 2022, 1:39 AM")
        XCTAssertEqual(longDateAndTime, "11 July 2022, 1:39 AM")
        XCTAssertEqual(time, "1:39 AM")
        
    }
    
}
