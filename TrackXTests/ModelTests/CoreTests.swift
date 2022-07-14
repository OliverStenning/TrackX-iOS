//
//  CoreTests.swift
//  TrackXTests
//
//  Created by Oliver Stenning on 14/07/2022.
//

import XCTest
@testable import TrackX

class CoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testCoreParsing() throws {
        // Given
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "core", withExtension: "json") else {
            XCTFail("Missing file: core.json")
            return
        }
        let json = try Data(contentsOf: url)
    
        // When
        let core = try JSONDecoder().decode(Core.self, from: json)
        
        // Then
        XCTAssertEqual(core.id, "5e9e28a6f35918c0803b265c")
        XCTAssertEqual(core.serial, "B1051")
        XCTAssertEqual(core.lastUpdate, "Landed on JRTI as of Mar 19, 2022.")
    }
    
}
