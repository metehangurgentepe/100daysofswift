//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Metehan Gürgentepe on 2.09.2024.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var lineTopString: String?
    var lineBottomString: String?
    var selectedImage: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPhoto))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTextLine))
    }
    
    @objc func importPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,animated: true)
    }
    
    @objc func addTextLine() {
        let ac = UIAlertController(title: "Add Top Line", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            if let text = ac.textFields?[0].text {
                self.lineTopString = text
            }
            self.showAlertForBottomMeme()
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func showAlertForBottomMeme() {
        let ac = UIAlertController(title: "Add Bottom Line", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            if let text = ac.textFields?[0].text {
                self.lineBottomString = text
            }
            self.renderImage()
            
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func renderImage() {
        guard let selectedImage = selectedImage else { return }
        
        let renderer = UIGraphicsImageRenderer(size: selectedImage.size)
        
        let img = renderer.image { ctx in
            // Drawing the selected image
            selectedImage.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 30, weight: .bold),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.black,
                .strokeColor: UIColor.black,
                .strokeWidth: -3.0
            ]
            
            if let topString = lineTopString {
                let topBackgroundRect = CGRect(x: 0, y: 0, width: selectedImage.size.width, height: 30)
                ctx.cgContext.setFillColor(UIColor.red.cgColor)
                ctx.cgContext.fill(topBackgroundRect)
                topString.draw(with: topBackgroundRect, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            }
            
            if let bottomString = lineBottomString {
                let topBackgroundRect = CGRect(x: 0, y: selectedImage.size.height - 35, width: selectedImage.size.width, height: 30)
                ctx.cgContext.setFillColor(UIColor.red.cgColor)
                ctx.cgContext.fill(topBackgroundRect)
                bottomString.draw(with: topBackgroundRect, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            }
        }
        
        imageView.image = img
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage{
            selectedImage = image
            imageView.image = image
        }
        dismiss(animated: true)
    }
}

