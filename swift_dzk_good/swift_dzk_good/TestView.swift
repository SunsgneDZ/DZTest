//
//  TestView.swift
//  swift_dzk
//
//  Created by dzk on 2017/7/6.
//  Copyright © 2017年 dzk. All rights reserved.
//

import UIKit



protocol mydelegate : NSObjectProtocol{
    func changeTheValue(str : String)
}

class TestView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var a = String()
    var btn = UIButton()
    
    
    weak var del : mydelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame:frame)
        
        btn = UIButton.init(frame: CGRect(x:0,y:0,width:100,height:40))
        btn.setTitle("点击", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        self.addSubview(btn)
        
    }
    
    //btn action 
    func btnAction() -> Void {
        self.del?.changeTheValue(str: "dzk")
    }
  
    
    
    
    func change(string:String) {
      
    }
    
}
