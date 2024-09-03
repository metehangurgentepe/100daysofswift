//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import UIKit

class ViewController: UIViewController {
    var cards = [Card]()
    var emojis = ["😀","🤣","😍","🥳","🥵","🙄","😷","👿","🤡"]
    var buttons = [UIButton]()
    var activatedButtons = [UIButton]()
    var prevTitle: String?
    
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
            
            button.layer.backgroundColor = UIColor.red.cgColor
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 10
            
            let column = i % 3
            let row = i / 3
            
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            button.frame = CGRect(x:10 + CGFloat(column) * width, y: 100 + height * CGFloat(row), width: width - 3, height: height - 2)
            
            view.addSubview(button)
            
            buttons.append(button)
        }
    }
    
    func createCards() {
        for i in 0..<2 {
            for emoji in emojis {
                let card = Card(emoji: emoji, isHidden: true)
                cards.append(card)
                
            }
        }
        
        cards.shuffle()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]

        let emoji = cards[sender.tag].emoji
        
        UIView.transition(with: sender, duration: 1.5, options: transitionOptions, animations: {
            sender.layer.backgroundColor = UIColor.white.cgColor
            sender.setTitle(emoji, for: .normal)
        }) {_ in
            
            self.activatedButtons.append(sender)
            
            if self.activatedButtons.count == 2 {
        
                if self.activatedButtons.first == self.activatedButtons.last {
                    
                    var buttons = self.buttons.filter({$0.currentTitle == self.activatedButtons.first?.currentTitle})
                    
                    for button in self.buttons {
                        if button.currentTitle == self.activatedButtons[0].currentTitle {
                            button.isHidden = true
                        }
                    }
                    
                    self.score += 1
                    self.activatedButtons.removeAll()
                } else {
                    var tags: [Int] = []
                    
                    for activatedButton in self.activatedButtons {
                        tags.append(activatedButton.tag)
                    }
                    
                    for button in self.buttons {
                        for tag in tags {
                            if tag == button.tag {
                                button.layer.backgroundColor = UIColor.red.cgColor
                                button.setTitle("", for: .normal)
                            }
                        }
                    }
                    self.activatedButtons.removeAll()
                }
            }
            
            if self.score == 9 {
                let ac = UIAlertController(title: "You win!", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(ac,animated: true)
            }
        }
        
        
    }
}

