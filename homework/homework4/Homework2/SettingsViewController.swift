
import UIKit

protocol SettingsViewControllerDelegate {
    func settingsChanged(distanceUnits: String, bearingUnits: String)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var picker: UIPickerView!
    var delegate: SettingsViewControllerDelegate?
    
    var distance: String?
    var bearing: String?
    
    var options = [String]()
    
    var optionsDistance: Selection = Selection(dataSet:["kilometers", "miles"])
    var optionsBearing: Selection = Selection(dataSet:["degrees", "mils"])

    @IBAction func selectDistance(_ sender: Any) {
        setOptions(options: optionsDistance)
        picker.isHidden = false
    }
    
    @IBAction func selectBearing(_ sender: Any) {
        setOptions(options: optionsBearing)
        picker.isHidden = false
    }
    
    @IBOutlet weak var btnBearing: UIButton!
    @IBOutlet weak var btnDistance: UIButton!
    
    @IBAction func cancel(_ sender: Any) {
        dismissView()
    }
    
    @IBAction func save(_ sender: Any) {
        Defaults.setBearing(bearing: optionsBearing.selectedUnit())
        Defaults.setDistance(distance: optionsDistance.selectedUnit())
        
        if let d = self.delegate {
            d.settingsChanged(distanceUnits: optionsDistance.selectedUnit(), bearingUnits: optionsBearing.selectedUnit())
        }
        
        dismissView()
    }
    
    func setOptions(options o:Selection){
        options.removeAll()
        options.append(contentsOf: o.dataSet)
        picker.reloadAllComponents()
        picker.selectRow(o.selectedIndex, inComponent:0, animated: true)
    }
    
    func dismissView(){
        dismiss(animated:true, completion:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(dismissPicker))
        view.addGestureRecognizer(detectTouch)
        
        dismissPicker()
        
        if let distance = distance {
            btnDistance.setTitle(distance.capitalized, for: UIControlState.normal)
            let selectedIndex = distance == optionsDistance.dataSet[0] ? 0 : 1
            optionsDistance.selectedIndex = selectedIndex
        }
        
        if let bearing = bearing {
            btnBearing.setTitle(bearing.capitalized, for: UIControlState.normal)
            let selectedIndex = bearing == optionsBearing.dataSet[0] ? 0 : 1
            optionsBearing.selectedIndex = selectedIndex
        }
        
        self.picker.delegate = self
        self.picker.dataSource = self
    }
 
    func dismissPicker(){
        picker.isHidden = true
    }
}

extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if options[0] == optionsDistance.dataSet[0] {
            btnDistance.setTitle(options[row], for: UIControlState.normal)
            optionsDistance.selectedIndex = row
        } else {
            btnBearing.setTitle(options[row], for: UIControlState.normal)
            optionsBearing.selectedIndex = row
        }
    }
}







