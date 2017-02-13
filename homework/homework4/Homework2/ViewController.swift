import UIKit
import CoreLocation

class ViewController: UIViewController {

    enum Defaults {
        static let kilometers = "kilometers"
        static let degrees = "degrees"
        
        static let distance = "0.00 \(kilometers)"
        static let bearing = "0.00 \(degrees)"
    }
    
    @IBOutlet weak var currentLatitude: DecimalMinusTextField!
    @IBOutlet weak var currentLongitude: DecimalMinusTextField!
    
    @IBOutlet weak var destinationLatitude: DecimalMinusTextField!
    @IBOutlet weak var destinationLongitude: DecimalMinusTextField!

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    
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
        
        currentLatitude.text = ""
        currentLongitude.text = ""
        
        destinationLatitude.text = ""
        destinationLongitude.text = ""
        
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
        distanceLabel.text = "\(formatWithPrecision(calculation: destination.distanceInKilometers(from: current))) \(Defaults.kilometers)"
    }
    
    func setBearing(current: CLLocation, destination: CLLocation) {
        bearingLabel.text = "\(formatWithPrecision(calculation: current.bearingToPoint(point: destination))) \(Defaults.degrees)"
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
