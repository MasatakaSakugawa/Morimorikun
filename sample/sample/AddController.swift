

import UIKit
import UserNotifications

var KadaiList : [[String]] = [[],[],[],[]]

class AddController: UIViewController {
    var alertController: UIAlertController!
    @IBOutlet weak var kadaiNameTextView: UITextView!
    @IBOutlet weak var kadaiNaiyouTextView: UITextView!
    @IBOutlet weak var kadaiShimekiriTextField: UITextField!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    
    
    @IBAction func TodoAddButton(_ sender: Any) {
        
        //アラートの表示
        if(kadaiNameTextView.text! == "" || kadaiNaiyouTextView.text! == "" || kadaiShimekiriTextField.text! == ""){
            alert(title: "未入力の箇所があります。", message:  "")
        }
        
        
        if(kadaiNameTextView.text! != "" && kadaiNaiyouTextView.text! != "" && kadaiShimekiriTextField.text! != ""){
            
            KadaiList[0].append(kadaiNameTextView.text!.trimmingCharacters(in: .newlines))
            KadaiList[1].append(kadaiNaiyouTextView.text!)
            KadaiList[2].append(kadaiShimekiriTextField.text!)
            kadaiNameTextView.text = ""
            kadaiNaiyouTextView.text = ""
            kadaiShimekiriTextField.text = ""
            print(kadaiShimekiriTextField.text!)
        }
        
        UserDefaults.standard.set(KadaiList, forKey: "kadaiList")
    }
    
    //アラートの設定
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil))
        present(alertController, animated: true)
    }
    
    
    func getDeadLine() -> Int {
        let now = Date()
        let date = Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: now), month: Calendar.current.component(.month, from: now), day: Calendar.current.component(.day, from: now)))!
        
        let DeadLine: Int = Int(date.timeIntervalSinceNow / (3600*24))
        return DeadLine
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TextViewの設定
        kadaiNameTextView.layer.borderColor = UIColor.black.cgColor
        kadaiNaiyouTextView.layer.borderColor = UIColor.black.cgColor
        kadaiShimekiriTextField.layer.borderColor = UIColor.black.cgColor
        
        kadaiNameTextView.layer.borderWidth = 1.0
        kadaiNaiyouTextView.layer.borderWidth = 1.0
        kadaiShimekiriTextField.layer.borderWidth = 1.0
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        datePicker.minimumDate = NSDate() as Date
        datePicker.maximumDate = NSDate(timeIntervalSinceNow: 12*30*24*60*60) as Date
        kadaiShimekiriTextField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        
        kadaiShimekiriTextField.inputView = datePicker
        kadaiShimekiriTextField.inputAccessoryView = toolbar
        
    }
    
    @objc func done() {
        kadaiShimekiriTextField.endEditing(true)
        
        // 日付のフォーマット
        let formatter = DateFormatter()
        
        
        formatter.dateFormat = "yyyy年MM月dd日"
        
        //(from: datePicker.date))を指定してあげることで
        //datePickerで指定した日付が表示される
        kadaiShimekiriTextField.text = "\(formatter.string(from: datePicker.date))"
        let text = kadaiShimekiriTextField.text//こいつString
        
        
        let list = text?.components(separatedBy: CharacterSet(charactersIn: "年月日"))
        
        
        var notificationTime = DateComponents()
        let trigger: UNNotificationTrigger
        
        
        notificationTime.day = Int(list![2])
        notificationTime.month = Int(list![1])
        
        trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = "締め切りの近い課題があります"
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
