//
//  ViewController.swift
//  Calculator
//
//  Created by Metehan Gürgentepe on 26.08.2024.
//

import UIKit

class ViewController: UIViewController {
    var buttons = [UIButton]()
    var input1: Double?
    var input2: Double?
    var sum: Double?
    var operation: (() -> Void)?

    @IBOutlet weak var inputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputLabel.text = ""
        inputLabel.textAlignment = .right
        inputLabel.numberOfLines = 2
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        let color = sender.configuration?.background.backgroundColor
        
        
        if let input = sender.configuration?.title {
            inputLabel.text! += input
        }
        
        if let image = sender.configuration?.image {
            switch image {
            case UIImage(systemName: "multiply"):
                input1 = Double(inputLabel.text!)
                inputLabel.text = ""
                operation = multiply
                
            case UIImage(systemName: "divide"):
                input1 = Double(inputLabel.text!)
                inputLabel.text = ""
                operation = divide
                
            case UIImage(systemName: "minus"):
                input1 = Double(inputLabel.text!)
                inputLabel.text = ""
                operation = minus
                
            case UIImage(systemName: "equal"):
                input2 = Double(inputLabel.text!)
                operation!()
                if sum?.truncatingRemainder(dividingBy: 1.0) == 0 {
                    inputLabel.text = "\(Int(sum!))"
                } else {
                    inputLabel.text = "\(sum!)"
                }
                
                
            case UIImage(systemName: "plus"):
                input1 = Double(inputLabel.text!)
                inputLabel.text = ""
                operation = plus
                
            case UIImage(systemName: "percent"):
                break
                
            case UIImage(systemName: "minus.forwardslash.plus"):
                input1 = -Double(inputLabel.text!)!
                inputLabel.text = "\(input1!)"
                
            case UIImage(systemName: "delete.left"):
                inputLabel.text = ""
                
            default:
                break
            }
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            sender.configuration?.background.backgroundColor = color?.withAlphaComponent(0.5)
            sender.transform = CGAffineTransform(scaleX: 1.001, y: 1.001)
        }) {_ in
            sender.transform = .identity
            sender.configuration?.background.backgroundColor = color
        }
    }
    
    func divide() {
        if let input1 = input1, let input2 = input2{
            sum = input1 / input2
        }
    }
    
    func multiply() {
        if let input1 = input1, let input2 = input2{
            sum = input1 * input2
        }
    }
    
    func plus() {
        if let input1 = input1, let input2 = input2{
            sum = input1 + input2
        }
    }
    
    func minus() {
        if let input1 = input1, let input2 = input2{
            sum = input1 - input2
        }
    }
}

