//
//  RocketTests.swift
//  TrackXTests
//
//  Created by Oliver Stenning on 14/07/2022.
//

import XCTest
@testable import TrackX

class RocketTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testRocketParsing() throws {
        // Given
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "rocket", withExtension: "json") else {
            XCTFail("Missing file: rocket.json")
            return
        }
        let json = try Data(contentsOf: url)
    
        // When
        let rocket = try JSONDecoder().decode(Rocket.self, from: json)
        
        // Then
        XCTAssertEqual(rocket.id, "5e9d0d95eda69974db09d1ed")
        XCTAssertEqual(rocket.name, "Falcon Heavy")
        XCTAssertEqual(rocket.type, "rocket")
    }
    
}
