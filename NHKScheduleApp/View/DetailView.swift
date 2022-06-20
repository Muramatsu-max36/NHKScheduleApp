//
//  DetailView.swift
//  NHKScheduleApp
//
//  Created by cmStudent on 2022/06/20.
//

import SwiftUI

struct DetailView: View {
    
    var channel : [ScheduleItem]
    
    var index : Int
    
    var viewModel : ScheduleViewModel
    
    @State var isShowContent = false
    
    @State var btnTxt = "詳細表示"
    
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    HStack {
                        Text(channel[index].title)
                            .font(.system(size: 35, weight: .black, design: .default))
                        Spacer()
                    }
                    
                    HStack {
                        Text(channel[index].channel)
                            .font(.system(size: 10, weight: .black, design: .default))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    
                    HStack {
                        if viewModel.changeTime(timeStr: channel[index].start_time).prefix(10) == viewModel.changeTime(timeStr: channel[index].end_time).prefix(10) {
                            Text("放送時間：" + viewModel.changeTime(timeStr: channel[index].start_time) + "　〜")
                                .font(.system(size: 15))
                            Text(viewModel.changeTime(timeStr: channel[index].end_time).suffix(6))
                                .font(.system(size: 15))
                        } else {
                            Text("放送時間：" + viewModel.changeTime(timeStr: channel[index].start_time) + "　〜")
                                .font(.system(size: 15))
                            Text(viewModel.changeTime(timeStr: channel[index].end_time))
                                .font(.system(size: 15))
                        }
                        Spacer()
                    }
                    
                    HStack {
                        ForEach( 0..<channel[index].genres.count , id: \.self) { i in
                            Text(channel[index].genres[i])
                        }
                        Spacer()
                    }
                }
                Spacer()
                    .frame(height: 20)
                
                if channel[index].subtitle != "　" {
                    Text(channel[index].subtitle)
                }
                
                Spacer()
                    .frame(height: 10)
                
                if channel[index].content != "　" {
                    Button(action: {
                        isShowContent.toggle()
                        if isShowContent == true {
                            btnTxt = "閉じる"
                        } else {
                            btnTxt = "詳細表示"
                        }
                    }) {
                        Text(btnTxt)
                    }
                    
                    if isShowContent {
                        Spacer()
                            .frame(height: 10)
                        Text(channel[index].content)
                    }
                }
                
                Spacer()
                    .frame(height: 10)
                
                if channel[index].act != "" {
                    HStack {
                        Text("出演者")
                            .font(.system(size: 20, weight: .black, design: .default))
                        Spacer()
                    }
                    HStack {
                        Text(channel[index].act)
                            .foregroundColor(.purple)
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(channel: [], index: 0, viewModel: ScheduleViewModel())
    }
}
