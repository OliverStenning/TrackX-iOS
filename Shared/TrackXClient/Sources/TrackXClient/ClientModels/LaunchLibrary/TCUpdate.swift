import Foundation

// MARK: - TCUpdate

// LaunchLibrary v2.2.0 Schema Name: Update

struct TCUpdate: Codable {

    let id: Int
    let profileImage: String
    let comment: String?
    let infoUrl: String?
    let createdBy: String
    let createdOn: String

}
