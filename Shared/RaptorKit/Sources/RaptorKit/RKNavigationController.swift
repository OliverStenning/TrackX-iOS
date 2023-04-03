import UIKit

public class RKNavigationController: UINavigationController {

    public override var childForStatusBarStyle: UIViewController? {
        visibleViewController
    }

}
