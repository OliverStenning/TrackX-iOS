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
            .foregroundColor: UIColor.label
        ]
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(font: RKFonts.Archivo.semiBold, size: 18) ?? UIFont.systemFont(ofSize: 32)
        ]
        
        
        let defaultNavBarAppearance = UINavigationBarAppearance()
        defaultNavBarAppearance.configureWithOpaqueBackground()
        defaultNavBarAppearance.backgroundColor = .systemBackground
        defaultNavBarAppearance.shadowColor = .separator
        defaultNavBarAppearance.largeTitleTextAttributes = largeTitleTextAttributes
        defaultNavBarAppearance.titleTextAttributes = titleTextAttributes
        
        let scrollEdgeNavBarAppearance = UINavigationBarAppearance()
        scrollEdgeNavBarAppearance.configureWithOpaqueBackground()
        scrollEdgeNavBarAppearance.backgroundColor = .systemBackground
        scrollEdgeNavBarAppearance.shadowColor = .clear
        scrollEdgeNavBarAppearance.largeTitleTextAttributes = largeTitleTextAttributes
        scrollEdgeNavBarAppearance.titleTextAttributes = titleTextAttributes
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.standardAppearance = defaultNavBarAppearance
        navBarAppearance.compactAppearance = defaultNavBarAppearance
        navBarAppearance.scrollEdgeAppearance = scrollEdgeNavBarAppearance
        navBarAppearance.tintColor = RKAssets.Colors.accent.color
        navBarAppearance.prefersLargeTitles = true
    }
    
}
