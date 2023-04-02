import Foundation

// MARK: - TCAstronaut

// LaunchLibrary v2.2.0 Schema Name: AstronautDetailedSerializerNoFlights

struct TCAstronaut: Codable {

    let id: Int
    let url: String
    let name: String
    let type: TCAstronautType
    let status: TCAstronautStatus
    let agency: TCAgency
    let dateOfBirth: String?
    let dateOfDeath: String?
    let nationality: String
    let twitter: String?
    let instagram: String?
    let bio: String
    let profileImage: String?
    let wiki: String?
    let lastFlight: String?
    let firstFlight: String?

}
