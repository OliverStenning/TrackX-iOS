import Foundation

// MARK: - PersistedStrings

public enum PersistedStrings: String {

    case tempCase

    // MARK: Internal

    var keyString: String {
        "PersistedStrings.\(rawValue)"
    }

}

// MARK: - PersistedInts

public enum PersistedInts: String {

    case numberOfAppLaunches

    // MARK: Internal

    var keyString: String {
        "PersistedInt.\(rawValue)"
    }

}

// MARK: - PersistedDoubles

public enum PersistedDoubles: String {

    case tempCase

    // MARK: Internal

    var keyString: String {
        "PersistedDouble.\(rawValue)"
    }

}

// MARK: - PersistedBools

public enum PersistedBools: String {

    case tempCase

    // MARK: Internal

    var keyString: String {
        "PersistedBool.\(rawValue)"
    }

}

// MARK: - PersistedDates

public enum PersistedDates: String {

    case firstAppLaunchDate

    // MARK: Internal

    var keyString: String {
        "PersistedDate.\(rawValue)"
    }

}
