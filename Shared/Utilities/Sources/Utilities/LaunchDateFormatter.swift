import Foundation

public class LaunchDateFormatter {

    public static let shared = LaunchDateFormatter()

    public func format(_ date: Date?) -> String? {
        guard let date else { return nil }
        return date.formatted(
            .dateTime
                .day().month(.wide)
                .hour(.twoDigits(amPM: .abbreviated)).minute().timeZone()
        )
    }

}
