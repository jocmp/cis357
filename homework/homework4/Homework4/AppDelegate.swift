import UIKit


let BACKGROUND_COLOR = UIColor.init(colorLiteralRed: 0.000, green: 0.369, blue: 0.420, alpha: 1.00)
let FOREGROUND_COLOR = UIColor.init(colorLiteralRed: 0.937, green: 0.820, blue: 0.576, alpha: 1.00)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        application.statusBarStyle = UIStatusBarStyle.lightContent
        
        let navAppearance = UINavigationBar.appearance()
        navAppearance.barTintColor = BACKGROUND_COLOR
        navAppearance.tintColor = FOREGROUND_COLOR
        navAppearance.isTranslucent = false
        navAppearance.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
    }


    func applicationWillEnterForeground(_ application: UIApplication) {
    }


    func applicationDidBecomeActive(_ application: UIApplication) {
    }


    func applicationWillTerminate(_ application: UIApplication) {
    }
}
