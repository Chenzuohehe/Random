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
        dataArray = getRandoms() as NSArray
        self.mainTableView.reloadData()
    }
    
    //初始化的展示数据，还有删除 还有动态的动画
    //真心话大冒险（数据也是可以请求外面的，也可以是写好的了固定数据哦） 吃什么（数据请求可以从外面获取哦），自己可以搭建一个简单的后台
    //侧滑边上再加一个自定义。现在做的就是自定义
    //
    
    // 边上一个 + 一个<-  中间就是自定义选择项的名字 哈哈哈我怎么感觉加上这个功能之后下载量会减少
    
    
    /**======================================================
     tableView
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let random = dataArray[indexPath.row] as! RandomModel
        cell?.textLabel?.text = random.title
        cell?.selectionStyle = .none
        cell?.backgroundColor = .white
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("我点击了这个随机")
        showPickView()
        let random = dataArray[indexPath.row] as! RandomModel
        print(random.randomItems)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.backgroundColor = colorforIndex(indexPath.row)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editRowAction = UITableViewRowAction(style: .default, title: "编辑") { (sender, index) in
            print("编辑")
            //跳转到已有页面
            let random = self.dataArray[index.row] as! RandomModel
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = mainStoryBoard.instantiateViewController(withIdentifier: "addView") as! AddViewController
            nextViewController.random = random
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        editRowAction.backgroundColor = UIColor.yellow
        let deleteRowAction = UITableViewRowAction(style: .default, title: "删除") { (sender, index) in
            let random = self.dataArray[index.row] as! RandomModel
            delectRandom(random: random)
            self.dataArray = getRandoms() as NSArray
            self.mainTableView.deleteRows(at: [index], with: .top)
        }
        deleteRowAction.backgroundColor = UIColor.orange
        return [deleteRowAction,editRowAction]
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
    func changeBackGroudColor() {
        self.mainTableView.backgroundColor = randomColor()
    }
}
