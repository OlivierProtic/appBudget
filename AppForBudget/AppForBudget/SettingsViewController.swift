//
//  SettingsViewController.swift
//  AppForBudget
//
//  Created by Olivier Rodrigue on 2021-05-22.
//
import RealmSwift
import UIKit

class CurrencyChosing: Object {
    @objc dynamic var myCurrency: String = ""
}

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var currencyText: UITextField!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyText.delegate = self
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
            
            realm.beginWrite()
            let newCurrency = CurrencyChosing()
            
            newCurrency.myCurrency = text
            realm.add(newCurrency)
            try! realm.commitWrite()
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
            
            print(newCurrency)
            
        } else {
  
    }
}
}
