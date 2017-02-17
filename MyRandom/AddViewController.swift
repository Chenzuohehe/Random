//
//  AddViewController.swift
//  MyRandom
//
//  Created by ChenZuo on 2017/2/14.
//  Copyright © 2017年 ChenZuo. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UICollectionViewDataSource, CZCollectionViewDelegateLeftAlignedLayout {
    
    @IBOutlet weak var mainTextField: UITextField!

    @IBOutlet weak var mainCollectionView: UICollectionView!
    var stringArray = [String]()
    let cellHeight = 40
    let cellFont = CGFloat(14)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = CZCollectionViewLeftAlignedLayout()
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        mainCollectionView.collectionViewLayout = layout
        mainCollectionView.register(CZTextCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CZTextCollectionViewCell
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let string = stringArray[indexPath.row]
        cell.textLabel.text = string
        var width = stringSize(string: string, superSize: CGSize(width: 0, height: cellHeight), font: cellFont).width
        if width > SCREEN_WIDTH - 20 {
            width = SCREEN_WIDTH - 20
        }
        
//
//        let stringLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Int(width) + 10, height: cellHeight))
//        stringLabel.text = string
//        stringLabel.font = UIFont.systemFont(ofSize: cellFont)
//        stringLabel.textAlignment = .center
//        stringLabel.textColor = .black
//        cell.addSubview(stringLabel)
//        cell.backgroundColor = .gray
        
        cell.layer.cornerRadius = 3
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = RGB(r: 86, g: 86, b: 86).cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let string = stringArray[indexPath.row]
        var width = stringSize(string: string, superSize: CGSize(width: 0, height: cellHeight), font: cellFont).width
        if width > SCREEN_WIDTH - 20 {
            width = SCREEN_WIDTH - 20
        }
        return CGSize(width: width, height: CGFloat(cellHeight))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stringArray.count
    }
    
    
    
    @IBAction func confirAdd(_ sender: UIBarButtonItem) {
        if let string = mainTextField.text {
            stringArray.append(string)
            mainTextField.text = ""
            mainCollectionView.reloadData()
        }else{
            print("没输入");
        }
        
    }
}
