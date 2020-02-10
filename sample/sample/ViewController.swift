//
//  ViewController.swift
//  sample
//
//  Created by ieuser on 2019/11/27.
//  Copyright © 2019 ieuser. All rights reserved.
//
import UserNotifications
import UIKit
var cellNumber:Int = 0 //セルの行番号


class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    //表示するセル数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let trigger: UNNotificationTrigger
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
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
        
        if #available(iOS 10.0, *) {
            // iOS 10
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                if error != nil {
                    return
                }

                if granted {
                    print("通知許可")
                    let center = UNUserNotificationCenter.current()
                    center.delegate = self as? UNUserNotificationCenterDelegate

                } else {
                }
            })

        } else {
            // iOS 9以下
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        if UserDefaults.standard.object(forKey: "kadaiList") != nil {
            KadaiList = UserDefaults.standard.object(forKey: "kadaiList") as! [[String]]
        }
        
        var notificationTime = DateComponents()
        let trigger: UNNotificationTrigger
        
        
        //notificationTime.hour = 5 //ここいじったら通知する時間変わるよじここは時刻。デモ用にコレいじれば爆速で通知くる
        //notificationTime.minute = 51//はずだ
        //notificationTime.second = 50
        
        trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = "締め切りの近い課題があります"
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}

