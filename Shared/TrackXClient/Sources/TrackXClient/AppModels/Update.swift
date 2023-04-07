import Foundation

// MARK: - Update

public struct Update: Hashable {

    // MARK: Lifecycle

    init(from update: TCUpdate) {
        id = update.id
        profileImage = update.profileImage
        comment = update.comment
        infoUrl = update.infoUrl
        createdOn = update.createdOn.convertToDate()
    }

    // MARK: Public

    public let id: Int
    public let profileImage: String
    public let comment: String?
    public let infoUrl: String?
    public let createdOn: Date?

}
