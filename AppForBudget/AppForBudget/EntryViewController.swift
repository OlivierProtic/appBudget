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

    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
        textField.delegate = self

        // ajouté
        costField.becomeFirstResponder()
        costField.delegate = self
        //

        // datePicker.setDate(Date(), animated: true)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // ajouté
    func costFieldShouldReturn(_ costField: UITextField) -> Bool {
        costField.resignFirstResponder()
        return true
    }
    //

    @objc func  didTapSaveButton() {
        if let text = textField.text, !text.isEmpty, let amount = costField.text, !amount.isEmpty {
           // let date = datePicker.date

            realm.beginWrite()

            let newItem = ToDoListItem()
            //  newItem.date = date
            newItem.item = text
            newItem.amount = Double(amount)!
            realm.add(newItem)
            try! realm.commitWrite()

            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
        } else {
            print("Add something")
        }
    }
}
