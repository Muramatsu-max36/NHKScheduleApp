//
//  ScheduleItem.swift
//  NHKScheduleApp
//
//  Created by cmStudent on 2022/05/10.
//

import Foundation

struct ScheduleItem {
    let start_time : String // 始まる時間
    let end_time : String // 終わる時間
    let title : String // タイトル
    let subtitle : String // サブタイトル
    let content : String // 詳細説明
    let act : String // 出演者
    let genres : [String] // ジャンル
    let channel : String // チャンネル名
}
