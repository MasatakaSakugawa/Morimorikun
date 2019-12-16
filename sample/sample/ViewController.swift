//
//  ViewController.swift
//  sample
//
//  Created by ieuser on 2019/11/27.
//  Copyright © 2019 ieuser. All rights reserved.
//

import UIKit
var cellNumber:Int = 0 //セルの行番号

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    //表示するセル数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KadaiList[0].count
    }
    
    //表示するセルの中身を決める
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let TodoCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        TodoCell.textLabel!.text = KadaiList[0][indexPath.row]
        TodoCell.textLabel?.numberOfLines=0
        return TodoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellNumber = indexPath.row
    }
    
    //cellの削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            KadaiList[0].remove(at: indexPath.row)
            KadaiList[1].remove(at: indexPath.row)
            KadaiList[2].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            UserDefaults.standard.set(KadaiList, forKey: "kadaiList")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.object(forKey: "kadaiList") != nil {
            KadaiList = UserDefaults.standard.object(forKey: "kadaiList") as! [[String]]
        }
        
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.title = "title"
        navigationItem.rightBarButtonItem = editButtonItem
        
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

