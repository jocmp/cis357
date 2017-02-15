
import UIKit

class NavigationViewController: UINavigationController, SettingsViewControllerDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SettingsViewController {
            dest.delegate = self
        }
    }
    
    func settingsChanged(distanceUnits: String, bearingUnits: String) {
        print("called okay")
    }
}
