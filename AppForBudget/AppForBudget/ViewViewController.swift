//
//  ViewViewController.swift
//  AppForBudget
//
//  Created by Olivier Rodrigue on 2021-03-05.
//

import RealmSwift
import UIKit

class ViewViewController: UIViewController {

    public var item: ToDoListItem?
    public var deletionHandler: (() -> Void)?

    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var costLabel: UILabel!

    private let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        itemLabel.text = item?.item
        
        let currency = UserDefaults.standard.currency
        
        if item?.positiveOrNegative == true {
            costLabel.text = "+ " + String(item?.amount ?? 0) + " \(currency)"
        } else {
            costLabel.text = "- " + String(item?.amount ?? 0) + " \(currency)"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                                            target: self,
                                                            action: #selector(didTapDelete))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UserDefaults.standard.backgroundColor
    }

    @objc private func didTapDelete() {
        guard let myItem = self.item else {
            return
        }

        realm.beginWrite()
        realm.delete(myItem)
        try! realm.commitWrite()

        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
}
