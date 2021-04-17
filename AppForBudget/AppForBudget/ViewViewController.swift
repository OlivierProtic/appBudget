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

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        itemLabel.text = item?.item
        costLabel.text = String(item?.amount ?? 0)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
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
