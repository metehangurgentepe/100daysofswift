//
//  ViewController.swift
//  NotesImitation
//
//  Created by Metehan Gürgentepe on 28.08.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var notes = [Note]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getNotes()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNotes))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNotes()
    }
    
    @objc func addNotes() {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getNotes() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
        if let arr = defaults.object(forKey: "NotesArr") as? Data {
            do{
                let notes = try decoder.decode([Note].self, from: arr)
                self.notes = notes
                tableView.reloadData()
            } catch {
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.selectedNotes = notes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

