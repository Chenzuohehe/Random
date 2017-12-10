//
//  RandomModel.swift
//  MyRandom
//
//  Created by ChenZuo on 2017/12/10.
//  Copyright © 2017年 ChenZuo. All rights reserved.
//

import UIKit

class RandomModel: NSObject,NSCoding {
    var title:String?
    var randomItems:[String]?
    
    required init(title: String, items:[String]) {
        self.title = title
        self.randomItems = items
    }
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "Title") as? String ?? ""
        self.randomItems = aDecoder.decodeObject(forKey: "RandomItems") as? [String] ?? [""]
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "Title")
        aCoder.encode(self.randomItems, forKey: "RandomItems")
    }
}
