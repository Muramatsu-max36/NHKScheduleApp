//
//  JsonProcess.swift
//  NHKScheduleApp
//
//  Created by cmStudent on 2022/05/12.
//

import Foundation

class JsonProcess {
    
    // 番組情報全てを入れる配列
    var programArray : [[ScheduleItem]] = []

    func kakunin() -> Bool {
        if programArray.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    // itemを配列にセットする
    func setItem(item: [Program]) -> [ScheduleItem] {
        var array : [ScheduleItem] = []
        for i in 0..<item.count {
            array.append(ScheduleItem(start_time: item[i].start_time, end_time: item[i].end_time, title: item[i].title, subtitle: item[i].subtitle, content: item[i].content, act: item[i].act, genres: item[i].genres, channel: item[i].service.name))
        }
        return array
    }
    
    // 日付を配列に入れること
    func getDate() -> [String] {
        //　Pickerの日付を入れる配列
        var dateArray : [String] = []
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        // 日付を配列に入れる
        for i in 0..<8 {
            let plusDate = Calendar.current.date(byAdding: .day, value: i, to: date)!
            df.dateFormat = "yyyy-MM-dd"
            dateArray.append(String(df.string(from: plusDate)))
        }
        return dateArray
    }
    
    // 時間ごとに表示する大きさを変えるため、分単位の番組時間の配列を作成
    func timeAdjustment(programArray: [[ScheduleItem]]) -> [[Int]] {
        // 何分放送するかの配列
        var timeAdjustmentArray : [[Int]] = []
        for i in 0..<programArray.count {
            var timePartsArray : [Int] = []
            for n in 0..<programArray[i].count {
                let start = programArray[i][n].start_time
                let end = programArray[i][n].end_time
                let startDate = dateFromString(time: start)
                let endDate = dateFromString(time: end)
                
                let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startDate, to: endDate)
                let day = Int(dateComponents.day!)
                let hour = Int(dateComponents.hour!)
                let minute = Int(dateComponents.minute!)
                let result = (day * 24 * 60) + (hour * 60) + minute
                
                timePartsArray.append(result)
            }
            timeAdjustmentArray.append(timePartsArray)
        }
        print("-------------------------------------------------------")
        print(timeAdjustmentArray.count)
        print("-------------------------------------------------------")
        print(timeAdjustmentArray)
        return timeAdjustmentArray
    }
    
    // StringからDateに変換
    private func dateFromString(time: String) -> Date {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: time)!
    }
    
    // チャンネル名を配列を作る
    func getChannelName(programArray: [[ScheduleItem]]) -> [String] {
        var channelArray : [String] = []
        for i in 0 ..< programArray.count {
            for n in 0 ..< 1 {
                channelArray.append(programArray[i][n].channel)
            }
        }
        return channelArray
    }
    
    // 何分から始まるかの配列を作る
    func getStartTime(programArray: [[ScheduleItem]]) -> [[String]] {
        var minutesArray : [[String]] = []
        for i in 0..<programArray.count {
            var numArray : [String] = []
            for n in 0..<programArray[i].count {
                let timeStr = programArray[i][n].start_time
                let time = subStr(text: timeStr, startIndex: 14, endIndex: 15)
                numArray.append(time)
            }
            minutesArray.append(numArray)
        }
        return minutesArray
    }
    
    func getStoE(programArray: [[ScheduleItem]]) -> [String] {
        var start = 24
        var end = 0
        var timeSchedule : [String] = []
        for i in 0..<programArray.count {
            for n in 0..<programArray[i].count {
                if n == 0 {
                    let numS = Int(subStr(text: programArray[i][n].start_time, startIndex: 11, endIndex: 12))
                    if (start > numS!) {
                        start = numS!
                    }
                } else if n == (programArray[i].count - 1) {
                    let numE = Int(subStr(text: programArray[i][n].end_time, startIndex: 11, endIndex: 12))
                    if (end < numE!) {
                        end = numE!
                    }
                }
            }
        }
        for u in start..<24 {
            timeSchedule.append(String(u))
        }
        for m in 0...end {
            timeSchedule.append(String(m))
        }
        print(timeSchedule)
        return timeSchedule
    }
    
    func subStr(text: String, startIndex: Int, endIndex: Int) -> String {
        let start = text.index(text.startIndex, offsetBy: startIndex)
        let end = text.index(text.endIndex, offsetBy: endIndex + 1 - text.count)
        return String(text[start..<end])
    }
}
