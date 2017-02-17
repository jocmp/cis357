
import Foundation


struct Defaults {
    
    private static let distanceKey = "distance"
    private static let bearingKey = "bearing"
    
    static func setBearing(bearing: String) {
        UserDefaults.standard.setValue(bearing, forKey: bearingKey)
    }
    
    static func setDistance(distance: String) {
        UserDefaults.standard.setValue(distance, forKey: distanceKey)
    }
    
    static func bearing() -> String {
        if let bearing = UserDefaults.standard.string(forKey: bearingKey) {
            return bearing
        }
        return "degrees"
    }
    
    static func distance() -> String {
        if let distance = UserDefaults.standard.string(forKey: distanceKey) {
            return distance
        }
        return "kilometers"
    }
}
