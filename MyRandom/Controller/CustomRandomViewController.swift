//
//  CustomRandomViewController.swift
//  MyRandom
//
//  Created by ChenZuo on 2017/12/11.
//  Copyright © 2017年 ChenZuo. All rights reserved.
//

import UIKit

class CustomRandomViewController: UIViewController {

    @IBOutlet weak var backVis: UIVisualEffectView!
    @IBOutlet weak var numberTextField: UITextField!
//    @IBOutlet weak var repeatSemented: UISegmentedControl!
    @IBOutlet weak var mainLabel: UILabel!
    
    var randomModel:RandomModel!
    var isRepeat:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.randomModel.title
        self.numberTextField.text = String(self.randomModel.randomItems.count)
        setMainText()
        
        //摇一摇功能打开
        UIApplication.shared.applicationSupportsShakeToEdit = true
        //字号自适应
        self.mainLabel.adjustsFontSizeToFitWidth = true
        changeBackGroudColor()
    }
    
    //不重复随机
    func returnRandomArray(num:Int) -> [String] {
        var keyArray = Array(0...self.randomModel.randomItems.count-1)
        var returnArray = Array(repeating: "", count: num)
        for i in 0..<num {
            let count = UInt32(keyArray.count - i);//还拥有的可以用数字个数
            let index = (Int)(arc4random_uniform(count))
            returnArray[i] = self.randomModel.randomItems[keyArray[index]]
            keyArray[index] = keyArray[Int(count) - 1]
        }
        return returnArray
    }
    
    func setMainText() {
        self.hiddenTextField()
        var Mstring:String = ""
        let num:Int! = Int(self.numberTextField.text!)
        let randomArray = returnRandomArray(num: num)

        for i in 0..<randomArray.count {
            let str = randomArray[i]
            if i == 0 {
                Mstring = Mstring + String(str)
            }else{
                Mstring = Mstring + "，" + String(str)
            }
        }
        self.mainLabel.text = Mstring
    }
    
    //摇一摇
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        self.setMainText()
    }
    
    
    
    
    
    @IBAction func tap(_ sender: Any) {
        self.setMainText()
    }
    //隐藏键盘
    func hiddenTextField() {
        self.numberTextField.resignFirstResponder()
        self.becomeFirstResponder()
    }
    //改变背景色
    func changeBackGroudColor() {
        let gradientLayer = randomGradientLayer(frame: self.view.bounds)
        self.backVis.layer.addSublayer(gradientLayer)
    }

}
