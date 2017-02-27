//
//  AddViewController.swift
//  MyRandom
//
//  Created by ChenZuo on 2017/2/14.
//  Copyright © 2017年 ChenZuo. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UICollectionViewDataSource, UIAlertViewDelegate, CZCollectionViewDelegateLeftAlignedLayout {
    
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var userDefault:UserDefaults = UserDefaults.standard
    var stringArray = [String]()
    let cellHeight = 40
    let cellFont = CGFloat(14)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = CZCollectionViewLeftAlignedLayout()
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        mainCollectionView.collectionViewLayout = layout
        mainCollectionView.register(CZTextCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addNameAlert(msg: "")
    }
    
    func addNameAlert(msg: String) {
        let alertView = UIAlertView(title: "请输入随机名称", message: msg, delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
        alertView.title = "请输入随机名称"
        alertView.alertViewStyle = .plainTextInput
        
        let titleTextField = alertView.textField(at: 0)
        titleTextField?.placeholder = "名称"
        alertView.show()
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            _ = self.navigationController?.popViewController(animated: true)
        default:
            print("确认")
            let textField = alertView.textField(at: 0)
            let text:String = (textField?.text)!
            
            if text.characters.count > 0 {
                self.title = textField?.text
            }else{
                addNameAlert(msg: "随机名称不能为空")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CZTextCollectionViewCell
        let string = stringArray[indexPath.row]
        cell.textLabel.text = string
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let string = stringArray[indexPath.row]
        var width = stringSize(string: string, superSize: CGSize(width: 0, height: cellHeight), font: cellFont).width
        if width > SCREEN_WIDTH - 40 {
            width = SCREEN_WIDTH - 40
        }
        return CGSize(width: width + 20, height: CGFloat(cellHeight))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stringArray.count
    }
    
    func hiddenTextField() {
        self.mainTextField.resignFirstResponder()
    }
    
    @IBAction func confirAdd(_ sender: UIBarButtonItem) {
        let string:String = mainTextField.text!
        if string.characters.count > 0 {
            stringArray.append(string)
            mainTextField.text = ""
            mainCollectionView.reloadData()
        }else{
            let alertView = UIAlertView(title: "随机元素不能为空", message: "", delegate: nil, cancelButtonTitle: "取消")
            alertView.show()
        }
    }
    
    
    
    @IBAction func confirm(_ sender: Any) {
        //userd
        //假装我做了判断
        saveRandom()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func saveRandom() {
        var array = userDefault.object(forKey: ARRAYKEY) as! NSArray
        let mutaleArray:NSMutableArray = NSMutableArray(array: array)
        
        let msgDic:NSDictionary = NSDictionary(dictionary: ["name":self.title!, "members":self.stringArray])
        mutaleArray.add(msgDic)
        array = mutaleArray
        userDefault.set(array, forKey: ARRAYKEY)
        
        let dataArray = userDefault.object(forKey: ARRAYKEY) as! NSArray
        print("这个不空", dataArray)

    }
    
}
