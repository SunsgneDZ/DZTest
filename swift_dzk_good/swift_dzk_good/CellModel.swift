//
//  CellModel.swift
//  swift_dzk_good
//
//  Created by dzk on 2017/7/8.
//  Copyright © 2017年 dzk. All rights reserved.
//

import UIKit

class CellModel: NSObject {

    
    var title = String()
    var cid = String()
    
    
    //自定义
    init(dic : NSDictionary)
    {
        super.init()
        
        //解析
        self.setValuesForKeys(dic as! [String : Any])
        
    }
    
    //防止为声明属性问题
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
