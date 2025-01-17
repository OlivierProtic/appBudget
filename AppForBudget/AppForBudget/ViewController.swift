//
//  ViewController.swift
//  AppForBudget
//
//  Created by Olivier Rodrigue on 2021-03-04.
//

import RealmSwift
import UIKit

/*
 -Screen to show list of current to do list items
 -Screen to enter new to do list items
 -Screen to show previously entered to do list item
 
 -Item
 -Date
 */

class ToDoListItem: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var amount: Double = 0
    @objc dynamic var positiveOrNegative: Bool = true
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var total: UILabel!

    private let realm = try! Realm()
    private var data = [ToDoListItem]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var sum: Double = 0
        for item in data {
            if item.positiveOrNegative == true {
                sum += item.amount
            } else {
                sum -= item.amount
            }
        }
        let currency = UserDefaults.standard.currency
        total.text = "Total: " + "\(sum)" + " \(currency)"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.backgroundColor = UserDefaults.standard.backgroundColor
        table.backgroundColor = UserDefaults.standard.backgroundColor
        table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(ToDoListItem.self).map({ $0 })
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }
       
    // MARK: Table

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        cell.backgroundColor = UserDefaults.standard.backgroundColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // Open the screen where we can see item info and delete
        let item = data[indexPath.row]

        guard let vc = storyboard?.instantiateViewController(identifier: "view") as? ViewViewController else {
            return
        }
        vc.item = item
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = item.item
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func didTapAddButton() {
        guard let vc = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController else {
            return
        }
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }
        vc.title = "New Item"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func refresh() {
        data = realm.objects(ToDoListItem.self).map({ $0 })
        table.reloadData()
    }
   
    @IBAction func didTapSettings() {
        guard let vc = storyboard?.instantiateViewController(identifier: "settings") as? SettingsViewController else {
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
    }
}
