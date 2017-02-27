//
//  Common.swift
//  MyRandom
//
//  Created by ChenZuo on 2017/2/16.
//  Copyright © 2017年 ChenZuo. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let ARRAYKEY = "dataArray"


func RGB(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

func randomColor() -> UIColor {
    let red:CGFloat = (CGFloat)(arc4random_uniform(80))/255.0 + 0.6
    let green:CGFloat = (CGFloat)(arc4random_uniform(80))/255.0 + 0.6
    let blue:CGFloat = (CGFloat)(arc4random_uniform(80))/255.0 + 0.6
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

func czFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: fontSize);
}

func stringSize(string:String , superSize:CGSize , font:CGFloat) -> CGSize {
    let rect = string.boundingRect(with: superSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: font)], context: nil)
    return rect.size
}

func randomGradientLayer(frame:CGRect) -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = frame
    gradientLayer.colors = [randomColor().cgColor,randomColor().cgColor]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    return gradientLayer
}

