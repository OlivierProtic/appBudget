//
//  SettingsViewController.swift
//  AppForBudget
//
//  Created by Olivier Rodrigue on 2021-05-22.
//
import UIKit
import RealmSwift

class CurrencyChosing: Object {
    private static let currencyKey = "currency_key"
    static var currency: String {
    get {
    return UserDefaults.standard.string(forKey: currencyKey) ?? ""
    }
    set {
    UserDefaults.standard.set(newValue, forKey: currencyKey)
        }
    }
}

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var currencyText: UITextField!
    
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyLabel.text = "Change currency"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        
        currencyText.becomeFirstResponder()
        currencyText.delegate = self
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
    }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 4
    }
    
    func currecncyTextShouldReturn(_ currencyText: UITextField) -> Bool {
        currencyText.resignFirstResponder()
        return true
    }
    
    @objc func didTapSaveButton() {
        if let text = currencyText.text, !text.isEmpty {
        
            CurrencyChosing.currency = text
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)

            print("My new currency is \(text)")
        }
    }
    @IBAction func changeBackground(_ sender: Any) {
        let picker = UIColorPickerViewController()
        picker.selectedColor = self.view.backgroundColor!
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }

}
extension SettingsViewController: UIColorPickerViewControllerDelegate {
    
    //  Called once you have finished picking the color.
    func colorPickerViewControllerDidFinish(_ settingsViewController: UIColorPickerViewController) {
        self.view.backgroundColor = settingsViewController.selectedColor
        
    }
    
    //  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ settingsViewController: UIColorPickerViewController) {
            self.view.backgroundColor = settingsViewController.selectedColor
    }
}
