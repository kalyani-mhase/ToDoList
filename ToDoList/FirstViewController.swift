//
//  ViewController.swift
//  ToDoList
//
//  Created by Mac on 09/12/21.
//

import UIKit
class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var item = [String]()
    private let table : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        self.item = UserDefaults.standard.stringArray(forKey: "item") ?? []
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    @objc func didTapAdd(){
        let alert = UIAlertController(title: "New Item", message: "Enter new to do list items", preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "enter item..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler:{ [weak self]
            (_) in
            if let field = alert.textFields?.first{
                if let text = field.text,!text.isEmpty{
                    //enter new to do list
                    print(text)
                    //var currentItems = UserDefaults.standard.se
                  
                    DispatchQueue.main.async {
                        var currentItems = UserDefaults.standard.stringArray(forKey: "item") ?? []
                        currentItems.append(text)
                        UserDefaults.standard.setValue(currentItems, forKey: "item")
                        self?.item.append(text)
                        self?.table.reloadData()
                    }
                }
            }
        }))
        present(alert, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

