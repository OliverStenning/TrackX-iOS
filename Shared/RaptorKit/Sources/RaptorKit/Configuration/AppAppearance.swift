import UIKit

// MARK: - AppAppearance

public enum AppAppearance {

    // MARK: Public

    public static func setup() {
        setupNavBar()
    }

    // MARK: Private

    private static func setupNavBar() {
        let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(font: RKFonts.Poppins.semiBold, size: 34) ?? UIFont.systemFont(ofSize: 34),
            .foregroundColor: RKAssets.Colors.neutral1.color
        ]

        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(font: RKFonts.Poppins.semiBold, size: 18) ?? UIFont.systemFont(ofSize: 32)
        ]

        let defaultNavBarAppearance = UINavigationBarAppearance()
        defaultNavBarAppearance.configureWithTransparentBackground()
        defaultNavBarAppearance.shadowColor = .clear
        defaultNavBarAppearance.largeTitleTextAttributes = largeTitleTextAttributes
        defaultNavBarAppearance.titleTextAttributes = titleTextAttributes

        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.standardAppearance = defaultNavBarAppearance
        navBarAppearance.compactAppearance = defaultNavBarAppearance
        navBarAppearance.scrollEdgeAppearance = defaultNavBarAppearance
        navBarAppearance.tintColor = RKAssets.Colors.neutral1.color.darkOnly
        navBarAppearance.prefersLargeTitles = true
    }
}
