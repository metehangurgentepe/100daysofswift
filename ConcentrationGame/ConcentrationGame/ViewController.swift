//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import UIKit

class ViewController: UIViewController {
    var cards = [Card]()
    var emojis = ["😀", "🤣", "😍", "🥳", "🥵", "🙄", "😷", "👿", "🤡"]
    var buttons = [UIButton]()
    var activatedButtons = [UIButton]()
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCards()
        createButtons()
    }
    
    func createButtons() {
        let width = (view.frame.width - 30) / 3
        let height = (view.frame.height - 200) / 6
        
        for i in 0...17 {
            let button = UIButton()
            button.tag = i
            styleButton(button)
            
            let column = i % 3
            let row = i / 3
            button.frame = CGRect(x: 10 + CGFloat(column) * width, y: 100 + height * CGFloat(row), width: width - 3, height: height - 2)
            
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            view.addSubview(button)
            buttons.append(button)
        }
    }
    
    func styleButton(_ button: UIButton) {
        button.layer.backgroundColor = UIColor.red.cgColor
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
    }
    
    func createCards() {
        for _ in 0..<2 {
            for emoji in emojis {
                let card = Card(emoji: emoji, isHidden: true)
                cards.append(card)
            }
        }
        cards.shuffle()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let emoji = cards[sender.tag].emoji
        flipButton(sender, with: emoji, color: .white)
        
        activatedButtons.append(sender)
        
        if activatedButtons.count == 2 {
            evaluateMatch()
        }
    }
    
    func flipButton(_ button: UIButton, with title: String, color: UIColor) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: button, duration: 0.6, options: transitionOptions, animations: {
            button.layer.backgroundColor = color.cgColor
            button.setTitle(title, for: .normal)
        })
    }
    
    func evaluateMatch() {
        guard let firstButton = activatedButtons.first?.currentTitle, let lastButton = activatedButtons.last?.currentTitle else {
            return
        }
        
        if firstButton == lastButton {
            hideMatchingButtons()
            score += 1
            activatedButtons.removeAll()
        } else {
            resetActivatedButtons()
        }
                
        if score == 9 {
            showWinAlert()
        }
    }
    
    func hideMatchingButtons() {
        let matchedEmoji = activatedButtons.first?.currentTitle
        
        for button in buttons {
            if button.currentTitle == matchedEmoji {
                button.isHidden = true
            }
        }
    }
    
    func resetActivatedButtons() {
        UIView.animate(withDuration: 0.6, animations: {
            self.flipButton(self.activatedButtons.last!, with: self.cards[self.activatedButtons.last!.tag].emoji, color: .white)
            
        }) { _ in
            UIView.animate(withDuration: 0.6, animations: {
                for button in self.activatedButtons {
                    self.flipButton(button, with: "", color: UIColor.red)
                }
            })
            self.activatedButtons.removeAll()
        }
    }

    func showWinAlert() {
        let ac = UIAlertController(title: "You win!", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
}
