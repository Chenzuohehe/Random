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
    
    var random:RandomModel?
    
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
    }
        
    /**======================================================
     alertView
     */
    override func viewWillAppear(_ animated: Bool) {
        if self.random?.title == nil {
            addNameAlert(msg: "比如：\"中午吃什么\"、\"随机背单词\"")
        }else{
            self.title = self.random?.title
            self.stringArray = (self.random?.randomItems)!
        }
        
    }
    func addNameAlert(msg: String) {
        let alertView = UIAlertView(title: "请输入随机内容的标题", message: msg, delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
        alertView.alertViewStyle = .plainTextInput
        
        let titleTextField = alertView.textField(at: 0)
        titleTextField?.placeholder = "名称"
        alertView.show()
    }
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            self.navigationController?.popViewController(animated: true)
        default:
            print("确认")
            let textField = alertView.textField(at: 0)
            let text:String = (textField?.text)!
            
            let randoms = getRandoms()
            for item in randoms {
                if text == (item as! RandomModel).title {
                    addNameAlert(msg: "随机名称不能重复")
                    return
                }
            }
            if text.count > 0 {
                self.title = textField?.text
            }else{
                addNameAlert(msg: "随机名称不能为空")
            }
        }
    }
    
    /**======================================================
     colletionView
     */
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //点击删除 对应字符串
        let string = stringArray[indexPath.row]
        print(string)
        stringArray.remove(at: indexPath.row)
        self.mainCollectionView.reloadData()
    }
    
    /**======================================================
     
     */
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        self.mainTextField.resignFirstResponder()
    }
    @IBAction func confirAdd(_ sender: UIBarButtonItem) {
        let string:String = mainTextField.text!
        if string.count > 0 {
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
        if self.stringArray.count == 0 {
            //没有元素
            let alertView = UIAlertView(title: "随机元素个数为0", message: "", delegate: nil, cancelButtonTitle: "取消")
            alertView.show()
            return
        }
        saveRandom()
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveRandom() {
        if self.random?.title != nil {
            delectRandom(random: self.random!)
        }
        let random = RandomModel(title: self.title!, items: self.stringArray)
        addRandom(random: random)
    }
    func hiddenTextField() {
        self.mainTextField.resignFirstResponder()
    }
}
