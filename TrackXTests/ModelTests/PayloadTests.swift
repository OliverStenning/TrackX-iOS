//
//  PayloadTests.swift
//  TrackXTests
//
//  Created by Oliver Stenning on 14/07/2022.
//

import XCTest
@testable import TrackX

class PayloadTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testPayloadParsing() throws {
        // Given
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "payload", withExtension: "json") else {
            XCTFail("Missing file: payload.json")
            return
        }
        let json = try Data(contentsOf: url)
    
        // When
        let payload = try JSONDecoder().decode(Payload.self, from: json)
        
        // Then
        XCTAssertEqual(payload.id, "5eb0e4c6b6c3bb0006eeb21e")
        XCTAssertEqual(payload.name, "Tintin A & B")
        XCTAssertEqual(payload.type, "Satellite")
    }
    
}
