//
//  kadaiDetailController.swift
//  sample
//
//  Created by ieuser on 2019/12/13.
//  Copyright © 2019 ieuser. All rights reserved.
//

import UIKit



class kadaiDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var sectionTitle = ["課題名", "課題内容", "締切日"]
    @IBOutlet weak var KadaitableView: UITableView!
    
    //sectionごとのcellの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //cellの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "kadaiCell", for: indexPath)
            cell.textLabel?.numberOfLines=0
            cell.textLabel?.text = KadaiList[indexPath.section][cellNumber]
            return cell
        }
    
    
    //section数
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    //sectionのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "kadaiList") != nil {
                  KadaiList = UserDefaults.standard.object(forKey: "kadaiList") as! [[String]]
        }
        
        //余分なセルの削除
        KadaitableView.tableFooterView = UIView()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
