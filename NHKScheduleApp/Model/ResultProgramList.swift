//
//  ResultProgramList.swift
//  NHKScheduleApp
//
//  Created by cmStudent on 2022/05/08.
//

import Foundation

struct ResultProgramList : Codable {
    let list : List
}

// チャンネルの種類
struct List : Codable {
    let g1, g2 : [Program]?
    let e1, e2, e3, e4 : [Program]?
    let s1, s2, s3, s4 : [Program]?
    let r1, r2, r3 : [Program]?
    let n1, n2, n3 : [Program]?
}

struct Program : Codable {
    let start_time : String // 始まる時間
    let end_time : String // 終わる時間
    let service : Service // チャンネル名
    let title : String // タイトル
    let subtitle : String // サブタイトル
    let content : String // 詳細説明
    let act : String // 出演者
    let genres : [String] // ジャンル
}

struct Service : Codable {
    let name : String // チャンネル名
}
