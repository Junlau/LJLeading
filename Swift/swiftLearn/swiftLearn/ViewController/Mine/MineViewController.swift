//
//  MinaViewController.swift
//  swiftLearn
//
//  Created by 19054909 on 2021/6/17.
//

import UIKit

class MineViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    //懒加载
    lazy var tableView : UITableView = {
        var temp = UITableView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        temp.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellId")
        temp.delegate = self
        temp.dataSource = self
        return temp
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        self.view.addSubview(self.tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "UITableViewCellId", for: indexPath)
        cell.textLabel?.text = "WeiBo Home"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(WeiBoHomeViewController(), animated:true)
    }

}
