//
//  DetailViewController.swift
//  InstagramCloneApp
//
//  Created by Metehan Gürgentepe on 24.08.2024.
//

import UIKit

class DetailViewController: UIViewController {
    var imageView: UIImageView!
    var label: UILabel!
    
    var place: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayouts()
    }
    
    func setupLayouts() {
        imageView = UIImageView()
        label = UILabel()
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        if let place = place{
            imageView.image = UIImage(data: place.image)
            label.text = place.name
        }
    }

}
