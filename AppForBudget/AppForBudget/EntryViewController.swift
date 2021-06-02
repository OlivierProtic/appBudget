//
//  EntryViewController.swift
//  AppForBudget
//
//  Created by Olivier Rodrigue on 2021-03-05.
//

import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var costField: UITextField!
    @IBOutlet var incomeExpenseControl: UISegmentedControl!
    @IBOutlet var textFieldLabel: UILabel!
    @IBOutlet var costFieldLabel: UILabel!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
        textField.delegate = self

        costField.becomeFirstResponder()
        costField.delegate = self

        textFieldLabel.text = "Name"
        costFieldLabel.text = "Amount"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func costFieldShouldReturn(_ costField: UITextField) -> Bool {
        costField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == costField {
            let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
            return (string.rangeOfCharacter(from: invalidCharacters) == nil)
        } else {
            return true
        }
    }
    
    @objc func  didTapSaveButton() {
        
        if let text = textField.text, !text.isEmpty, let amount = costField.text, !amount.isEmpty {
            realm.beginWrite()
            let newItem = ToDoListItem()

            switch incomeExpenseControl.selectedSegmentIndex {
            case 0:
                newItem.positiveOrNegative = true
            case 1:
                newItem.positiveOrNegative = false
            default:
                newItem.positiveOrNegative = true
            }

            newItem.item = text
            newItem.amount = Double(amount)!
            realm.add(newItem)
            try! realm.commitWrite()
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
            print(newItem.positiveOrNegative)
        } else {
            print("Add something")
        }
    }
}
