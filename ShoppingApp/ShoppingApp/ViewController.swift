//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Metehan Gürgentepe on 22.08.2024.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareItems))
        
        navigationItem.rightBarButtonItems = [addButton, shareButton]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeAllItems))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItem", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func removeAllItems() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func shareItems() {
        let listOfString = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [listOfString], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addAction = UIAlertAction(title: "Add", style: .default) {[weak self] _ in
            if let item = ac.textFields?[0].text, !item.isEmpty {
                self?.submit(item: item)
            }
        }
        
        ac.addAction(addAction)
        present(ac, animated: true)
    }
    
    func submit(item: String) {
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(item: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

