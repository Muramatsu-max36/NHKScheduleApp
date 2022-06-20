//
//  ScheduleViewModel.swift
//  NHKScheduleApp
//
//  Created by cmStudent on 2022/05/08.
//

import Foundation
import SwiftUI

class ScheduleViewModel: ObservableObject {
    
    
    private let url = "https://api.nhk.or.jp/v2/pg/"
    private let apikey = "tJsmcQYXxI5PHAfy2JofK2WAHHvokgOG"
    // 地域の変更の値（pickerとurlで使う）
    @Published var areaValue = 18
    // 地域の変更の値（pickerとurlで使う）
    @Published var serviceValue = 0
    // 日付の変更の値（pickerとurlで使う）
    @Published var dateValue = 0
    // 配列（番組表表示する時に使用）
    @Published var programArray : [[ScheduleItem]] = []
    // くるくる表示のbool
    @Published var isShowingView = false
    // 番組の大きさの比率（単位：分）
    @Published var timeAdjustmentArray : [[Int]] = []
    
    var jsonProcess = JsonProcess()
    // 配列（地域の名前とurlで使う番号）
    let areaArray : [[String]] = [["札幌", "010"], ["函館", "011"], ["旭川", "012"], ["帯広", "013"], ["釧路", "014"], ["北見", "015"], ["室蘭", "016"], ["青森", "020"], ["盛岡", "030"], ["仙台", "040"], ["秋田", "050"], ["山形", "060"], ["福島", "070"], ["水戸", "080"], ["宇都宮", "090"], ["前橋", "100"], ["さいたま", "110"], ["千葉", "120"], ["東京", "130"], ["横浜", "140"], ["新潟", "150"], ["富山", "160"], ["金沢", "170"], ["福井", "180"], ["甲府", "190"], ["長野", "200"], ["岐阜", "210"], ["静岡", "220"], ["名古屋", "230"], ["津", "240"], ["大津", "250"], ["京都", "260"], ["大阪", "270"], ["神戸", "280"], ["奈良", "290"], ["和歌山", "300"], ["鳥取", "310"], ["松江", "320"], ["岡山", "330"], ["広島", "340"], ["山口", "350"], ["徳島", "360"], ["高松", "370"], ["松山", "380"], ["高知", "390"], ["福岡", "400"], ["北九州", "401"], ["佐賀", "410"], ["長崎", "420"], ["熊本", "430"], ["大分", "440"], ["宮崎", "450"], ["鹿児島", "460"], ["沖縄", "470"]]
    // 配列（チャンネルの名前とurlで使う文字列）
    let serviceArray : [[String]] = [["ＮＨＫ総合１", "g1"], ["ＮＨＫ総合２", "g2"], ["ＮＨＫＥテレ１", "e1"], ["ＮＨＫＥテレ２", "e2"], ["ＮＨＫＥテレ３", "e3"], ["ＮＨＫワンセグ２", "e4"], ["ＮＨＫＢＳ１０１ｃｈ", "s1"] /* ＮＨＫＢＳ１ */, ["ＮＨＫＢＳ１０２ｃｈ", "s2"] /* ＮＨＫＢＳ１(１０２ｃｈ) */ , ["ＮＨＫＢＳプレミアム１０３ｃｈ", "s3"] /* ＮＨＫＢＳプレミアム */ , ["ＮＨＫＢＳプレミアム１０４ｃｈ", "s4"] /* ＮＨＫＢＳプレミアム(１０４ｃｈ) */ , ["ＮＨＫラジオ第1", "r1"], ["ＮＨＫラジオ第2", "r2"], ["ＮＨＫＦＭ", "r3"], ["ＮＨＫネットラジオ第1", "n1"], ["ＮＨＫネットラジオ第2", "n2"], ["ＮＨＫネットラジオＦＭ", "n3"], ["テレビ", "tv"], ["ラジオ", "radio"], ["ネットラジオ", "netradio"]]
    // 配列（日付）
    @Published var dateArray : [String] = []
    
    let channelWidth : CGFloat = CGFloat(120)
    let channelHeight : CGFloat = CGFloat(30)
    let timeWidth : CGFloat = CGFloat(30)
    let timeHeight : CGFloat = CGFloat(180)

    // チャンネル名
    @Published var channelNameArray : [String] = []
    
    // 始まる時間（何分か）
    @Published var startTimeArray : [[String]] = []
    
    // 時間の表の配列
    @Published var timeScheduleArray : [String] = []
    
    // 番組ごとの、その日の始まる時間
    @Published var startTimeChannelArray : [String] = []
    
    init() {
        isShowingView = false
        channelNameArray = []
        dateArray = []
        programArray = []
        timeAdjustmentArray = []
        startTimeArray = []
        timeScheduleArray = []
        print("setting")
        setting()
    }
    
    func reSetting() {
        isShowingView = false
        channelNameArray = []
        dateArray = []
        programArray = []
        timeAdjustmentArray = []
        startTimeArray = []
        timeScheduleArray = []
        print("setting")
        setting()
    }
    
