//
//  ViewController.swift
//  News
//
//  Created by Metehan Gürgentepe on 22.08.2024.
//

import UIKit

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(showWarning))
        
        performSelector(inBackground: #selector(fetchJson), with: nil)
    }
    
    @objc func fetchJson() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parseData(json: data)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        DispatchQueue.global(qos: .background).async{ [weak self] in
            if !textSearched.isEmpty {
                self?.filteredPetitions.removeAll(keepingCapacity: true)
                let arr = self?.petitions
                for petition in arr! {
                    if petition.body.contains(textSearched), textSearched.count > 2 {
                        self?.filteredPetitions.append(petition)
                    }
                }
            } else {
                self?.filteredPetitions.removeAll(keepingCapacity: true)
            }
            DispatchQueue.main.async{[weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func showWarning() {
        let ac = UIAlertController(title: "Data comes from whitehouse.gov", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the data.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func parseData(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            DispatchQueue.main.async{ [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.isEmpty ? petitions.count : filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = filteredPetitions.isEmpty ? petitions[indexPath.row] : filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions.isEmpty ? petitions[indexPath.row] : filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
