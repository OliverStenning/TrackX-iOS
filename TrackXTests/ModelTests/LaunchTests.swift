//
//  LaunchTests.swift
//  TrackXTests
//
//  Created by Oliver Stenning on 13/07/2022.
//

import XCTest
@testable import TrackX

class LaunchTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testLaunchParsing() throws {
        // Given
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "launch", withExtension: "json") else {
            XCTFail("Missing file: launch.json")
            return
        }
        let json = try Data(contentsOf: url)
    
        // When
        let launch = try JSONDecoder().decode(Launch.self, from: json)
        
        // Then
        XCTAssertEqual(launch.id, "62a9f0e320413d2695d88713")
        XCTAssertEqual(launch.name, "Starlink 3-1 (v1.5)")
        XCTAssertEqual(launch.details, nil)
    }
    
}
