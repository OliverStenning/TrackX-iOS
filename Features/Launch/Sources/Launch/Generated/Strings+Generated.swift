// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum LaunchDetails {
    internal enum Launchpad {
      /// Launchpad
      internal static let header = L10n.tr("Localizable", "LaunchDetails.Launchpad.header", fallback: "Launchpad")
    }
    internal enum Rocket {
      /// Rocket
      internal static let header = L10n.tr("Localizable", "LaunchDetails.Rocket.header", fallback: "Rocket")
      internal enum Label {
        /// Name
        internal static let name = L10n.tr("Localizable", "LaunchDetails.Rocket.Label.name", fallback: "Name")
      }
    }
  }
  internal enum LaunchDetauls {
    internal enum Rocket {
      internal enum Label {
        /// Full name
        internal static let fullName = L10n.tr("Localizable", "LaunchDetauls.Rocket.Label.fullName", fallback: "Full name")
      }
    }
  }
  internal enum LaunchInfoView {
    internal enum Date {
      /// Unknown
      internal static let unknown = L10n.tr("Localizable", "LaunchInfoView.Date.unknown", fallback: "Unknown")
    }
    internal enum Name {
      /// Unknown
      internal static let unknown = L10n.tr("Localizable", "LaunchInfoView.Name.unknown", fallback: "Unknown")
    }
  }
  internal enum LaunchPage {
    internal enum Button {
      /// View details
      internal static let viewDetails = L10n.tr("Localizable", "LaunchPage.Button.viewDetails", fallback: "View details")
    }
  }
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
