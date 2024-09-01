//
//  ViewController.swift
//  CocoChanel
//
//  Created by Metehan Gürgentepe on 21.08.2024.
//

import UIKit

class ViewController: UIViewController {

    var heightOfScreen: CGFloat?
    var heightOfLabel: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .green
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .gray
        label3.text = "MAKE"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .yellow
        label4.text = "GOOD"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .blue
        label5.text = "VFL"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        var previous: UILabel?
        
        heightOfScreen = view.frame.height
        heightOfLabel = (heightOfScreen! / 5) - 40
        
        for label in [label1,label2,label3,label4,label5] {
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: heightOfLabel!).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            }
            
            previous = label
        }
    }
    
    override func viewWillLayoutSubviews() {
        heightOfScreen = view.frame.height
        heightOfLabel = (heightOfScreen! / 5) - 40
    }
}

