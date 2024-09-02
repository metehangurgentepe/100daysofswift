//
//  ViewController.swift
//  Project27
//
//  Created by Metehan Gürgentepe on 1.09.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
    }
    
    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 9 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerBoard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawEmoji()
        case 7:
            drawStarEmoji()
        case 8:
            drawTextTWIN()
            
        default:
            break
        }
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCheckerBoard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8 {
                for col in 0..<8 {
                    if (row + col).isMultiple(of: 2) {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = image
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: CGFloat.pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawImagesAndText() {
        // 1
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 36)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]
            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            string.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            
            // 5
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        
        // 6
        imageView.image = img
    }
    
    func drawEmoji() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let faceRectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(3)
            
            ctx.cgContext.addEllipse(in: faceRectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            
            let eyeRadius: CGFloat = 40
            let leftEyeCenter = CGPoint(x: faceRectangle.midX - 100, y: faceRectangle.midY - 100)
            let rightEyeCenter = CGPoint(x: faceRectangle.midX + 100, y: faceRectangle.midY - 100)
            
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            ctx.cgContext.addEllipse(in: CGRect(x: leftEyeCenter.x - eyeRadius / 2, y: leftEyeCenter.y - eyeRadius / 2, width: eyeRadius, height: eyeRadius))
            ctx.cgContext.addEllipse(in: CGRect(x: rightEyeCenter.x - eyeRadius / 2, y: rightEyeCenter.y - eyeRadius / 2, width: eyeRadius, height: eyeRadius))
            ctx.cgContext.drawPath(using: .fill)
            
            
            let smileStart = CGPoint(x: faceRectangle.midX - 100, y: faceRectangle.midY + 50)
            let smileEnd = CGPoint(x: faceRectangle.midX + 100, y: faceRectangle.midY + 50)
            let smileControl1 = CGPoint(x: faceRectangle.midX - 100, y: faceRectangle.midY + 150)
            let smileControl2 = CGPoint(x: faceRectangle.midX + 100, y: faceRectangle.midY + 150)
            
            ctx.cgContext.setLineWidth(5)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            
            ctx.cgContext.move(to: smileStart)
            ctx.cgContext.addCurve(to: smileEnd, control1: smileControl1, control2: smileControl2)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawStarEmoji() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let center = CGPoint(x: 256, y: 256)
            let radius: CGFloat = 200
            let pointsOnStar = 5

            let path = CGMutablePath()

            let adjustment: CGFloat = -CGFloat.pi / 2

            for i in 0..<pointsOnStar * 2 {
                let angle = (CGFloat(i) * .pi / CGFloat(pointsOnStar)) + adjustment
                let pointRadius = i % 2 == 0 ? radius : radius * 0.4  // Alternatif uzun ve kısa noktalar
                let point = CGPoint(x: center.x + pointRadius * cos(angle), y: center.y + pointRadius * sin(angle))

                if i == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            
            path.closeSubpath()

            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(5)
            ctx.cgContext.addPath(path)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imageView.image = img
    }
    
    func drawTextTWIN() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(5)

            // Draw 'T'
            ctx.cgContext.move(to: CGPoint(x: 50, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 150, y: 50))
            ctx.cgContext.move(to: CGPoint(x: 100, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 100, y: 150))

            // Draw 'W'
            ctx.cgContext.move(to: CGPoint(x: 180, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 200, y: 150))
            ctx.cgContext.addLine(to: CGPoint(x: 220, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 240, y: 150))
            ctx.cgContext.addLine(to: CGPoint(x: 260, y: 50))

            // Draw 'I'
            ctx.cgContext.move(to: CGPoint(x: 290, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 290, y: 150))

            // Draw 'N'
            ctx.cgContext.move(to: CGPoint(x: 320, y: 150))
            ctx.cgContext.addLine(to: CGPoint(x: 320, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 420, y: 150))
            ctx.cgContext.addLine(to: CGPoint(x: 420, y: 50))
            
            // Apply the stroke to the path
            ctx.cgContext.strokePath()
        }

        // Assuming you have an imageView to display the result
        imageView.image = img
    }

}

