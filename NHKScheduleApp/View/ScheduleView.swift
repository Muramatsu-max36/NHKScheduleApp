//
//  ScheduleView.swift
//  NHKScheduleApp
//
//  Created by cmStudent on 2022/05/08.
//

import SwiftUI

struct ScheduleView: View {
    
    @ObservedObject var viewModel = ScheduleViewModel()
    
    @State private var magnifyBy = 1.0
    @State private var lastMagnificationValue = 1.0
    
    // 詳細設定を開くフラグ
    @State private var isShowingSettingView = false
    
    var body: some View {
        if viewModel.isShowingView {
            NavigationView {
                ScrollView([.vertical, .horizontal], showsIndicators: false) {
                    ZStack(alignment: .topLeading) {
                        backgroundTable
                        
                        scheduleView
                    }
                }
                .navigationBarTitle("番組表", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    isShowingSettingView = true
                }) {
                    Text("詳細設定")
                }.sheet(isPresented: $isShowingSettingView , onDismiss: {
                    print("==========================================================================================================================================================================================================================================================================================================================================================================================")
                    viewModel.reSetting()
                }) {
                    SettingView(viewModel: viewModel)
                })
            }
        } else {
            ActivityIndicator()
        }
        
    }
    
    var scheduleView : some View {
        HStack(spacing: 0) {
            Spacer()
                .frame(width: viewModel.timeWidth)
            ForEach(0..<viewModel.programArray.count, id: \.self) { num in
                ChannelView(viewModel: viewModel, channel: viewModel.programArray[num], minuteArray: viewModel.timeAdjustmentArray[num], startTimeArray: viewModel.startTimeArray[num])
                Divider()
            }
        }
        .onAppear{
            print("番組表が表示されました")
        }
    }
    
    var backgroundTable: some View {
        VStack(spacing: 0) {
            ForEach(-1..<viewModel.timeScheduleArray.count, id: \.self) { hour in
                HStack(spacing: 0) {
                    if hour != -1 {
                        VStack(spacing: 0) {
                            // 時間表示
                            Text(viewModel.timeScheduleArray[hour])
                                .frame(width: viewModel.timeWidth, height: viewModel.timeHeight)
                                .background(Color("timeColor"))
                                .foregroundColor(Color.white)
                            Divider()
                                .frame(width: viewModel.timeWidth)
                        }
                        
                        Spacer()
                    } else if hour == -1 {
                        Spacer()
                            .frame(width: viewModel.timeWidth, height: viewModel.channelHeight)
                        ForEach(-1..<viewModel.channelNameArray.count, id: \.self) { num in
                            if num != -1 {
                                // チャンネル名
                                Text("\(viewModel.channelNameArray[num])")
                                    .font(.system(size: 11))
                                    .frame(width: viewModel.channelWidth, height: viewModel.channelHeight)
                                    .background(Color("serviceColor"))
                                    .foregroundColor(Color.white)
                                Divider()
                                    .frame(height: viewModel.channelHeight)
                            }
                        }
                    }
                }
            }
        }
        .scaleEffect(magnifyBy)
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}


