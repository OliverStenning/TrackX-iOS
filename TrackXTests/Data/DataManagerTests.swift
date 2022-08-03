//
//  DataManagerTests.swift
//  TrackXTests
//
//  Created by Oliver Stenning on 14/07/2022.
//

import XCTest
@testable import TrackX

class DataManagerTests: XCTestCase {
    
    var capsules: [String: Capsule]?
    var cores: [String: Core]?
    var landpads: [String: Landpad]?
    var launches: [String: Launch]?
    var launchpads: [String: Launchpad]?
    var payloads: [String: Payload]?
    var rockets: [String: Rocket]?
    
    override func setUpWithError() throws {

        let dataLoader = TestDataLoader()
        
        let capsulesArray = try XCTUnwrap(dataLoader.getTestObjectFromJson([Capsule].self, name: "allCapsules"))
        let coresArray = try XCTUnwrap(dataLoader.getTestObjectFromJson([Core].self, name: "allCores"))
        let landpadsArray = try XCTUnwrap(dataLoader.getTestObjectFromJson([Landpad].self, name: "allLandpads"))
        let launchesArray = try XCTUnwrap(dataLoader.getTestObjectFromJson([Launch].self, name: "allLaunches"))
        let launchpadsArray = try XCTUnwrap(dataLoader.getTestObjectFromJson([Launchpad].self, name: "allLaunchpads"))
        let payloadsArray = try XCTUnwrap(dataLoader.getTestObjectFromJson([Payload].self, name: "allPayloads"))
        let rocketsArray = try XCTUnwrap(dataLoader.getTestObjectFromJson([Rocket].self, name: "allRockets"))
        
        capsules = Arrays.arrayToDictionary(capsulesArray)
        cores = Arrays.arrayToDictionary(coresArray)
        landpads = Arrays.arrayToDictionary(landpadsArray)
        launches = Arrays.arrayToDictionary(launchesArray)
        launchpads = Arrays.arrayToDictionary(launchpadsArray)
        payloads = Arrays.arrayToDictionary(payloadsArray)
        rockets = Arrays.arrayToDictionary(rocketsArray)
        
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testBuildingFullLaunch() throws {
        // Given
        let dataManager = try LaunchProvider(
            networkManager: NetworkManager(),
            capsules: XCTUnwrap(capsules),
            cores: XCTUnwrap(cores),
            landpads: XCTUnwrap(landpads),
            launches: XCTUnwrap(launches),
            launchpads: XCTUnwrap(launchpads),
            payloads: XCTUnwrap(payloads),
            rockets: XCTUnwrap(rockets)
        )
        
        let launch = try XCTUnwrap(launches?["5eb87cd9ffd86e000604b32a"])
        
        // When
        let fullLaunch = dataManager.createFullLaunch(from: launch)
        
        // Then
        XCTAssertEqual(fullLaunch.launch.id, "5eb87cd9ffd86e000604b32a")
        XCTAssertEqual(fullLaunch.launch.name, "FalconSat")
        XCTAssertEqual(fullLaunch.launch.details, "Engine failure at 33 seconds and loss of vehicle")
        
        XCTAssertEqual(fullLaunch.rocket?.id, "5e9d0d95eda69955f709d1eb")
        XCTAssertEqual(fullLaunch.rocket?.name, "Falcon 1")
        XCTAssertEqual(fullLaunch.rocket?.type, "rocket")
        
        XCTAssertEqual(fullLaunch.launchpad?.id, "5e9e4502f5090995de566f86")
        XCTAssertEqual(fullLaunch.launchpad?.name, "Kwajalein Atoll")
        XCTAssertEqual(fullLaunch.launchpad?.fullName, "Kwajalein Atoll Omelek Island")
        
        XCTAssertNil(fullLaunch.capsules)
        
        XCTAssertEqual(fullLaunch.payloads?[0].id, "5eb0e4b5b6c3bb0006eeb1e1")
        XCTAssertEqual(fullLaunch.payloads?[0].name, "FalconSAT-2")
        XCTAssertEqual(fullLaunch.payloads?[0].type, "Satellite")
        
        XCTAssertEqual(fullLaunch.cores?[0].id, "5e9e289df35918033d3b2623")
        XCTAssertEqual(fullLaunch.cores?[0].serial, "Merlin1A")
        XCTAssertEqual(fullLaunch.cores?[0].lastUpdate, "Engine failure at T+33 seconds resulted in loss of vehicle")
        
        XCTAssertNil(fullLaunch.coreLandpads)
    }
    
}
