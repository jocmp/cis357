
import UIKit

protocol SettingsViewControllerDelegate {
    func settingsChanged(distanceUnits: String, bearingUnits: String)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var picker: UIPickerView!
    var options: [String] = [String]()
    var optionsDistance: Selection = Selection(dataSet:["Kilometers", "Miles"])
    var optionsBearing: Selection = Selection(dataSet:["Degrees", "Mils"])
    var distanceSelected:Bool = true
    var delegate: SettingsViewControllerDelegate?
    
    @IBAction func selectDistance(_ sender: Any) {
        distanceSelected = true
        setOptions(Options:optionsDistance)
        picker.isHidden = false
    }
    
    @IBAction func selectBearing(_ sender: Any) {
        distanceSelected = false
        setOptions(Options:optionsBearing)
        picker.isHidden = false
    }
    
    @IBOutlet weak var btnBearing: UIButton!
    @IBOutlet weak var btnDistance: UIButton!
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "segueToSettings") {

        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismissView()
    }
    
    @IBAction func save(_ sender: Any) {
        if let d = self.delegate {
            d.settingsChanged(distanceUnits: optionsDistance.selectedUnit(), bearingUnits: optionsBearing.selectedUnit())
        }
        dismissView()
    }
    
    func setOptions(Options o:Selection){
        options.removeAll()
        options.append(contentsOf: o.dataSet)
        picker.reloadAllComponents()
        picker.selectRow(o.selectedIndex, inComponent:0, animated: true)
    }
    
    func dismissView(){
        navigationController?.popViewController(animated: true)?
            .dismiss(animated:true, completion:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(dismissPicker))
        view.addGestureRecognizer(detectTouch)
        
        dismissPicker()
        
        btnDistance.setTitle(self.optionsDistance.dataSet[0], for: UIControlState.normal)
        btnBearing.setTitle(self.optionsBearing.dataSet[0], for: UIControlState.normal)
        
        self.picker.delegate = self
        self.picker.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissPicker(){
        picker.isHidden = true
    }

}

extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    // The number of columns of data
    
    func numberOfComponents(in: UIPickerView) -> Int{
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        return self.options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if distanceSelected {
            btnDistance.setTitle(self.options[row], for: UIControlState.normal)
            self.optionsDistance.selectedIndex = row
        } else {
            btnBearing.setTitle(self.options[row], for: UIControlState.normal)
            self.optionsBearing.selectedIndex = row
        }
    }
}







