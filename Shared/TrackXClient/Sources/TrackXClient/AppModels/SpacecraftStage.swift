import Foundation

// MARK: - SpacecraftStage

public struct SpacecraftStage: Hashable {

    // MARK: Lifecycle

    init(from spacecraftStage: TCSpacecraftStage) {
        id = spacecraftStage.id
        url = spacecraftStage.url
        missionEnd = spacecraftStage.missionEnd
        destination = spacecraftStage.destination
        spacecraft = Spacecraft(from: spacecraftStage.spacecraft)
    }

    // MARK: Public

    public let id: Int
    public let url: String
    public let missionEnd: String?
    public let destination: String?
    public let spacecraft: Spacecraft

}
