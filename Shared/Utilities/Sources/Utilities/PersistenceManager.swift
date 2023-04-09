import Foundation

// MARK: - PersistenceManaging

public protocol PersistenceManaging {

    func setString(_ value: String, forKey key: PersistedStrings)
    func string(forKey key: PersistedStrings) -> String?
    func setInteger(_ value: Int, forKey key: PersistedInts)
    func incrementInteger(forKey key: PersistedInts)
    func integer(forKey key: PersistedInts) -> Int
    func setDouble(_ value: Double, forKey key: PersistedDoubles)
    func double(forKey key: PersistedDoubles) -> Double
    func setBool(_ value: Bool, forKey key: PersistedBools)
    func bool(forKey key: PersistedBools) -> Bool
    func setDate(_ value: Date, forKey key: PersistedDates)
    func date(forKey key: PersistedDates) -> Date?

}

// MARK: - PersistenceManager

public final class PersistenceManager: PersistenceManaging {

    // MARK: Public

    public static let shared = PersistenceManager()

    public func setString(_ value: String, forKey key: PersistedStrings) {
        defaults.set(value, forKey: key.keyString)
    }

    public func string(forKey key: PersistedStrings) -> String? {
        defaults.string(forKey: key.keyString)
    }

    public func setInteger(_ value: Int, forKey key: PersistedInts) {
        defaults.set(value, forKey: key.keyString)
    }

    public func incrementInteger(forKey key: PersistedInts) {
        defaults.set(defaults.integer(forKey: key.keyString) + 1, forKey: key.keyString)
    }

    public func integer(forKey key: PersistedInts) -> Int {
        defaults.integer(forKey: key.keyString)
    }

    public func setDouble(_ value: Double, forKey key: PersistedDoubles) {
        defaults.set(value, forKey: key.keyString)
    }

    public func double(forKey key: PersistedDoubles) -> Double {
        defaults.double(forKey: key.keyString)
    }

    public func setBool(_ value: Bool, forKey key: PersistedBools) {
        defaults.set(value, forKey: key.keyString)
    }

    public func bool(forKey key: PersistedBools) -> Bool {
        defaults.bool(forKey: key.keyString)
    }

    public func setDate(_ value: Date, forKey key: PersistedDates) {
        let timeInterval = value.timeIntervalSince1970
        defaults.set(timeInterval, forKey: key.keyString)
    }

    public func date(forKey key: PersistedDates) -> Date? {
        let timeInterval = defaults.double(forKey: key.keyString)
        guard timeInterval != 0 else { return nil }
        return Date(timeIntervalSince1970: timeInterval)
    }

    // MARK: Private

    private let defaults = UserDefaults.standard

}
