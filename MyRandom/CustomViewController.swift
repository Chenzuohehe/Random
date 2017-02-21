//
//  CustomViewController.swift
//  MyRandom
//
//  Created by ChenZuo on 2017/1/15.
//  Copyright © 2017年 ChenZuo. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mainTableView: UITableView!
    var userDefault:UserDefaults = UserDefaults.standard
    var dataArray = NSMutableArray()
    
    
    let pickView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if userDefault.objectIsForced(forKey: "dataArray") {
            dataArray = userDefault.object(forKey: "dataArray") as! NSMutableArray
        }else{
            userDefault.setValue(dataArray, forKey: "dataArray")
        }
    }
    
    // 边上一个 + 一个<-  中间就是自定义选择项的名字 哈哈哈我怎么感觉加上这个功能之后下载量会减少
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "今晚吃什么"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("我点击了这个随机")
    }
    
    func showPickView() {
        // 点击后出现pickView 然后随机； + 就到下一个页面去collection view 可以添加
    }
}
