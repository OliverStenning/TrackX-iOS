import Foundation

// MARK: - TCRocket

// LaunchLibrary v2.2.0 Schema Name: RocketDetailed

struct TCRocket: Codable {

    let id: Int
    let configuration: TCLauncherConfig
    let launcherStage: [TCFirstStage]
    let spacecraftStage: TCSpacecraftStage?

}
