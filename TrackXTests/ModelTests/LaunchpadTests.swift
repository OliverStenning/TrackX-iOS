//
//  LaunchpadTests.swift
//  TrackXTests
//
//  Created by Oliver Stenning on 14/07/2022.
//

import XCTest
@testable import TrackX

class LaunchpadTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testLaunchpadParsing() throws {
        // Given
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "launchpad", withExtension: "json") else {
            XCTFail("Missing file: launchpad.json")
            return
        }
        let json = try Data(contentsOf: url)
    
        // When
        let launchpad = try JSONDecoder().decode(Launchpad.self, from: json)
        
        // Then
        XCTAssertEqual(launchpad.id, "5e9e4502f509092b78566f87")
        XCTAssertEqual(launchpad.name, "VAFB SLC 4E")
        XCTAssertEqual(launchpad.fullName, "Vandenberg Space Force Base Space Launch Complex 4E")
    }
    
}
