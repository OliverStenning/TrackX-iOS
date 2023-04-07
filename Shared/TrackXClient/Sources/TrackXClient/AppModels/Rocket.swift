import Foundation

// MARK: - Rocket

public struct Rocket: Hashable {

    // MARK: Lifecycle

    init(from rocket: TCRocket) {
        id = rocket.configuration.id
        url = rocket.configuration.url
        name = rocket.configuration.name
        active = rocket.configuration.active
        reusable = rocket.configuration.reusable
        description = rocket.configuration.description
        family = rocket.configuration.family
        fullName = rocket.configuration.fullName
        manufacturer = Agency(from: rocket.configuration.manufacturer)
        program = rocket.configuration.program.map { Program(from: $0) }
        variant = rocket.configuration.variant
        alias = rocket.configuration.alias
        minStage = rocket.configuration.minStage
        maxStage = rocket.configuration.maxStage
        length = rocket.configuration.length
        diameter = rocket.configuration.diameter
        maidenFlight = rocket.configuration.maidenFlight
        launchCost = rocket.configuration.launchCost
        launchMass = rocket.configuration.launchMass
        leoCapacity = rocket.configuration.leoCapacity
        gtoCapacity = rocket.configuration.gtoCapacity
        toThrust = rocket.configuration.toThrust
        apogee = rocket.configuration.apogee
        vehicleRange = rocket.configuration.vehicleRange
        imageUrl = rocket.configuration.imageUrl
        infoUrl = rocket.configuration.infoUrl
        wikiUrl = rocket.configuration.wikiUrl
        totalLaunchCount = rocket.configuration.totalLaunchCount
        consecutiveSuccessfulLaunches = rocket.configuration.consecutiveSuccessfulLaunches
        successfulLaunches = rocket.configuration.successfulLaunches
        failedLaunches = rocket.configuration.failedLaunches
        pendingLaunches = rocket.configuration.pendingLaunches

        launcherStage = rocket.launcherStage.map { FirstStage(from: $0) }
        spacecraftStage = rocket.spacecraftStage.map { SpacecraftStage(from: $0) }
    }

    // MARK: Public

    // Launcher Config
    public let id: Int
    public let url: String
    public let name: String
    public let active: Bool?
    public let reusable: Bool?
    public let description: String?
    public let family: String?
    public let fullName: String?
    public let manufacturer: Agency
    public let program: [Program]
    public let variant: String?
    public let alias: String?
    public let minStage: Int?
    public let maxStage: Int?
    public let length: Double?
    public let diameter: Double?
    public let maidenFlight: String?
    public let launchCost: String?
    public let launchMass: Int?
    public let leoCapacity: Int?
    public let gtoCapacity: Int?
    public let toThrust: Int?
    public let apogee: Int?
    public let vehicleRange: Int?
    public let imageUrl: String?
    public let infoUrl: String?
    public let wikiUrl: String?
    public let totalLaunchCount: Int?
    public let consecutiveSuccessfulLaunches: Int?
    public let successfulLaunches: Int?
    public let failedLaunches: Int?
    public let pendingLaunches: Int?

    public let launcherStage: [FirstStage]
    public let spacecraftStage: SpacecraftStage?

}
