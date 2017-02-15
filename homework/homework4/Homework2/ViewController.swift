import UIKit
import CoreLocation

class ViewController: UIViewController, SettingsViewControllerDelegate {

    enum Defaults {
        static let distance = "0.00 kilometers"
        static let bearing = "0.00 degrees"
    }
    
    @IBOutlet weak var currentLatitude: DecimalMinusTextField!
    @IBOutlet weak var currentLongitude: DecimalMinusTextField!
    
    @IBOutlet weak var destinationLatitude: DecimalMinusTextField!
    @IBOutlet weak var destinationLongitude: DecimalMinusTextField!

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    
    var bearingUnit = CLLocation.Unit(unit: "degrees")
    var distanceUnit = CLLocation.Unit(unit: "kilometers")
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SettingsViewController {
            dest.delegate = self
        }
    }

    func settingsChanged(distanceUnits: String, bearingUnits: String) {
        distanceUnit = CLLocation.Unit(unit: distanceUnits)
        bearingUnit = CLLocation.Unit(unit: bearingUnits)
        calculate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(dismissKeyboard))
        view.addGestureRecognizer(detectTouch)
        
        currentLatitude.delegate = self
        currentLongitude.delegate = self
        
        destinationLatitude.delegate = self
        destinationLongitude.delegate = self
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func clearAllPressed(_ sender: Any) {
        dismissKeyboard()
        
        currentLatitude.text = "43.077366"
        currentLongitude.text = "-85.994053"
        
        destinationLatitude.text = "43.077303"
        destinationLongitude.text = "-85.993860"
        
        distanceLabel.text = Defaults.distance
        bearingLabel.text = Defaults.bearing
    }
    
    @IBAction func calculatePressed(_ sender: Any) {
        calculate()
    }
    
    func calculate() {
        dismissKeyboard()
        let (current, destination) = getLocations()
        setDistance(current: current, destination: destination)
        setBearing(current: current, destination: destination)
    }
    
    func getLocations() -> (CLLocation, CLLocation) {
        let current = CLLocation(latitude: currentLatitude.decimalValue(), longitude: currentLongitude.decimalValue())
        let destination = CLLocation(latitude: destinationLatitude.decimalValue(), longitude: destinationLongitude.decimalValue())
        
        return (current, destination)
    }
    
    func setDistance(current: CLLocation, destination: CLLocation) {
        let distance = destination.distanceInKilometers(from: current, with: distanceUnit)
        distanceLabel.text = "\(formatWithPrecision(calculation: distance)) \(distanceUnit.unit)"
    }
    
    func setBearing(current: CLLocation, destination: CLLocation) {
        let bearings = current.bearingToPoint(point: destination, with: bearingUnit)
        bearingLabel.text = "\(formatWithPrecision(calculation: bearings)) \(bearingUnit.unit)"
    }
    
    func formatWithPrecision(calculation: Double) -> String {
        return String(format:"%.2f", calculation)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case currentLatitude:
            currentLongitude.becomeFirstResponder()
        case currentLongitude:
            destinationLatitude.becomeFirstResponder()
        case destinationLatitude:
            destinationLongitude.becomeFirstResponder()
        case destinationLongitude:
            calculate()
        default:
            dismissKeyboard()
        }
        return true
    }
}
