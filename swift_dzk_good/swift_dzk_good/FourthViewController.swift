//
//  FourthViewController.swift
//  swift_dzk
//
//  Created by dzk on 2017/7/6.
//  Copyright © 2017年 dzk. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController ,SliderGalleryControllerDelegate{

    
    var img : UIImageView?

    var dataArray : NSArray?
    
    var slider : SliderGalleryController?
    
    //获取屏幕宽度
    let screenWidth =  UIScreen.main.bounds.size.width
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let button = UIButton(frame:CGRect(x:10,y:64+20,width:60,height:40))
        button.setTitle("back", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action:#selector(buttonAction), for:.touchUpInside)
        self.view.addSubview(button)
        
        let button2 = UIButton(frame:CGRect(x:self.view.bounds.size.width-60-10,y:64+20,width:60,height:40))
        button2.setTitle("start", for: .normal)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button2.setTitleColor(UIColor.white, for: .normal)
        button2.setTitleColor(UIColor.red, for: .selected)
        button2.backgroundColor = UIColor.blue
        button2.addTarget(self, action:#selector(startAction(btn:)), for:.touchUpInside)
        self.view.addSubview(button2)
        
        let lab = UILabel.init(frame: CGRect(x:0,y:64+20,width:100,height:30))
        lab.center.x = self.view.center.x
        lab.text = "swift动画学习"
        lab.textColor = UIColor.purple
        self.view.addSubview(lab)
        lab.adjustsFontSizeToFitWidth = true
        
        
        let image = UIImage.init(named: "1.jpg")
        image?.stretchableImage(withLeftCapWidth: 10, topCapHeight:10)
        
        img = UIImageView(image:image)
        img?.backgroundColor = UIColor.yellow
        img?.frame = CGRect(x:0,y:0,width:0,height:0)
        self.view.addSubview(img!)
//        img?.contentMode = .scaleAspectFit
        self.img?.frame = CGRect(x:10, y:64+60, width:300, height:200)
        
        
        
        
        
        dataArray = ["http://bizhi.zhuoku.com/bizhi2008/0516/3d/3d_desktop_13.jpg",
                     "http://tupian.enterdesk.com/2012/1015/zyz/03/5.jpg",
                     "http://img.web07.cn/UpImg/Desk/201301/12/desk230393121053551.jpg",
                     "http://www.gurubear.com.cn/editor/uploadfile/20130826151723.jpg",
                     "http://bizhi.zhuoku.com/wall/jie/20061124/cartoon2/cartoon014.jpg"]
        
        self.slider = SliderGalleryController()
        self.slider?.delegate = self;
        self.slider?.view.frame = CGRect(x:10,y:300,width:300,height:200)
        self.addChildViewController(self.slider!)
        self.view.addSubview((self.slider?.view)!)
        
        
        let btn3 = UIButton.init(frame: CGRect(x:10,y:510,width:100,height:30))
        btn3.setTitle("跳转搜索", for: .normal)
        btn3.setTitleColor(UIColor.red, for: .normal)
        self.view.addSubview(btn3)
        btn3.backgroundColor = UIColor.gray
        btn3.addTarget(self, action: #selector(pushToSearch), for: .touchUpInside)
        
        
    }
    func pushToSearch() -> () {
        let fifth = FifthViewController()
        self.navigationController?.pushViewController(fifth, animated: true)
        
    }
    
    
    //图片轮播组件协议方法：获取内部scrollView尺寸
    func galleryScrollerViewSize() -> CGSize {
        return CGSize(width: 300, height: 200)
    }
    
    //图片轮播组件协议方法：获取数据集合
    func galleryDataSource() -> [String] {
        return self.dataArray as! [String]
    }
    
    
    func buttonAction() -> Void {
        //判断是否是present
        if ((self.presentingViewController) != nil) {
            
            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }

    //开始动画
    
    func startAction(btn : UIButton) -> Void {
       
        btn.isSelected = !btn.isSelected

        //平移
//        UIView.animate(withDuration: 1) {
//            self.img?.frame = CGRect(x:10, y:60, width:300, height:150)
//        }

        //转场动画
        self.img?.alpha = 1
        UIView.transition(with: img!, duration: 1.2, options: .transitionFlipFromLeft, animations: {
        }) { (Bool) in
//            UIView.animate(withDuration: 0.8, animations: { 
//                self.img?.alpha = 0
//            })
        }

        /*
        //移动动画
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)
        self.img?.center = CGPoint(x:250, y:250)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeOut) //设置动画相对速度
        UIView.commitAnimations()
        */
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
//   MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}
