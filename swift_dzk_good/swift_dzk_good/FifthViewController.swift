//
//  FifthViewController.swift
//  swift_dzk_good
//
//  Created by dzk on 2017/7/11.
//  Copyright © 2017年 dzk. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    var countrySearchController = UISearchController()
    
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "搜索"
        
        
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self as? UISearchResultsUpdating
            controller.hidesNavigationBarDuringPresentation = true
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.sizeToFit()
            return controller
        })()
        
        //将搜索栏添加到页面上
        let searchBarFrame = CGRect(x: 0, y: 64+20, width: self.view.frame.width, height: 44)
        let searchBarContainer = UIView(frame: searchBarFrame)
        searchBarContainer.addSubview(countrySearchController.searchBar)
        self.view.addSubview(searchBarContainer)
        
        
        //创建表视图
        let tableViewFrame = CGRect(x: 0, y: 64+64, width: self.view.frame.width,
                                    height: self.view.frame.height - 64-64)
        self.tableView = UITableView(frame: tableViewFrame, style:.plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "MyCell")
        self.view.addSubview(self.tableView)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
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
