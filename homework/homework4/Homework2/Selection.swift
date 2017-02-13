import Foundation

struct Selection {
    
    let dataSet:[String]
    var selectedIndex:Int = 0
    
    init(dataSet:[String]) {
        self.dataSet = dataSet
    }
    
    func selectedUnit() -> String {
        return dataSet[selectedIndex]
    }
}
