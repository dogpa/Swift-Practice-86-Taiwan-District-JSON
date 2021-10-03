//
//  TaiwanDist JSON Type.swift
//  Swift Practice # 86 Taiwan District JSON
//
//  Created by Dogpa's MBAir M1 on 2021/10/3.
//

import Foundation

//台灣行政區JSON第二層
struct TaiwanDist: Decodable {
    let name: String                //縣市名稱
    let districts: [DistrictInfo]   //縣市內的鄉鎮行政區
}

//台灣行政區JSON第三層
struct DistrictInfo: Decodable {
    let zip: String                 //鄉鎮行政區的郵遞區號
    let name: String                //鄉鎮行政區的名字
}


