//
//  ViewController.swift
//  Swift Practice # 86 Taiwan District JSON
//
//  Created by Dogpa's MBAir M1 on 2021/10/3.
//

import UIKit

//使用UIPickerViewDelegate, UIPickerViewDataSource讓pickerview知道跟誰要資料及顯示內容
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //自定義一個外部名稱TaiwanDistDetail為自定義型別的TaiwanDist空字串
    var TaiwanDistDetail = [TaiwanDist]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //嘗試透過NSDataAsset解析JSON格式 解析後指派給data 如果有解析成功
        //透過JSONDecoder來解析出資料後指派給searchResponse
        //再將searchResponse指派給外部指派好的TaiwanDistDetail空字串讓後續使用
        if let data = NSDataAsset(name: "taiwan_districts.json")?.data {
                  let decoder = JSONDecoder()
                  do {
                      let searchResponse = try decoder.decode([TaiwanDist].self, from: data)
                        TaiwanDistDetail = searchResponse
                  } catch  {
                      print(error)
                  }
              }
        print(TaiwanDistDetail)//嘗試列印看看JSON狀態
    }
    
    //pickerView回傳的numberOfComponents數量回傳2個
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //每一個Components那各字要顯示的row數量
    //依照第一個Components的值來決定第二個Components顯示的row數
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return TaiwanDistDetail.count       //回傳TaiwanDistDetail內總數
        }else{
            //依照第一個inComponent來決定第二個Component的數量
            let selectCityInTDD = pickerView.selectedRow(inComponent: 0)
            return TaiwanDistDetail[selectCityInTDD].districts.count
        }
    }
    
    //顯示內容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //第一個區域顯示城市名稱
        if component == 0 {
            return TaiwanDistDetail[row].name
        }else{
            //第二個區域透過第一個區域的縣市名稱來跟著顯示該縣市的鄉鎮行政區名稱
            let selectCityNameInTDD = pickerView.selectedRow(inComponent: 0)
            return TaiwanDistDetail[selectCityNameInTDD].districts[row].name
        }
    }
    
    //有選到pickerView則重新讀取第二個區域的資料
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(1)
    }


}

