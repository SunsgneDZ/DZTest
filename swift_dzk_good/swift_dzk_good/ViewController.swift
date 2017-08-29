//
//  ViewController.swift
//  swift_dzk
//
//  Created by dzk on 2017/7/5.
//  Copyright © 2017年 dzk. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import CoreMotion

//枚举
enum Peopel {
    case man
    case women
    case null
}


extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(_ reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(_ scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize)
    }
    
}

class ViewController: UIViewController , UITextFieldDelegate,mydelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
//    Swift - 可选类型说明
//    2015-04-09发布：hangge阅读：1283
//    可选类型是Swift的一个特色。它表示一个变量有可能有值，也可能没有值（nil）。
//    声明的方式是“数据类型+问号”。
//    而当要使用一个可选类型的变量是，要在后面加感叹号“!”。

    
    
//    var a : Int?
    
    
    
    //定义全局变量
    
    //switch
    var switch_dzk = UISwitch()
    //img
    var img = UIImageView()
    
    var timer = Timer()
   
    var textview = UITextView()
    //计步器对象
    let pedometer = CMPedometer()
    
    
    //以下为方法
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "测试页"
        
        
        //UILabel 的使用
        let label: UILabel = UILabel();//let label = UILabel()
        label.frame = CGRect(x:10,y:20,width:200,height:200);
        self.view.addSubview(label);
        //赋值
        label.text = "这是一个label";
        //对齐方式
        label.textAlignment = .center
        //背景颜色 和 字体颜色
        label.backgroundColor = UIColor.blue
        label.textColor = UIColor.white
        //阴影设置 偏移量
        label.shadowColor = UIColor.green
        label.shadowOffset = CGSize(width:1,height:1);
        //文字字体
        label.font = UIFont.systemFont(ofSize: 20);
        //适应宽度 调整字体大小
        label.adjustsFontSizeToFitWidth = true
        //显示多行
        label.numberOfLines = 0
        //文本高亮
