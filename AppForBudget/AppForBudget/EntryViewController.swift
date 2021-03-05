//
//  EntryViewController.swift
//  AppForBudget
//
//  Created by Olivier Rodrigue on 2021-03-05.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
     
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
        textField.delegate = self
    }
    
    @IBAction func  didTapSaveButton() {
        
}

}
 
