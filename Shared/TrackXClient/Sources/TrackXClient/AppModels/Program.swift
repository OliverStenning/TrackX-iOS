import Foundation

// MARK: - Program

public struct Program: Hashable {

    // MARK: Lifecycle

    init(from program: TCProgram) {
        id = program.id
        url = program.url
        name = program.name
        description = program.description
        agencies = program.agencies.map { Agency(from: $0) }
        imageUrl = program.imageUrl
        startDate = program.startDate
        endDate = program.endDate
        infoUrl = program.infoUrl
        wikiUrl = program.wikiUrl
    }

    // MARK: Public

    public let id: Int
    public let url: String
    public let name: String
    public let description: String?
    public let agencies: [Agency]
    public let imageUrl: String
    public let startDate: String?
    public let endDate: String?
    public let infoUrl: String?
    public let wikiUrl: String?

}
