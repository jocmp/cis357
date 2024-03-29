import Foundation
import CoreLocation

/**
    Extends CLLocation in CoreLocation with some commonly used calculations.
*/
extension CLLocation {
    
    /**
        Compute bearing in degrees between two points (in radians).

        - parameter point: The point the bearing is being computed for.

        - returns: The computed bearing in degrees. 
    */
    func bearingToPoint(point:CLLocation, with unit: Unit) -> Double {
        let p1 = (self.coordinate.latitude, self.coordinate.longitude)
        let p2 = (point.coordinate.latitude, point.coordinate.longitude)
        let x = cos(p2.0) * sin(abs(p2.1 - p1.1))
        let y = cos(p1.0) * sin(p2.0) - sin(p1.0) * cos(p2.0) * cos(abs(p2.1 - p1.1))
        
        return (atan2(x,y) * 180.0 / M_PI) * Double(unit.multipler)
    }
    
    func distanceInKilometers(from point: CLLocation, with unit: Unit) -> CLLocationDistance {
        return (distance(from: point) / 1000.0) * Double(unit.multipler)
    }
    
    /**
        Compute a destination coordinate based on a start coordinate, bearing, and distance.

        - parameter withBearing: The bearing (in decimal).
        - parameter atDistance: The distance to be traveled (in kilometers).

        - returns: the destinataion coordinate.
    */
    func findingPoint(withBearing: Double, atDistance: Double) -> CLLocation {
        let R = 6371.0
        
        // compute the coordinates in radians
        let p1 = (self.coordinate.latitude * M_PI / 180.0, self.coordinate.longitude * M_PI / 180.0)
        
        // compute angular distance
        let ad = atDistance / R
        let lat : Double = asin(sin(p1.0) * cos(ad) + cos(p1.0) * sin(ad) * cos(withBearing))
        let lon : Double = p1.1 + atan2(sin(withBearing) * sin(ad) * cos(p1.0), cos(ad) - sin(p1.0) * sin(lat))
        
        // create the CLLocation by converting from radians to decimal.
        return CLLocation(latitude: lat * 180.0 / M_PI, longitude: lon * 180.0 / M_PI)
    }
    
    struct Unit {
        
        let unit: String
        let multipler: Float
        
        init(unit: String) {
            self.unit = unit.lowercased()
            switch self.unit {
            case "mils":
            multipler = 17.777777777778
            case "miles":
            multipler = 0.621371
            default:
                multipler = 1.0
            }
        }
    }
}