    func setting() {
        // Pickerの日付に使う配列に入れる
        dateArray = jsonProcess.getDate()
//        // jsonをパースしてから、配列に入れる
//        programArray = jsonProcess.json(url: "\(url)\(requestKinds.list)/\(areaArray[areaValue][1])/\(serviceArray[serviceValue][1])/\(dateArray[dateValue]).json?key=\(apikey)")
        
        guard let req_url = URL(string: "\(url)\(requestKinds.list)/\(areaArray[areaValue][1])/\(serviceArray[serviceValue][1])/\(dateArray[dateValue]).json?key=\(apikey)") else {
            print("URLエラー↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓")
            print(url)
            return
        }
        print(req_url)

        let req = URLRequest(url: req_url)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: req, completionHandler: { [self]
            (data, response, error) in
            session.finishTasksAndInvalidate()

            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultProgramList.self, from: data!)

//                print(json)

                
                DispatchQueue.main.async {
                    // データがあったら配列に入れるという処理を連続している
                    if let g1 = json.list.g1 {
                        self.programArray.append(self.jsonProcess.setItem(item: g1))
    //                    print(g1)
                    } else {
                        print("not found g1")
                    }
                    if let g2 = json.list.g2 {
                        self.programArray.append(self.jsonProcess.setItem(item: g2))
                    } else {
                        print("not found g2")
                    }
                    if let e1 = json.list.e1 {
                        self.programArray.append(self.jsonProcess.setItem(item: e1))
                    } else {
                        print("not found e1")
                    }
                    if let e2 = json.list.e2 {
                        self.programArray.append(self.jsonProcess.setItem(item: e2))
                    } else {
                        print("not found e2")
                    }
                    if let e3 = json.list.e3 {
                        self.programArray.append(self.jsonProcess.setItem(item: e3))
                    } else {
                        print("not found e3")
                    }
                    if let e4 = json.list.e4 {
                        self.programArray.append(self.jsonProcess.setItem(item: e4))
                    } else {
                        print("not found e4")
                    }
                    if let s1 = json.list.s1 {
                        self.programArray.append(self.jsonProcess.setItem(item: s1))
                    } else {
                        print("not found s1")
                    }
                    if let s2 = json.list.s2 {
                        self.programArray.append(self.jsonProcess.setItem(item: s2))
                    } else {
                        print("not found s2")
                    }
                    if let s3 = json.list.s3 {
                        self.programArray.append(self.jsonProcess.setItem(item: s3))
                    } else {
                        print("not found s3")
                    }
                    if let s4 = json.list.s4 {
                        self.programArray.append(self.jsonProcess.setItem(item: s4))
                    } else {
                        print("not found s4")
                    }
                    if let r1 = json.list.r1 {
                        self.programArray.append(self.jsonProcess.setItem(item: r1))
                    } else {
                        print("not found r1")
                    }
                    if let r2 = json.list.r2 {
                        self.programArray.append(self.jsonProcess.setItem(item: r2))
                    } else {
                        print("not found r2")
                    }
                    if let r3 = json.list.r3 {
                        self.programArray.append(self.jsonProcess.setItem(item: r3))
                    } else {
                        print("not found r3")
                    }
                    if let n1 = json.list.n1 {
                        self.programArray.append(self.jsonProcess.setItem(item: n1))
                    } else {
                        print("not found n1")
                    }
                    if let n2 = json.list.n2 {
                        self.programArray.append(self.jsonProcess.setItem(item: n2))
                    } else {
                        print("not found n2")
                    }
                    if let n3 = json.list.n3 {
                        self.programArray.append(self.jsonProcess.setItem(item: n3))
                    } else {
                        print("not found n3")
                    }
                    
                    self.timeScheduleArray = self.jsonProcess.getStoE(programArray: self.programArray)

                    self.timeAdjustmentArray = self.jsonProcess.timeAdjustment(programArray: self.programArray)
                    
                    self.channelNameArray = self.jsonProcess.getChannelName(programArray: self.programArray)
                    
                    self.startTimeArray = self.jsonProcess.getStartTime(programArray: self.programArray)
                    
                    self.isShowingView = true
                    
                    print(self.programArray)
                }
                
            } catch {
                print("エラー")
                print(error)
            }
        })
        task.resume()
        
        
    }
    
    func changeTime(timeStr: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        let date = formatter.date(from: timeStr)!
        formatter.dateFormat = "yyyy年MM月dd日 HH時mm分"
        return formatter.string(from: date)
    }
    
    func subStr(text: String, startIndex: Int, endIndex: Int) -> String {
        let start = text.index(text.startIndex, offsetBy: startIndex)
        let end = text.index(text.endIndex, offsetBy: endIndex + 1 - text.count)
        return String(text[start..<end])
    }
    
    func adjustSpace(channel: [ScheduleItem], timeArray: [String]) -> CGFloat {
        // 表の始まる時間
        let startTime = Int(timeArray[0])! * 60
        // 番組が始まる時間（何時か）
        let programStartHour = Int(subStr(text: channel[0].start_time, startIndex: 11, endIndex: 12))! * 60
        // 番組が始まる時間（何分か）
        let programStartMinutes = Int(subStr(text: channel[0].start_time, startIndex: 14, endIndex: 15))!
        
        
        return CGFloat(Float(programStartHour + programStartMinutes - startTime) * 3)
    }
}

// リクエストの種類
enum requestKinds : String {
    case list
    case genre
    case info
    case now
}

