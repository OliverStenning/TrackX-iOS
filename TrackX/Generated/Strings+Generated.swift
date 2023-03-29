// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
    /// About
    internal static let about = L10n.tr("Localizable", "About", fallback: "About")
    /// All
    internal static let all = L10n.tr("Localizable", "All", fallback: "All")
    /// Dismiss
    internal static let dismiss = L10n.tr("Localizable", "Dismiss", fallback: "Dismiss")
    /// Explore
    internal static let explore = L10n.tr("Localizable", "Explore", fallback: "Explore")
    /// Latest Photos
    internal static let latestPhotos = L10n.tr("Localizable", "Latest Photos", fallback: "Latest Photos")
    /// Launches
    internal static let launches = L10n.tr("Localizable", "Launches", fallback: "Launches")
    /// Network Issue
    internal static let networkIssue = L10n.tr("Localizable", "Network Issue", fallback: "Network Issue")
    /// Recent
    internal static let recent = L10n.tr("Localizable", "Recent", fallback: "Recent")
    /// Rockets
    internal static let rockets = L10n.tr("Localizable", "Rockets", fallback: "Rockets")
    /// Scheduled
    internal static let scheduled = L10n.tr("Localizable", "Scheduled", fallback: "Scheduled")
    /// Settings
    internal static let settings = L10n.tr("Localizable", "Settings", fallback: "Settings")
    /// Show all
    internal static let showAll = L10n.tr("Localizable", "Show all", fallback: "Show all")
    /// Unable to connect to server. Check your network connection.
    internal static let unableToConnect = L10n.tr("Localizable", "Unable to connect", fallback: "Unable to connect to server. Check your network connection.")
    /// Unknown
    internal static let unknown = L10n.tr("Localizable", "Unknown", fallback: "Unknown")
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type
