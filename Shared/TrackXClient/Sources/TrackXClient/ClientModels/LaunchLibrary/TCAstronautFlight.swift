import Foundation

// MARK: - TCAstronautFlight

// LaunchLibrary v2.2.0 Schema Name: AstronautFlight

struct TCAstronautFlight: Codable {

    let id: Int
    let role: TCAstronautRole
    let astronaut: TCAstronaut

}