//        label.isHighlighted = true;
//        label.highlightedTextColor = UIColor.red;
        //富文本设置
        let str = NSMutableAttributedString(string:label.text!)
        str.addAttribute(NSBackgroundColorAttributeName, value: UIColor.purple, range: NSMakeRange(2, 4))
        label.attributedText = str
        
        //UIButton的使用
        let button = UIButton(frame:CGRect(x:10,y:250,width:60,height:40))
        button.setTitle("跳转", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.tag = 100
        button.addTarget(self, action:#selector(buttonAction(btn:)), for:.touchUpInside)
        self.view.addSubview(button)
        
        let button2 = UIButton(frame:CGRect(x:80,y:250,width:120,height:40))
        button2.setTitle("跳转动画页面", for: .normal)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button2.setTitleColor(UIColor.white, for: .normal)
        button2.backgroundColor = UIColor.blue
        button2.tag = 102
        button2.addTarget(self, action:#selector(buttonAction(btn:)), for:.touchUpInside)
        self.view.addSubview(button2)
        
        
        let btn3 = UIButton.init(frame: CGRect(x:220,y:250,width:120,height:40))
        btn3.setTitle("跳转第六", for: .normal)
        btn3.setTitleColor(UIColor.white, for: .normal)
        btn3.backgroundColor = UIColor.blue
        btn3.tag = 103
        btn3.addTarget(self, action: #selector(buttonAction(btn:)), for: .touchUpInside)
        self.view.addSubview(btn3)
        
        
        //UItextfield的使用
        let textfield = UITextField()
        textfield.frame = CGRect(x:10,y:300,width:150,height:40)
        textfield.borderStyle = .roundedRect
        self.view.addSubview(textfield)
        textfield.placeholder = "请输入用户名"
        textfield.adjustsFontSizeToFitWidth = true//超过文本自动缩小字体
        textfield.minimumFontSize = 10
        
        textfield.returnKeyType = .done
        textfield.keyboardType = .decimalPad
        
        
        
        //设置背景图片
//        textfield.borderStyle = .none//先要去除边框样式
//        textfield.background = UIImage(named:"1.jpg")
        
        //设置代理
        textfield.delegate = self
        
        
        //记分牌demo留言记得查看
        
        
        //
        textview = UITextView(frame:CGRect(x:280, y:64+20, width:100, height:120))
        textview.layer.borderWidth = 1  //边框粗细
        textview.layer.borderColor = UIColor.gray.cgColor //边框颜色
        self.view.addSubview(textview)
        textview.dataDetectorTypes = UIDataDetectorTypes.all //电话和网址都加
        
        
        
        
        //开始计步器更新
        startPedometerUpdates()
        
        
        
        
        //switch
        switch_dzk.center = CGPoint(x:250,y:120)
        switch_dzk.isOn = true
        switch_dzk.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
        self.view.addSubview(switch_dzk)
        
        
        
        //选项除了文字还可以是图片
        let items = ["1","2","3"]
        let segmented = UISegmentedControl(items:items)
        segmented.frame = CGRect(x:0,y:350,width:300,height:40)
        segmented.selectedSegmentIndex = 1 //默认选中第二项
        segmented.addTarget(self, action: #selector(segmentDidchange(_:)),
                            for: .valueChanged)  //添加值改变监听
        self.view.addSubview(segmented)
        
        
        
        //UIImageView
        let img2 = UIImage.init(named: "1.jpg")
//        img2 = img2?.reSizeImage(CGSize(width:100,height:100))
//        img2 = img2?.scaleImage(0.5)
        img = UIImageView.init(image: img2)
        img.backgroundColor = UIColor.yellow
        img.frame = CGRect(x:10, y:400, width:300, height:150)
        self.view.addSubview(img)
        img.contentMode = .scaleAspectFit
        
        
        img.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageTap(tapper:)))
        img.addGestureRecognizer(tap)
        
    
        
        let test = TestView.init(frame: CGRect(x:10,y:600,width:100,height:40))
        self.view.addSubview(test)
        test.backgroundColor = UIColor.gray
//        test.changeTheValue(str: "dzk好帅")
        test.del = self
        
  
        
        
//        self.count(n: 10)
        
      
//        self.deal(p: .man)
        
        
        //创建定时器
//        timer = Timer.scheduledTimer(timeInterval: 5,
//                                     target: self,
//                                     selector: #selector(timerStart),
//                                     userInfo: ["1","2"],
//                                     repeats: true)
     
        
        
        //环形进度条
//        let load = UIActivityIndicatorView.init(frame: CGRect(x:160,y:600,width:40,height:40))
//        load.activityIndicatorViewStyle = .whiteLarge
//        load.color = UIColor.blue
//        load.tag = 1000;
//        self.view.addSubview(load)
//        
//        load.startAnimating()
        
        
//        lroundf是一个全局函数，作用是将浮点数四舍五入转为整数。
//        let i = lroundf(23.50) //24
//        print(i)
        
        
        
//        let dzk = "dzk好帅"
        
        //获得字符串数量
//        print("\(dzk.characters.count)")
        
        //判断是否为空
//        print(dzk.isEmpty)
        
        //检查是否还有前后缀
//        print(dzk.hasPrefix("d"))
        
        
//        let index = dzk.index(dzk.startIndex, offsetBy: 0)
//        let index2 = dzk.index(dzk.startIndex, offsetBy: 3)
//        let range = Range.init(uncheckedBounds: (lower: index, upper: index2))
//        let dz = dzk.substring(from: index)
//        let dz = dzk.substring(with: range)
//        print("\(dz)")
        
        
        
        let changeHead = UIButton(frame:CGRect(x:230,y:600,width:60,height:40))
        changeHead.setTitle("更换头像", for: .normal)
        changeHead.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        changeHead.setTitleColor(UIColor.red, for: .normal)
        changeHead.backgroundColor = UIColor.blue
        changeHead.addTarget(self, action:#selector(photo), for:.touchUpInside)
        self.view.addSubview(changeHead)
        
        
        
//        let player = AVPlayerViewController()
//        let p = AVPlayer.init(url: NSURL.init(string: "http://hangge.com/demo.mp4") as! URL)
//        player.player = p
//        self.present(player, animated: true, completion: nil)
        
        
        //需要pilst添加UIViewControllerBasedStatusBarAppearance字段为no
//        UIApplication.shared.statusBarStyle = .default
        
        
        
        
        //日期转时间戳
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        print("当前时间的时间戳：\(timeStamp)")
        
        //时间戳转日期
        //转换为时间
        let time:TimeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: time)
        //格式化输出
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        print("对应的日期时间：\(dformatter.string(from: date))")
        
        
        
        //模糊效果
        //首先创建一个模糊效果
//        let blurEffect = UIBlurEffect(style: .light)
//        //接着创建一个承载模糊效果的视图
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        //设置模糊视图的大小（全屏）
//        blurView.frame.size = self.img.bounds.size
//        //添加模糊视图到页面view上（模糊视图下方都会有模糊效果）
//        self.img.addSubview(blurView)
        
        
    
      
//        JQProgressHUDTool.jq_showToastHUD(view: self.view, msg: "dzk", duration: 1, isUserInteractionEnabled: false, animation: true);
        
//        JQProgressHUDTool.jq_showNormalHUD(msg:"loading")
//        //延时调用
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//              JQProgressHUDTool.jq_hideHUD()
//        }
//      
        
        
        //isNeedmask是否有遮罩层
        JQProgressHUDTool.jq_showNormalHUD(view: self.view, msg: "loading", isNeedmask: false, isUserInteractionEnabled: false, animation: true)
        //延时调用
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              JQProgressHUDTool.jq_hideHUD(view: self.view)
        }
        
        
        
        let label_view = UIView.init(frame: CGRect(x:10,y:650,width:60,height:60))
        label_view.backgroundColor = UIColor.orange
        self.view.addSubview(label_view)
        label_view.layer.cornerRadius = 30
        
        
        let lab1 = UILabel.init(frame: CGRect(x:5,y:20,width:30,height:20))
        lab1.text = "V"
        lab1.font = UIFont.boldSystemFont(ofSize: 24)
        lab1.textAlignment = .right
        lab1.textColor = UIColor.black
        label_view.addSubview(lab1)
        
        let lab2 = UILabel.init(frame: CGRect(x:35,y:22,width:20,height:20))
        lab2.text = "10"
        lab2.font = UIFont.boldSystemFont(ofSize: 16)
        lab2.textColor = UIColor.black
        lab2.textAlignment = .left
        label_view.addSubview(lab2)
  
        lab2.adjustsFontSizeToFitWidth = true
        
        
    }
    
    // 开始获取步数计数据
    func startPedometerUpdates() {
        //判断设备支持情况
        guard CMPedometer.isStepCountingAvailable() else {
            textview.text = "\n当前设备不支持获取步数\n"
            return
        }
        
        //获取今天凌晨时间
        let cal = Calendar.current
        var comps = cal.dateComponents([.year, .month, .day], from: Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let midnightOfToday = cal.date(from: comps)!
        
        //初始化并开始实时获取数据
        self.pedometer.startUpdates (from: midnightOfToday, withHandler: { pedometerData, error in
            //错误处理
            guard error == nil else {
                print(error!)
                return
            }
            
            //获取各个数据
            var text = "---今日运动数据---\n"
            if let numberOfSteps = pedometerData?.numberOfSteps {
                text += "步数: \(numberOfSteps)\n"
            }
            if let distance = pedometerData?.distance {
                text += "距离: \(distance)\n"
            }
            if let floorsAscended = pedometerData?.floorsAscended {
                text += "上楼: \(floorsAscended)\n"
            }
            if let floorsDescended = pedometerData?.floorsDescended {
                text += "下楼: \(floorsDescended)\n"
            }
            if let currentPace = pedometerData?.currentPace {
                text += "速度: \(currentPace)m/s\n"
            }
            if let currentCadence = pedometerData?.currentCadence {
                text += "速度: \(currentCadence)步/秒\n"
            }
            
            //在线程中更新文本框数据
            DispatchQueue.main.async{
                self.textview.text = text
            }
        })
    }

    
    func showLevel(string:String) -> Void {
        
        
        
        
    }
    
    
    
    func showHUD() -> () {
        
    }
    

    
    func partition( data:inout [Int],low:Int,high:Int) -> Int {
        
        let root = data[high]
        var index = low
        for i in low...high {
            if data[i] < root {
                if i != index {
                    swap(&data[i], &data[index])
                }
                index = index+1
            }
        }
        
        if high != index {
            swap(&data[high], &data[index])
        }
        return index
    }
    
    func quickSort(data:inout [Int],low:Int,high:Int) -> Void {
        if low > high {
            return
        }
        let sortIndex = partition(data: &data, low: low, high: high)
        quickSort(data: &data, low: low, high: sortIndex-1)
        quickSort(data: &data, low: sortIndex+1, high: high)
    }
    
//     img.frame = CGRect(x:10, y:400, width:300, height:150)
    func imageTap(tapper:UITapGestureRecognizer) -> Void {
        
        let imageView = tapper.view as? UIImageView
        
        UIView.animate(withDuration: 0.5) {
            imageView?.frame = self.view.bounds
        }
        
        //打开wx扫一扫
//        let urlString = "weixin://scanqrcode"
//        if let url = URL(string: urlString) {
//            //根据iOS系统版本，分别处理
//            if #available(iOS 10, *) {
//                UIApplication.shared.open(url, options: [:],
//                                          completionHandler: {
//                                            (success) in
//                })
//            } else {
//                UIApplication.shared.openURL(url)
//            }
//        }
        
    }
    
    
    func photo() -> Void {

        UIView.animate(withDuration: 1) {
            self.img.frame = CGRect(x:10, y:400, width:300, height:150)
        }
        
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        let alter = UIAlertController.init(title: "提示", message: nil, preferredStyle: .actionSheet)
        let a1 = UIAlertAction.init(title: "拍照", style: .default) { (UIAlertAction) in
            
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                //创建图片控制器
                //设置代理
//                picker.delegate = self
                //设置来源
                picker.sourceType = UIImagePickerControllerSourceType.camera
                //允许编辑
//                picker.allowsEditing = true
                //打开相机
                self.present(picker, animated: true, completion: { () -> Void in
                    
                })
            }else{
                print("找不到相机")
            }
            
            
        }
        let a2 = UIAlertAction.init(title: "相册", style: .default) { (UIAlertAction) in
            
            //判断设置是否支持图片库
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                //初始化图片控制器
//                let picker = UIImagePickerController()
                //设置代理
//                picker.delegate = self
                //指定图片控制器类型
                picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                //设置是否允许编辑
//                picker.allowsEditing = editSwitch.isOn
                //弹出控制器，显示界面
                self.present(picker, animated: true, completion: {
                    () -> Void in
                })
            }else{
                print("读取相册错误")
            }
            
        }
        let a3 = UIAlertAction.init(title: "取消", style: .cancel) { (UIAlertAction) in
            
        }
        alter.addAction(a1)
        alter.addAction(a2)
        alter.addAction(a3)
        
        self.present(alter, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print(info)
        
        if (info[UIImagePickerControllerEditedImage] != nil){
            self.img.image =  info[UIImagePickerControllerEditedImage] as? UIImage
        }else{
            self.img.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    //定时器方法
    func timerStart(t:Timer) -> Void {
        
        let load = self.view.viewWithTag(1000) as! UIActivityIndicatorView;
        
        load.stopAnimating()
    
        
//        //延时1秒执行
//        let time: TimeInterval = 1.0
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
//            //code
//            print("1 秒后输出")
//        }
        
        //延时调用
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            load.startAnimating() 
        }
        
        
       
    }
    
    
    
    
    func deal(p : Peopel) -> Void {
        switch p {
        case .man:
            print("男的")
            
        case .women:
            print("女的")
            
        default:
            print("null")
            
        }
    }
    
  
    func count(n : Int ) -> Void {//66ms

        for a in 1...n {    //1..<n
            
            for b in 1...n {
                
                for c in 1...n {
                    
                    if (a+b>c) && (a+c>b) && (b+c>a) {
                        print("\(a)","\(b)","\(c)")
                        
//                        let string = String.init(format: "%d%d%d", a,b,c)
//                        print(string)
//                        
                        
                        
//                        let date = NSDate()
//                        let timeFormatter = DateFormatter()
//                        timeFormatter.dateFormat = "yyy-MM-dd 'at' HH:mm:ss:SSS"
//                        let strNowTime = timeFormatter.string(from: date as Date) as String
//                        
//                        print(strNowTime)
                    }
                    
                }
                
            }
       
        }
 
    }
    
    
    //代理方法
    func changeTheValue(str: String) {

        print("点击了代理\(str)")
        
        
    }
    
    func segmentDidchange(_ segmented:UISegmentedControl){
        //获得选项的索引
        print(segmented.selectedSegmentIndex)
        //获得选择的文字
        print(segmented.titleForSegment(at: segmented.selectedSegmentIndex) as Any)
       
        if segmented.selectedSegmentIndex == 2 {
            switch_dzk.isOn = false
        }else{
            switch_dzk.isOn = true
        }
    }
    //btn
    func buttonAction(btn: UIButton) -> Void {
        
        if btn.tag==100 {
            
            let v2 = SecondViewController()
            v2.type_dzk = "dzk"
            
            self.present(v2, animated: true) {
                
            }
        }else if btn.tag == 102 {
            
            let v4 = FourthViewController()
            self.navigationController?.pushViewController(v4, animated: true)
        }else if btn.tag == 103{
            let v6 = SixViewController()
            self.present(v6, animated: true, completion: nil)
        }
        
    }
    
    //delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    //switch
    func switchDidChange(_ :UISwitch) -> Void {
        print("11")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        
        //获取点击的次数
        for touch : UITouch in touches {
            if  touch.tapCount == 2 {
               self.view.backgroundColor = UIColor.red
            }else if touch.tapCount == 1{
                self.view.backgroundColor = UIColor.white
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

