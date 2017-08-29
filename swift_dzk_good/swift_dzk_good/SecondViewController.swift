//
//  SecondViewController.swift
//  swift_dzk
//
//  Created by dzk on 2017/7/5.
//  Copyright © 2017年 dzk. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    var type_dzk = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(type_dzk)")
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        
        let scrollview = UIScrollView()
        scrollview.frame = CGRect(x:0,y:20,width:self.view.bounds.size.width,height:100)
        scrollview.isPagingEnabled = true
        self.view.addSubview(scrollview)
        let img = UIImageView()
        img.frame = CGRect(x:0,y:0,width:scrollview.bounds.size.width,height:100)
        img.backgroundColor = UIColor.red
        img.image = UIImage.init(named: "1.jpg")
        
        let img1 = UIImageView()
        img1.frame = CGRect(x:scrollview.bounds.size.width,y:0,width:scrollview.bounds.size.width,height:100)
        img1.backgroundColor = UIColor.green
        
        scrollview.addSubview(img1)
        scrollview.addSubview(img)
        scrollview.contentSize = CGSize(width:2*self.view.bounds.size.width,height:100)
        
    
        //UIButton的使用
        let button = UIButton(frame:CGRect(x:10,y:140,width:60,height:40))
        button.setTitle("back", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action:#selector(buttonAction), for:.touchUpInside)
        self.view.addSubview(button)
        
        let button2 = UIButton(frame:CGRect(x:180,y:140,width:60,height:40))
        button2.setTitle("push", for: .normal)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button2.setTitleColor(UIColor.white, for: .normal)
        button2.backgroundColor = UIColor.blue
        button2.addTarget(self, action:#selector(buttonAction2), for:.touchUpInside)
        self.view.addSubview(button2)
        
        // 创建一个浏览器工具条，并设置它的大小和位置
        let browserToolbar =  UIToolbar(frame:CGRect(x:10, y:200, width:320, height:44))
        // 将工具条添加到当前应用的界面中
        self.view.addSubview(browserToolbar)
        
        
        
        let btn1 =  UIBarButtonItem(barButtonSystemItem:.compose,
                                    target:nil, action:nil);
        let btn0 =  UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btn2 =  UIBarButtonItem(barButtonSystemItem:.add,
                                    target:nil, action:nil);
        let btn3 =  UIBarButtonItem(barButtonSystemItem:.flexibleSpace,
                                    target:nil, action:nil);
        let btn4 =  UIBarButtonItem(barButtonSystemItem:.reply,
                                    target:nil, action:nil);
        
        browserToolbar.setItems([btn1,btn0,btn2,btn3,btn4], animated: false)
       
        let width = self.view.bounds.size.width-20
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView.init(frame: CGRect(x:10,y:300,width:width,height:300), collectionViewLayout: layout)
        layout.itemSize = CGSize(width:(width-50)/4,height:(width-50)/4)
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.scrollDirection = .horizontal//水平
        
        
        view.delegate = self
        view.dataSource = self
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cid")
        self.view.addSubview(view)
        
            
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cid", for: indexPath)
        cell.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "1.jpg")!)
        return cell
    }

    
    func buttonAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    func buttonAction2() -> Void {
        
        let third = ThirdViewController()
        
        self.present(third, animated: true, completion: nil)
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
