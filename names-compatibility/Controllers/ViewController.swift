//
//  ViewController.swift
//  names-compatibility
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNameTF  : UITextField!
    @IBOutlet weak var secondNameTF : UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultController else { return }
        destinationVC.firstName = firstNameTF.text
        destinationVC.secondName = secondNameTF.text
    }
    
    @IBAction func onResultBtnTapped () {
        guard let firstName = firstNameTF.text, let secondName = secondNameTF.text else { return }
        
        // If `TextFields` are empty.
        if firstName.isEmpty || secondName.isEmpty {
            showAlert(
                title: Warnings.WARN_TITLE.rawValue,
                msg: Warnings.WARN_FIELDS_EMPTY.rawValue
            )
            return
        }
        
        // If `TextFields` contains any digits.
        if firstName.contains(/\d/) || secondName.contains(/\d/) {
            showAlert(
                title: Warnings.WARN_TITLE.rawValue,
                msg: Warnings.WARN_FIELDS_HAS_NUMBERS.rawValue
            )
            return
        }
        
        // Perform segue if all `TextFields` passed checks
        performSegue(withIdentifier: "goToResult", sender: nil)
    }
    
    // Connected with `UIButton` and exit-outlet in `ResultController`
    @IBAction func unwindSegueToViewContoller (segue: UIStoryboardSegue) {
        firstNameTF.text = ""
        secondNameTF.text = ""
    }
    
}


extension ViewController {
    
    // Creates `UIAlertController` on top of the current `ViewController`
    private func showAlert (title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

extension ViewController : UITextFieldDelegate {
    
    // Hide keyboard if the user tapped outside the keyboard or `UITextField`
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // Continue writing names in all `UITextField`s without hiding the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTF {
            secondNameTF.becomeFirstResponder()
        } else {
            onResultBtnTapped()
        }
        return true
    }

}
