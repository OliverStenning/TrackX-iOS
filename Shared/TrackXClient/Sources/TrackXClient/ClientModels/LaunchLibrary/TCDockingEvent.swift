import Foundation

// MARK: - TCDockingEvent

// LaunchLibrary v2.2.0 Schema Name: DockingEventSerializerForSpacecraftFlight

struct TCDockingEvent: Codable {

    let spacestation: TCSpaceStation
    let docking: String
    let departure: String?
    let dockingLocation: TCDockingLocation

}
