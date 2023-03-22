import UIKit

// MARK: - AppAppearance

public enum AppAppearance {

    // MARK: - Private
    
    public static func setup() {
        setupNavBar()
    }
    
    private static func setupNavBar() {
        let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(font: RKFonts.Archivo.semiBold, size: 34) ?? UIFont.systemFont(ofSize: 34),
            .foregroundColor: RKAssets.Colors.neutral1.color
        ]
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(font: RKFonts.Archivo.semiBold, size: 18) ?? UIFont.systemFont(ofSize: 32)
        ]
        
        
        let defaultNavBarAppearance = UINavigationBarAppearance()
        defaultNavBarAppearance.configureWithDefaultBackground()
        defaultNavBarAppearance.shadowColor = .separator
        defaultNavBarAppearance.largeTitleTextAttributes = largeTitleTextAttributes
        defaultNavBarAppearance.titleTextAttributes = titleTextAttributes
        
        let scrollEdgeNavBarAppearance = UINavigationBarAppearance()
        scrollEdgeNavBarAppearance.configureWithOpaqueBackground()
        scrollEdgeNavBarAppearance.backgroundColor = RKAssets.Colors.background1.color
        scrollEdgeNavBarAppearance.shadowColor = .clear
        scrollEdgeNavBarAppearance.largeTitleTextAttributes = largeTitleTextAttributes
        scrollEdgeNavBarAppearance.titleTextAttributes = titleTextAttributes
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.standardAppearance = defaultNavBarAppearance
        navBarAppearance.compactAppearance = defaultNavBarAppearance
        navBarAppearance.scrollEdgeAppearance = scrollEdgeNavBarAppearance
        navBarAppearance.tintColor = RKAssets.Colors.accent3.color
        navBarAppearance.prefersLargeTitles = true
    }
    
}
