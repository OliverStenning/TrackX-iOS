// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
public typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum RKFonts {
  public enum Archivo {
    public static let black = FontConvertible(name: "Archivo-Black", family: "Archivo", path: "Archivo-Black.ttf")
    public static let bold = FontConvertible(name: "Archivo-Bold", family: "Archivo", path: "Archivo-Bold.ttf")
    public static let extraBold = FontConvertible(name: "Archivo-ExtraBold", family: "Archivo", path: "Archivo-ExtraBold.ttf")
    public static let extraLight = FontConvertible(name: "Archivo-ExtraLight", family: "Archivo", path: "Archivo-ExtraLight.ttf")
    public static let light = FontConvertible(name: "Archivo-Light", family: "Archivo", path: "Archivo-Light.ttf")
    public static let medium = FontConvertible(name: "Archivo-Medium", family: "Archivo", path: "Archivo-Medium.ttf")
    public static let regular = FontConvertible(name: "Archivo-Regular", family: "Archivo", path: "Archivo-Regular.ttf")
    public static let semiBold = FontConvertible(name: "Archivo-SemiBold", family: "Archivo", path: "Archivo-SemiBold.ttf")
    public static let thin = FontConvertible(name: "Archivo-Thin", family: "Archivo", path: "Archivo-Thin.ttf")
    public static let all: [FontConvertible] = [black, bold, extraBold, extraLight, light, medium, regular, semiBold, thin]
  }
  public enum Lato {
    public static let black = FontConvertible(name: "Lato-Black", family: "Lato", path: "Lato-Black.ttf")
    public static let bold = FontConvertible(name: "Lato-Bold", family: "Lato", path: "Lato-Bold.ttf")
    public static let regular = FontConvertible(name: "Lato-Regular", family: "Lato", path: "Lato-Regular.ttf")
    public static let all: [FontConvertible] = [black, bold, regular]
  }
  public enum Poppins {
    public static let black = FontConvertible(name: "Poppins-Black", family: "Poppins", path: "Poppins-Black.ttf")
    public static let blackItalic = FontConvertible(name: "Poppins-BlackItalic", family: "Poppins", path: "Poppins-BlackItalic.ttf")
    public static let bold = FontConvertible(name: "Poppins-Bold", family: "Poppins", path: "Poppins-Bold.ttf")
    public static let boldItalic = FontConvertible(name: "Poppins-BoldItalic", family: "Poppins", path: "Poppins-BoldItalic.ttf")
    public static let extraBold = FontConvertible(name: "Poppins-ExtraBold", family: "Poppins", path: "Poppins-ExtraBold.ttf")
    public static let extraBoldItalic = FontConvertible(name: "Poppins-ExtraBoldItalic", family: "Poppins", path: "Poppins-ExtraBoldItalic.ttf")
    public static let extraLight = FontConvertible(name: "Poppins-ExtraLight", family: "Poppins", path: "Poppins-ExtraLight.ttf")
    public static let extraLightItalic = FontConvertible(name: "Poppins-ExtraLightItalic", family: "Poppins", path: "Poppins-ExtraLightItalic.ttf")
    public static let italic = FontConvertible(name: "Poppins-Italic", family: "Poppins", path: "Poppins-Italic.ttf")
    public static let light = FontConvertible(name: "Poppins-Light", family: "Poppins", path: "Poppins-Light.ttf")
    public static let lightItalic = FontConvertible(name: "Poppins-LightItalic", family: "Poppins", path: "Poppins-LightItalic.ttf")
    public static let medium = FontConvertible(name: "Poppins-Medium", family: "Poppins", path: "Poppins-Medium.ttf")
    public static let mediumItalic = FontConvertible(name: "Poppins-MediumItalic", family: "Poppins", path: "Poppins-MediumItalic.ttf")
    public static let regular = FontConvertible(name: "Poppins-Regular", family: "Poppins", path: "Poppins-Regular.ttf")
    public static let semiBold = FontConvertible(name: "Poppins-SemiBold", family: "Poppins", path: "Poppins-SemiBold.ttf")
    public static let semiBoldItalic = FontConvertible(name: "Poppins-SemiBoldItalic", family: "Poppins", path: "Poppins-SemiBoldItalic.ttf")
    public static let thin = FontConvertible(name: "Poppins-Thin", family: "Poppins", path: "Poppins-Thin.ttf")
    public static let thinItalic = FontConvertible(name: "Poppins-ThinItalic", family: "Poppins", path: "Poppins-ThinItalic.ttf")
    public static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBold, extraBoldItalic, extraLight, extraLightItalic, italic, light, lightItalic, medium, mediumItalic, regular, semiBold, semiBoldItalic, thin, thinItalic]
  }
  public enum Rubik {
    public static let black = FontConvertible(name: "Rubik-Black", family: "Rubik", path: "Rubik-Black.ttf")
    public static let bold = FontConvertible(name: "Rubik-Bold", family: "Rubik", path: "Rubik-Bold.ttf")
    public static let extraBold = FontConvertible(name: "Rubik-ExtraBold", family: "Rubik", path: "Rubik-ExtraBold.ttf")
    public static let light = FontConvertible(name: "Rubik-Light", family: "Rubik", path: "Rubik-Light.ttf")
    public static let medium = FontConvertible(name: "Rubik-Medium", family: "Rubik", path: "Rubik-Medium.ttf")
    public static let regular = FontConvertible(name: "Rubik-Regular", family: "Rubik", path: "Rubik-Regular.ttf")
    public static let semiBold = FontConvertible(name: "Rubik-SemiBold", family: "Rubik", path: "Rubik-SemiBold.ttf")
    public static let all: [FontConvertible] = [black, bold, extraBold, light, medium, regular, semiBold]
  }
  public enum ShareTech {
    public static let regular = FontConvertible(name: "ShareTech-Regular", family: "Share Tech", path: "ShareTech-Regular.ttf")
    public static let all: [FontConvertible] = [regular]
  }
  public enum SpaceGrotesk {
    public static let bold = FontConvertible(name: "SpaceGrotesk-Bold", family: "Space Grotesk", path: "SpaceGrotesk-Bold.ttf")
    public static let light = FontConvertible(name: "SpaceGrotesk-Light", family: "Space Grotesk", path: "SpaceGrotesk-Light.ttf")
    public static let medium = FontConvertible(name: "SpaceGrotesk-Medium", family: "Space Grotesk", path: "SpaceGrotesk-Medium.ttf")
    public static let regular = FontConvertible(name: "SpaceGrotesk-Regular", family: "Space Grotesk", path: "SpaceGrotesk-Regular.ttf")
    public static let semiBold = FontConvertible(name: "SpaceGrotesk-SemiBold", family: "Space Grotesk", path: "SpaceGrotesk-SemiBold.ttf")
    public static let all: [FontConvertible] = [bold, light, medium, regular, semiBold]
  }
  public static let allCustomFonts: [FontConvertible] = [Archivo.all, Lato.all, Poppins.all, Rubik.all, ShareTech.all, SpaceGrotesk.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct FontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(macOS)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  public func swiftUIFont(fixedSize: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, fixedSize: fixedSize)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  public func swiftUIFont(size: CGFloat, relativeTo textStyle: SwiftUI.Font.TextStyle) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size, relativeTo: textStyle)
  }
  #endif

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate func registerIfNeeded() {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: family).contains(name) {
      register()
    }
    #elseif os(macOS)
    if let url = url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      register()
    }
    #endif
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

public extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    font.registerIfNeeded()
    self.init(name: font.name, size: size)
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, size: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size)
  }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
public extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, fixedSize: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, fixedSize: fixedSize)
  }

  static func custom(
    _ font: FontConvertible,
    size: CGFloat,
    relativeTo textStyle: SwiftUI.Font.TextStyle
  ) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size, relativeTo: textStyle)
  }
}
#endif

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
