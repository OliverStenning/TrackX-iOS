import Foundation

public struct Rocket: Hashable {

    // MARK: Lifecycle

    init(from rocket: TCRocket) {
        id = rocket.configuration.id
        url = rocket.configuration.url
        name = rocket.configuration.name
        family = rocket.configuration.family
        fullName = rocket.configuration.fullName
        variant = rocket.configuration.variant
    }

    // MARK: Public

    public let id: Int
    public let url: String
    public let name: String
    public let family: String?
    public let fullName: String?
    public let variant: String?

}
