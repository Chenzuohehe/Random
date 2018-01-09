//
//  AddViewController.swift
//  MyRandom
//
//  Created by ChenZuo on 2017/2/14.
//  Copyright © 2017年 ChenZuo. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UICollectionViewDataSource, UIGestureRecognizerDelegate, UITextFieldDelegate, CZCollectionViewDelegateLeftAlignedLayout {
    
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddViewController.touchView))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let supClass = NSStringFromClass((touch.view?.superview!.classForCoder)!)
        if supClass == "MyRandom.CZTextCollectionViewCell" {
            return false
        }
        return true
    }
    
    /**======================================================
     alertView
     */
    override func viewWillAppear(_ animated: Bool) {
        if self.random?.title == nil {
            addNameAlert(msg: "比如：\"中午吃什么\"、\"随机背单词\"\n\n（全部输入完成，点击空白隐藏键盘，底部确认）")
        }else{
            self.title = self.random?.title
            self.stringArray = (self.random?.randomItems)!
        }
        
    }
    func addNameAlert(msg: String) {
        
        let alert = UIAlertController(title: "请输入随机内容的标题", message: msg, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let cencelAction = UIAlertAction(title: "取消", style: .cancel, handler: {sender in
            self.navigationController?.popViewController(animated: true)
        })
        let confrimAction = UIAlertAction(title: "确认", style: .default) { (sender) in
            print("确认")
            let text = alert.textFields![0].text
            let randoms = getRandoms()
            for item in randoms {
                if text == (item as! RandomModel).title {
                    self.addNameAlert(msg: "随机名称不能重复")
                    return
                }
            }
            if text != nil {
                if text != ""{
                    self.title = text
                }else{
                    self.addNameAlert(msg: "随机名称不能为空")
                }
            }else{
                self.addNameAlert(msg: "随机名称不能为空")
            }
        }
        alert.addAction(cencelAction)
        alert.addAction(confrimAction)
        self.navigationController?.present(alert, animated: true, completion: nil)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.confirmAddItem()
        return true
    }
    
    func touchView(_ sender: UITapGestureRecognizer) {
        self.mainTextField.resignFirstResponder()
    }
    @IBAction func confirAdd(_ sender: UIBarButtonItem) {
        self.confirmAddItem()
    }
    @IBAction func confirm(_ sender: Any) {
        
        if self.stringArray.count == 0 {
            //没有元素
            let cencelAlert = UIAlertController(title: "随机元素个数为0", message: nil, preferredStyle: .alert)
            let cencelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            cencelAlert.addAction(cencelAction)
            self.navigationController?.present(cencelAlert, animated: true, completion: nil)
            
            return
        }
        saveRandom()
        self.navigationController?.popViewController(animated: true)
    }
    func confirmAddItem() {
        let string:String = mainTextField.text!
        if string.count > 0 {
            stringArray.append(string)
            mainTextField.text = ""
            mainCollectionView.reloadData()
        }else{
            let cencelAlert = UIAlertController(title: "随机元素不能为空", message: nil, preferredStyle: .alert)
            let cencelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            cencelAlert.addAction(cencelAction)
            self.navigationController?.present(cencelAlert, animated: true, completion: nil)
        }
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
