//
//  FullLaunchTests.swift
//  TrackXTests
//
//  Created by Oliver Stenning on 14/07/2022.
//

import XCTest
@testable import TrackX

class FullLaunchTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let testDataLoader = TestDataLoader()
        
        guard let launches = try? testDataLoader.getTestObjectFromJson([Launch].self, name: "allLaunches") else {
            return
        }
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testBuildingFullLaunch() throws {
        // Given
    
        // When

        // Then

    }
    
}
