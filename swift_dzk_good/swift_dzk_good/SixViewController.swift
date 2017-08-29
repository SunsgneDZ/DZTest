//
//  SixViewController.swift
//  swift_dzk_good
//
//  Created by dzk on 2017/8/28.
//  Copyright © 2017年 dzk. All rights reserved.
//

import UIKit

class SixViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let backBtn = UIButton.init(frame: CGRect(x:20,y:84,width:100,height:40))
        backBtn.setTitle("返回", for: .normal)
        backBtn.setTitleColor(UIColor.black, for: .normal)
        backBtn.backgroundColor = UIColor.orange
        
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(backBtn)
        
        
        
        let string = "我怎么知道你是dzl"
        
        for c in string.characters {
            print("\(c)")
        }
        
        
        
        
    }
    func back() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
