import UIKit
import Foundation

class ViewController: UIViewController {

    enum Validation {
        static let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        static let emailPredicate = NSPredicate(format: "SELF MATCHES %@", Validation.emailPattern)
    }
    
    enum Messages {
        static let congratulations = "Congratulations! You entered correct values."
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(dismissKeyboard))
        view.addGestureRecognizer(detectTouch)
        
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        validateFields()
    }
    
    func validateFields() {
        if validateEmail() && validatePassword() {
             print(Messages.congratulations)
        }
    }
    
    func validatePassword() -> Bool {
        var passwordIsValid = false
        if let password = passwordField.text {
            passwordIsValid = !password.isEmpty
        }
        return passwordIsValid
    }
    
    func validateEmail() -> Bool {
        var emailIsValid = false
        if let email = emailField.text {
            emailIsValid = Validation.emailPredicate.evaluate(with: email)
        }
        return emailIsValid
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            self.passwordField.becomeFirstResponder()
        } else {
            validateFields()
        }
        return true
    }
}
