//
//  ThirdViewController.swift
//  swift_dzk
//
//  Created by dzk on 2017/7/6.
//  Copyright © 2017年 dzk. All rights reserved.
//

import UIKit



class ThirdViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    //定义数组
    var dataArray:[CellModel]?
    
    //定义tableview
    var table:UITableView?
    
    
    var currentIndex = IndexPath()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white;
        
        
        self.table = UITableView.init(frame: self.view.frame, style: .plain)
        
        
        let model1 = CellModel.init(dic: ["title":"dzk1","cid":"1"])
        let model2 = CellModel.init(dic: ["title":"dzk2","cid":"2"])
        let model3 = CellModel.init(dic: ["title":"dzk3","cid":"3"])
        let model4 = CellModel.init(dic: ["title":"dzk3","cid":"4"])
        let model5 = CellModel.init(dic: ["title":"dzk3","cid":"5"])
        let model6 = CellModel.init(dic: ["title":"dzk3","cid":"6"])
        
        dataArray = [model1,model2,model3,model4,model5,model6];
        
        self.table!.delegate = self
        self.table!.dataSource = self
        self.table?.contentInset = UIEdgeInsetsMake(60, 0, 0, 0)
        
        //创建重用的单元格
//        self.table!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.table!.register(TestCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.table!)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "edit", style: .done, target: self, action: #selector(edit))
    
        var header = MJRefreshNormalHeader();
        //修改文字
        header.setTitle("下拉下拉下拉", for: .idle)
        header.setTitle("松开松开松开", for: .pulling)
        header.setTitle("刷新刷新刷新", for: .refreshing)
        
        //修改字体
        header.stateLabel.font = UIFont.systemFont(ofSize: 15)
        header.lastUpdatedTimeLabel.font = UIFont.systemFont(ofSize: 13)
        
        //修改文字颜色
        header.stateLabel.textColor = UIColor.red
        header.lastUpdatedTimeLabel.textColor = UIColor.blue
    
        header.lastUpdatedTimeLabel.isHidden = true
        
        header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        self.table?.mj_header = header
//        self.table?.mj_header.beginRefreshing()
        
        self.table?.mj_footer = MJRefreshBackNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
    
        
        
//        print(self.currentIndex.isEmpty)
        
//        let arr = NSMutableArray.init(array: self.dataArray!)
//        
//        arr.removeObject(at: 1)
//        
//        print(arr)
        
//        let dic:NSDictionary = NSDictionary.init(object: "0", forKey: "1" as NSCopying)
//        let dic:NSDictionary = [0:["key1":"value1"],1:["key2":"value2"]]
//        print(dic.allValues)
        
//        for (_,value) in dic {
//            for (_,value1) in value as! NSDictionary {
//                print(value1)
//            }
//        }
        
    
//        let arr = ["1","2","3","4","5","6"]
        
//        for index in stride(from: 0, to: arr.count, by: 1) {
//            print(index)
//        }
        
//        for (index,value) in arr.enumerated() {
//            print("\(index)"+"\(value)")
//        }
        
        
        
    }
    
    
    func loadNewData() -> () {
        print("下拉刷新");
        
        self.table?.mj_header.endRefreshing()
    }
    func loadMoreData() -> () {
        print("上拉加载")
        
        self.table?.mj_footer.endRefreshing()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        ;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray!.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.currentIndex == indexPath {
            return 80
        }
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cid = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cid, for: indexPath) as! TestCell
        
        if !(self.dataArray?.isEmpty)!{
            
            let model = self.dataArray![indexPath.row]
            
            cell.setCellModel(model: model)
        }
//        cell.imageView?.image = UIImage.init(named: "1.jpg")
        
//        cell.textLabel?.text = self.dataArray![indexPath.row]
//        cell.imageView?.image = UIImage.init(named: "1.jpg")
        
        
        return cell
    }
    //去除编辑模式下的头部缩进   会与左滑删除冲突 ，需把编辑样式设为none
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt
        indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        if sourceIndexPath != destinationIndexPath{
//            //获取移动行对应的值
//            let itemValue:String = ctrlnames[sourceIndexPath.row]
//            //删除移动的值
//            ctrlnames.remove(at: sourceIndexPath.row)
//            //如果移动区域大于现有行数，直接在最后添加移动的值
//            if destinationIndexPath.row > ctrlnames.count{
//                ctrlnames.append(itemValue)
//            }else{
//                //没有超过最大行数，则在目标位置添加刚才删除的值
//                ctrlnames.insert(itemValue, at:destinationIndexPath.row)
//            }
//        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        self.table?.deselectRow(at: indexPath, animated: true)
        
        self.currentIndex = indexPath
        
        self.table?.reloadRows(at: [indexPath], with: .automatic)
        
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lab = UILabel()
        
        lab.backgroundColor = UIColor.red
        lab.text = "组头视图 \(section)"
        lab.textColor = UIColor.green
        
        if section==0 {
            lab.text = "跳转"
            
            lab.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
            lab.addGestureRecognizer(tap)
        }
        
        
        return lab
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    //滑动删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //先删除数据
        self.dataArray?.remove(at: indexPath.row)
        self.table?.deleteRows(at: [indexPath], with: .automatic)
    }

    //设置cell的显示动画
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath){
        //设置cell的显示动画为3D缩放
        //xy方向缩放的初始值为0.1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        //设置动画时间为0.25秒，xy方向缩放的最终值为1
        UIView.animate(withDuration: 0.5, animations: {
            cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    
    
    func edit() -> Void {
        self.table?.isEditing = !(self.table?.isEditing)!
    }
    
   
    //手势点击
    func tapAction() -> Void {
//        let v4 = FourthViewController()
        
//        self.present(v4, animated: true, completion: nil)
        
//        self.dismiss(animated: true, completion: nil)
        if (self.presentingViewController != nil) {
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
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
