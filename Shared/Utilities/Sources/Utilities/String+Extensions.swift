import Foundation

public extension String {

    func convertToDate() -> Date? {
        let expectedFormat = Date.ISO8601FormatStyle()
        do {
            let date = try Date(self, strategy: expectedFormat)
            return date
        } catch {
            // TODO: Add logging here
            return nil
        }
    }

}
