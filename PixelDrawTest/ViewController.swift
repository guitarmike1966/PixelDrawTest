//
//  ViewController.swift
//  PixelDrawTest
//
//  Created by mikey on 3/30/20.
//  Copyright © 2020 Sand Creek Software. All rights reserved.
//

import UIKit

class Canvas: UIView {
    override func draw(_ rect: CGRect) {

        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext()
            else
            {
                print("Error getting current context")
                return
            }
        
        print("Get Current Context successful")
        
        // context.setStrokeColor(UIColor.red.cgColor)
        // context.stroke(CGRect(x: 50, y: 50, width: 50, height: 50))
        
        for x in 50..<150 {
            // context.stroke(CGRect(x: x, y: 200, width: 2, height: 2))
            setPixel(context: context,x: x,y: 200,color: UIColor.yellow)
        }

        for x in 50..<200 {
            // context.stroke(CGRect(x: x, y: 200, width: 2, height: 2))
            setPixel(context: context,x: x,y: 250,color: UIColor.red)
        }
    }
    
    private func setPixel(context: CGContext, x: Int, y: Int, color: UIColor)
    {
        context.setLineWidth(1)
        context.setStrokeColor(color.cgColor)
        context.stroke(CGRect(x: x, y: y, width: 1, height: 1))
    }

}


class ViewController: UIViewController {

    let canvas = Canvas()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.view.addSubview(canvas)
        canvas.frame = view.frame
    }

}




extension UIView {
    func getColor(point: CGPoint) -> UIColor {
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

        var pixelData: [UInt8] = [0, 0, 0, 0]

        let context = CGContext(data: &pixelData, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        context!.translateBy(x: -point.x, y: -point.y)

        self.layer.render(in: context!)

        let red: CGFloat = CGFloat(pixelData[0]) / CGFloat(255.0)
        let green: CGFloat = CGFloat(pixelData[1]) / CGFloat(255.0)
        let blue: CGFloat = CGFloat(pixelData[2]) / CGFloat(255.0)
        let alpha: CGFloat = CGFloat(pixelData[3]) / CGFloat(255.0)

        let color: UIColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)

        return color
    }

//    func setColor(point: CGPoint, color: UIColor) {
//        let elementSize = 5
//
//        guard let context = UIGraphicsGetCurrentContext()
//            else {
//                print("Error getting current context")
//                return
//        }
//
//        context.setFillColor(color.cgColor)
//        context.fill(CGRect(x: point.x, y: point.y, width: CGFloat(elementSize), height: CGFloat(elementSize)))
//    }
    
    
}

