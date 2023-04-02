import Foundation

// MARK: - TCSpacecraftStage

// LaunchLibrary v2.2.0 Schema Name: SpacecraftFlightDetailedSerializerForLaunch

struct TCSpacecraftStage: Codable {

    let id: Int
    let url: String
    let missionEnd: String?
    let destination: String?
    let launchCrew: [TCAstronautFlight]
    let onboardCrew: [TCAstronautFlight]
    let landingCrew: [TCAstronautFlight]
    let spacecraft: TCSpacecraft
    let dockingEvents: [TCDockingEvent]

}
