import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().backgroundColor = UIColor.pmGreen
        UITextField.appearance().tintColor = UIColor.pmLightGreen
        UINavigationBar.appearance().tintColor = UIColor.pmLightGray
        return true
    }
}

