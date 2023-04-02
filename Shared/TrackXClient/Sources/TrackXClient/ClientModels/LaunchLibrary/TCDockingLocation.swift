import Foundation

// MARK: - TCDockingLocation

// LaunchLibrary v2.2.0 Schema Name: DockingLocation

struct TCDockingLocation: Codable {

    let id: Int
    let name: String
    let spacestation: TCSpaceStationDock

}
