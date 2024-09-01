//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Metehan Gürgentepe on 20.08.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numberOfAskedQuestion = 0
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "italy", "ireland", "russia", "spain", "poland", "uk", "us", "monaco"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(showScore))
        
        
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction? = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased())" + " score:\(score)"
        
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        numberOfAskedQuestion += 1
        if correctAnswer == sender.tag {
            title = "Correct"
            score += 1
            showAlert(message: "Your score is \(score)")
            
        } else {
            title = "Wrong"
            score -= 1
            countries.shuffle()
            
            showAlert(message: "This flag is \(countries[correctAnswer])")
        }
        
       
        
        if numberOfAskedQuestion == 10 {
            let ac = UIAlertController(title: title, message: "Showed \(numberOfAskedQuestion) question ", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default,handler: askQuestion))
            
            present(ac,animated: true)
            showAlert(message: "Showed \(numberOfAskedQuestion) question ")
        }
    }
    
    func showAlert(message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default,handler: askQuestion))
        
        present(ac,animated: true)
    }
    
    @objc func showScore() {
        showAlert(message: "Your score is \(score)")
    }
}

