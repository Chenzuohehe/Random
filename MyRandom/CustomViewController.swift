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
    
    @IBOutlet weak var backVisView: UIVisualEffectView!
    
    var userDefault:UserDefaults = UserDefaults.standard
    var dataArray = NSArray()
    
    let pickView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackGroudColor()
        self.mainTableView.register(GradientcolorTableViewCell.self, forCellReuseIdentifier: "cell")
        self.mainTableView.tableFooterView = UIView()
        self.mainTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (userDefault.object(forKey: ARRAYKEY) != nil) {
            print("ARRAYKEY 不为空")
            dataArray = userDefault.object(forKey: ARRAYKEY) as! NSArray
            print("这个不空", dataArray)
        }else{
            print("ARRAYKEY 为空")
            userDefault.setValue(dataArray, forKey: ARRAYKEY)
            print("这个应该是空", dataArray)
        }
        
        self.mainTableView.reloadData()
        
        
        
    }
    
    //初始化的展示数据，还有删除 还有动态的动画
    //真心话大冒险（数据也是可以请求外面的，也可以是写好的了固定数据哦） 吃什么（数据请求可以从外面获取哦），自己可以搭建一个简单的后台
    //侧滑边上再加一个自定义。现在做的就是自定义
    //
    
    // 边上一个 + 一个<-  中间就是自定义选择项的名字 哈哈哈我怎么感觉加上这个功能之后下载量会减少
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let dic = dataArray[indexPath.row] as! NSDictionary
        cell?.textLabel?.text = dic["name"] as? String
        cell?.selectionStyle = .none
        cell?.backgroundColor = .white
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("我点击了这个随机")
        showPickView()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = colorforIndex(indexPath.row)
    }
    
    func colorforIndex(_ index: Int) -> UIColor {
        
        let itemCount = dataArray.count - 1
        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.7
        return UIColor(red: 1.0, green: color, blue: 0, alpha: 1.0)
        
    }
    
    func showPickView() {
        // 点击后出现pickView 然后随机； + 就到下一个页面去collection view 可以添加
        UIView.animate(withDuration: 0.5) { 
            
        }
    }
    
    
    func deleteRandom() {
        //删除随机
    }
    
    func changeBackGroudColor() {
        self.mainTableView.backgroundColor = randomColor()
    }
}
