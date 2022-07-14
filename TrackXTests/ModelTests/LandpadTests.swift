//
//  LandpadTests.swift
//  TrackXTests
//
//  Created by Oliver Stenning on 14/07/2022.
//

import XCTest
@testable import TrackX

class LandpadTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testLandpadParsing() throws {
        // Given
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "landpad", withExtension: "json") else {
            XCTFail("Missing file: landpad.json")
            return
        }
        let json = try Data(contentsOf: url)
    
        // When
        let landpad = try JSONDecoder().decode(Landpad.self, from: json)
        
        // Then
        XCTAssertEqual(landpad.id, "5e9e3032383ecb90a834e7c8")
        XCTAssertEqual(landpad.name, "LZ-2")
        XCTAssertEqual(landpad.fullName, "Landing Zone 2")
    }
    
}
