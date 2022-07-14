//
//  CapsuleTests.swift
//  TrackXTests
//
//  Created by Oliver Stenning on 14/07/2022.
//

import XCTest
@testable import TrackX

class CapsuleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testCapsuleParsing() throws {
        // Given
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "capsule", withExtension: "json") else {
            XCTFail("Missing file: capsule.json")
            return
        }
        let json = try Data(contentsOf: url)
    
        // When
        let capsule = try JSONDecoder().decode(Capsule.self, from: json)
        
        // Then
        XCTAssertEqual(capsule.id, "5e9e2c5bf35918ed873b2664")
        XCTAssertEqual(capsule.serial, "C101")
        XCTAssertEqual(capsule.lastUpdate, "Hanging in atrium at SpaceX HQ in Hawthorne ")
    }
    
}
