import UIKit

// MARK: - RKFontStyle

public enum RKFontStyle: CaseIterable {

    case largeTitle
    case largeTitleAlt
    case title1
    case title2
    case title3
    case button
    case headline
    case body
    case callout
    case subhead
    case footnote
    case caption1
    case caption2

    // MARK: Public

    public var uiFont: UIFont {
        switch self {
        case .largeTitle: return RKFonts.Poppins.semiBold.font(size: 34)
        case .largeTitleAlt: return RKFonts.SpaceGrotesk.bold.font(size: 34)
        case .title1: return RKFonts.SpaceGrotesk.bold.font(size: 28)
        case .title2: return RKFonts.SpaceGrotesk.bold.font(size: 22)
        case .title3: return RKFonts.SpaceGrotesk.bold.font(size: 20)
        case .button: return RKFonts.SpaceGrotesk.medium.font(size: 18)
        case .headline: return RKFonts.Poppins.bold.font(size: 17)
        case .body: return RKFonts.Poppins.medium.font(size: 17)
        case .callout: return RKFonts.Poppins.semiBold.font(size: 16)
        case .subhead: return RKFonts.Poppins.semiBold.font(size: 15)
        case .footnote: return RKFonts.Poppins.regular.font(size: 13)
        case .caption1: return RKFonts.Poppins.regular.font(size: 12)
        case .caption2: return RKFonts.Poppins.regular.font(size: 11)
        }
    }

}
