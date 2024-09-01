//
//  ViewController.swift
//  Hangman
//
//  Created by Metehan Gürgentepe on 23.08.2024.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var wordLabel = UILabel()
    var endGame: Bool = false
    var incorrectAnswersCount = 0 {
        didSet{
            scoreLabel.text = "Incorrect letter: \(incorrectAnswersCount)"
            if incorrectAnswersCount == 7 {
                endGame = true
            }
        }
    }
    var usedLetter = [String]()
    var usedLettersLabel = UILabel()
    var hiddenTextField: UITextField!
    var scoreLabel = UILabel()
    
    var exactWord = "RHYTYM"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWordLabel()
        setupUsedLettersLabel()
        setupHiddenTextField()
        setupScoreLabel()
        
        wordLabel.text = ""
        for i in 0...exactWord.count{
            wordLabel.text? += "?"
        }
        wordLabel.text?.removeFirst()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Game is over", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac,animated: true)
    }
    
    func setupWordLabel() {
        view.addSubview(wordLabel)
        wordLabel.font = .systemFont(ofSize: 40)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor,constant: -100)
        ])
    }
    
    func setupScoreLabel() {
        view.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scoreLabel.font = .systemFont(ofSize: 10)
        scoreLabel.text = "Incorrect letter: 0"
        
        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func setupUsedLettersLabel() {
        view.addSubview(usedLettersLabel)
        
        usedLettersLabel.font = .systemFont(ofSize: 17)
        usedLettersLabel.text = "Used Letters"
        usedLetter.append("Used Letters")
        usedLettersLabel.textAlignment = .right
        
        usedLettersLabel.numberOfLines = 10
        usedLettersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usedLettersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            usedLettersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func setupHiddenTextField() {
        hiddenTextField = UITextField(frame: CGRect(x: -100, y: 0, width: 100, height: 50))
        hiddenTextField.delegate = self
        view.addSubview(hiddenTextField)
        
        hiddenTextField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        usedLetter.append(string)
        usedLettersLabel.text = usedLetter.joined(separator: "\n")
        wordLabel.text = isContainsLetter(string)
        return true
    }
    
    func isContainsLetter(_ str: String) -> String?{
        var tempWordArr = [Character]()
        var tempWord = String()
        
        for usedChar in wordLabel.text! {
            tempWordArr.append(usedChar)
        }
        
        if exactWord.contains(str) {
            for (index, char) in exactWord.enumerated() {
                if String(char) == str {
                    tempWordArr.remove(at: index)
                    tempWordArr.insert(char, at: index)
                }
            }
        } else {
            incorrectAnswersCount += 1
            
            if incorrectAnswersCount == 7{
                showError()
            }
        }
        
        
        for word in tempWordArr {
            tempWord += String(word)
        }
        return tempWord
    }
}

