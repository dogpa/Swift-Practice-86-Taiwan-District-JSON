//
//  UseTextFieldViewController.swift
//  Swift Practice # 86 Taiwan District JSON
//
//  Created by Dogpa's MBAir M1 on 2021/10/3.
//

import UIKit

//使用UIPickerViewDelegate, UIPickerViewDataSource 通知pickerView資料找誰拿以及顯示內容為何
class UseTextFieldViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //任意地方收鍵盤
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UseTextFieldViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        }
        @objc func dismissKeyboard() {
        view.endEditing(true)
        }

    @IBOutlet weak var distNumTextField: UITextField!       //跳出pickerview的TextField
    
    @IBOutlet weak var showCityAndDistLabel: UILabel!       //顯示選擇的縣市及鄉鎮行政區
    
    @IBOutlet weak var distFullInfoTextField: UITextField!  //顯示已經選好的縣市及鄉鎮行政區後面可以接續打字
    
    var TaiwanDistDetailArray = [TaiwanDist]()              //外部參數空字串為自定義TaiwanDist類別
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()     //任意位置收鍵盤

        //自定義一個UIPickerView並將delegate與dataSource指派給UseTextFieldViewController
        let twPickerView = UIPickerView()
        twPickerView.delegate = self
        twPickerView.dataSource = self
        
        //distNumTextField插入一個UIPickerView
        distNumTextField.inputView = twPickerView
        
        //解析JSON成功後將資料存入TaiwanDistDetailArray
        if let data = NSDataAsset(name: "taiwan_districts.json")?.data {
                  let decoder = JSONDecoder()
                  do {
                      let searchResponse = try decoder.decode([TaiwanDist].self, from: data)
                      TaiwanDistDetailArray = searchResponse
                  } catch  {
                      print(error)
                  }
              }
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return TaiwanDistDetailArray.count
        }else{
            let selectCityInTDD = pickerView.selectedRow(inComponent: 0)
            return TaiwanDistDetailArray[selectCityInTDD].districts.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return TaiwanDistDetailArray[row].name
        }else{
            let selectCityNameInTDD = pickerView.selectedRow(inComponent: 0)
            return TaiwanDistDetailArray[selectCityNameInTDD].districts[row].name
        }
    }
    
    //選到pickerview後要執行的內容
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //重新讀取第二個區域並重新顯示資料
        pickerView.reloadComponent(1)
        
        //指派第一與第二個區域所選到的值指派給cityNum與distNum
        let cityNum = pickerView.selectedRow(inComponent: 0)
        let distNum = pickerView.selectedRow(inComponent: 1)
        
        //distNumTextField的字為選到的鄉鎮行政區的郵遞區號
        distNumTextField.text = TaiwanDistDetailArray[cityNum].districts[distNum].zip
        
        //showCityAndDistLabel顯示的字為選到的城市名稱與鄉鎮行政區名稱
        showCityAndDistLabel.text = "你選擇查詢的是\n\(TaiwanDistDetailArray[cityNum].name)\(TaiwanDistDetailArray[cityNum].districts[distNum].name)"
        
        //distFullInfoTextField內先顯示郵遞區號與城市以及鄉鎮行政區名字 接著可以繼續打字(後面的地址)
        distFullInfoTextField.text = "\(TaiwanDistDetailArray[cityNum].districts[distNum].zip)\(TaiwanDistDetailArray[cityNum].name)\(TaiwanDistDetailArray[cityNum].districts[distNum].name)"
    }

}
