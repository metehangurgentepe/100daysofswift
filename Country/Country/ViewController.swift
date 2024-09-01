//
//  ViewController.swift
//  Country
//
//  Created by Metehan Gürgentepe on 26.08.2024.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getCountries()
    }
    
    func getCountries() {
        if let url = URL(string: "https://restcountries.com/v3.1/all") {
            let decoder = JSONDecoder()
            DispatchQueue.global(qos: .background).async{
                if let data = try? Data(contentsOf: url) {
                    do{
                        self.countries = try decoder.decode([Country].self, from: data)
                        DispatchQueue.main.async{
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name.common
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.selectedCountry = countries[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

