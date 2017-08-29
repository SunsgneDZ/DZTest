//
//  TestCell.swift
//  swift_dzk_good
//
//  Created by dzk on 2017/7/8.
//  Copyright © 2017年 dzk. All rights reserved.
//

import UIKit

class TestCell: UITableViewCell {

    var lab : UILabel?
    var img : UIImageView?
    var text_lab : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        self.backgroundColor = UIColor.gray
        
        self.lab = UILabel.init()
        self.lab?.textColor = UIColor.black
        self.contentView.addSubview(self.lab!)
//        self.lab?.frame = CGRect(x:100,y:0,width:100,height:40)

        
        self.img = UIImageView.init()
//        self.img?.frame = CGRect(x:0,y:0,width:40,height:40)
        self.img?.image = UIImage.init(named: "1.jpg")
        self.contentView.addSubview(self.img!)
        
        
        self.text_lab = UILabel.init()
        self.text_lab?.textColor = UIColor.red
        self.contentView.addSubview(self.text_lab!)
        
        
    }
    
    func setCellModel(model:CellModel) -> () {
       
        self.lab?.text = model.title
        self.lab?.frame = CGRect(x:100,y:0,width:100,height:40)
        
        self.img?.frame = CGRect(x:0,y:0,width:40,height:40)
        
        
        self.text_lab?.text = "cid = \(model.cid)"
        self.text_lab?.frame = CGRect(x:250,y:0,width:80,height:40)
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
