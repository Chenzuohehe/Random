//
//  ViewController.swift
//  MyRandom
//
//  Created by ChenZuo on 2017/1/15.
//  Copyright © 2017年 ChenZuo. All rights reserved.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var repeatSegmented: UISegmentedControl!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var backVis: UIVisualEffectView!
    
    var array:[Int] = []
    let string:String = "点击屏幕\n或\n摇一摇生成随机数"
    var isRepeat:Bool = true
    var gradientLayer:CAGradientLayer = CAGradientLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.promptLabel.text = self.string
        UIApplication.shared.applicationSupportsShakeToEdit = true
        self.mainLabel.adjustsFontSizeToFitWidth = true
        changeBackGroudColor()
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        self.mainText()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mainText() {
        changeBackGroudColor()
        self.hiddenTextField()
        //字符串判断
        let min:Int? = Int(self.minTextField.text!)
        let max:Int? = Int(self.maxTextField.text!)
        let num:Int? = Int(self.numberTextField.text!)
        if min == nil || max == nil || num == nil {
            self.mainLabel.text = "请输入正确的数字"
            return
        }
        if min! >= max! {
            self.mainLabel.text = "最小数需要小于最大数"
            return
        }
        if num! > 1000{
            self.mainLabel.text = "请输入正常范围的数字😶"
            return
        }
        
        //选择重复
        if isRepeat {
            randomNumber(min: min!, max: max!, num: num!)
        }else{//选择不重复
            //还要判断是不是个数超过
            if (max! - min! + 1) < num! {
                self.mainLabel.text = "不重复的随机数个数太多了，超过了（最大数-最小数）"
                return
            }
            randomNumberNoRepeat(min: min!, max: max!, num: num!)
        }
        //拼接结果
        var Mstring:String = ""
        for i in 0..<self.array.count {
            let num = self.array[i]
            if i == 0 {
                Mstring = Mstring + String(num)
            }else{
                Mstring = Mstring + "，" + String(num)
            }
        }
        self.mainLabel.text = Mstring
    }
    
    //重复随机
    func randomNumber(min:Int, max:Int, num:Int) {
        self.array = []
        for _ in 0..<num {
            let number = (UInt32)(max - min + 1)
            self.array.append((Int)(arc4random_uniform(number)) + min)
        }
    }
    //不重复随机
    func randomNumberNoRepeat(min:Int, max:Int, num:Int) {
        var keyArray = Array(min...max)
        var returnArray = Array(repeating: 0, count: num)
        for i in 0..<num {
            let count = UInt32(keyArray.count - i);//还拥有的可以用数字个数
            let index = (Int)(arc4random_uniform(count))
            returnArray[i] = keyArray[index]
            keyArray[index] = keyArray[Int(count) - 1]
        }
        self.array = returnArray
    }
    
    //切换重复不重复状态
    @IBAction func repeatChange(_ sender: UISegmentedControl) {
        self.isRepeat = (sender.selectedSegmentIndex == 0)
    }
    
    @IBAction func tap(_ sender: Any) {
        self.mainText()
    }
    //隐藏键盘
    func hiddenTextField() {
        self.minTextField.resignFirstResponder()
        self.maxTextField.resignFirstResponder()
        self.numberTextField.resignFirstResponder()
        self.becomeFirstResponder()
    }
    func changeBackGroudColor() {
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [randomColor().cgColor,randomColor().cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.backVis.layer.addSublayer(gradientLayer)
    }
    
}

