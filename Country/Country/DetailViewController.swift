//
//  DetailViewController.swift
//  Country
//
//  Created by Metehan Gürgentepe on 26.08.2024.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedCountry: Country?
    
     var officialLabel: UILabel!
     var populationLabel: UILabel!
     var areaLabel: UILabel!
     var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        officialLabel = UILabel()
        populationLabel = UILabel()
        areaLabel = UILabel()
        nameLabel = UILabel()
        
        view.addSubview(officialLabel)
        view.addSubview(populationLabel)
        view.addSubview(areaLabel)
        view.addSubview(nameLabel)
        
        officialLabel.translatesAutoresizingMaskIntoConstraints = false
        populationLabel.translatesAutoresizingMaskIntoConstraints = false
        areaLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        guard let country = selectedCountry else {
            print("No country was selected.")
            return
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            officialLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            officialLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            areaLabel.topAnchor.constraint(equalTo: officialLabel.bottomAnchor),
            areaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            populationLabel.topAnchor.constraint(equalTo: areaLabel.bottomAnchor),
            populationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
        ])

            areaLabel.text = "Area: \(country.area)"
            nameLabel.text = "Name: \(country.name.common)"
            officialLabel.text = "Official name: \(country.name.official)"
            populationLabel.text = "Population: \(country.population)"
    }
}
