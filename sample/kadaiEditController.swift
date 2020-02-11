//
//  kadaiEditController.swift
//  sample
//
//  Created by ieuser on 2020/02/11.
//  Copyright © 2020 ieuser. All rights reserved.
//

import UIKit

class kadaiEditController: UIViewController {
    @IBOutlet weak var kadaiName: UITextView!
    
    @IBOutlet weak var kadaiDetail: UITextView!
    @IBOutlet weak var kadaiDeadLine: UITextField!
    var alertController: UIAlertController!
    var datePicker: UIDatePicker = UIDatePicker()
    
    @IBAction func kadaiSaveButton(_ sender: Any) {
        //アラートの表示
        if(kadaiName.text! == "" || kadaiDetail.text! == "" || kadaiDeadLine.text! == ""){
            alertNil(title: "未入力の箇所があります。", message:  "")
        }
        
        if(KadaiList[0][cellNumber] != kadaiName.text! || KadaiList[1][cellNumber] != kadaiDetail.text! || KadaiList[2][cellNumber] != kadaiDeadLine.text!) {
            alertSave(title: "変更内容が保存されました。", message: "")
        }
        
        if(kadaiName.text! != "" && kadaiDetail.text! != "" && kadaiDeadLine.text! != ""){
                    KadaiList[0][cellNumber] = kadaiName.text!
                    KadaiList[1][cellNumber] = kadaiDetail.text!
                    KadaiList[2][cellNumber] = kadaiDeadLine.text!
                    
                    //kadaiName.text = ""
                    //kadaiDetail.text = ""
                    //kadaiDeadLine.text = ""
                }
                
        UserDefaults.standard.set(KadaiList, forKey: "kadaiList")
    }
    
    //アラート(課題の保存をする場合)
    func alertSave(title:String, message:String){
        
        let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)
       
        // OKボタンの実装
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            
            // OKを押したら0.5秒後にメイン画面へ遷移する
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
             
                // 0.5秒後に実行したい処理
                self.performSegue(withIdentifier: "returnMainSegue", sender: nil)
            }
        })
        alert.addAction(defaultAction)
         
            present(alert, animated: true, completion: nil)
    }
    
    //アラート(未入力の項目がある場合)
    func alertNil(title:String, message:String) {
        let alert = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        
     
        alert.addAction(UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "kadaiList") != nil {
                  KadaiList = UserDefaults.standard.object(forKey: "kadaiList") as! [[String]]
        }
        
        kadaiName.text = KadaiList[0][cellNumber]
        kadaiDetail.text = KadaiList[1][cellNumber]
        kadaiDeadLine.text = KadaiList[2][cellNumber]
        
        kadaiName.layer.borderColor = UIColor.black.cgColor
        kadaiDetail.layer.borderColor = UIColor.black.cgColor
        kadaiDeadLine.layer.borderColor = UIColor.black.cgColor

        kadaiName.layer.borderWidth = 1.0
        kadaiDetail.layer.borderWidth = 1.0
        kadaiDeadLine.layer.borderWidth = 1.0
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        datePicker.minimumDate = NSDate() as Date
        datePicker.maximumDate = NSDate(timeIntervalSinceNow: 12*30*24*60*60) as Date
        kadaiDeadLine.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        kadaiDeadLine.inputView = datePicker
        kadaiDeadLine.inputAccessoryView = toolbar
        
    }
    
    @objc func done() {
        kadaiDeadLine.endEditing(true)

        // 日付のフォーマット
        let formatter = DateFormatter()
       
        
        formatter.dateFormat = "yyyy年MM月dd日"

        //(from: datePicker.date))を指定してあげることで
        //datePickerで指定した日付が表示される
        kadaiDeadLine.text = "\(formatter.string(from: datePicker.date))"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
