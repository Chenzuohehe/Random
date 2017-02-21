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

func RGB(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

func randomColor() -> UIColor {
    let red:CGFloat = (CGFloat)(arc4random_uniform(80))/255.0 + 0.5
    let green:CGFloat = (CGFloat)(arc4random_uniform(80))/255.0 + 0.5
    let blue:CGFloat = (CGFloat)(arc4random_uniform(80))/255.0 + 0.5
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

func czFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: fontSize);
}

func stringSize(string:String , superSize:CGSize , font:CGFloat) -> CGSize {
    let rect = string.boundingRect(with: superSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: font)], context: nil)
    return rect.size
}

//存在一个里面还是两个里面呢？ 还是一个里面吧
//存在一个array 里面 每个元素就是一个 dic key 就是 random 名称 array 里面每一个都是model
class RandomModel : NSObject {
    var randomName:String = ""
    var randomArray:Array<String> = []
    
}
