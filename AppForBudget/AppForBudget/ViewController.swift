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
    @objc dynamic var date: Date = Date()
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet var table: UITableView!
   
    private var data = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(UITableView.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }
// Mark: Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
   
    //open the screen where we can see item info and delete 
    }
    
} 


