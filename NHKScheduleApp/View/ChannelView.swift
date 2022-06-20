//
//  ChannelView.swift
//  NHKScheduleApp
//
//  Created by cmStudent on 2022/05/16.
//

import SwiftUI

struct ChannelView: View {
    
    @ObservedObject var viewModel : ScheduleViewModel
    
    var channel : [ScheduleItem]
    
    var minuteArray : [Int]
    
    var startTimeArray : [String]
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0.0) {
            Spacer()
                .frame(height: viewModel.channelHeight)
            
            if !viewModel.timeScheduleArray.isEmpty {
                Rectangle()
                    .frame(width: viewModel.channelWidth, height: viewModel.adjustSpace(channel: channel, timeArray: viewModel.timeScheduleArray))
                    .foregroundColor(.gray)
            }
            
            
            ForEach(0..<channel.count, id: \.self) { num in
                NavigationLink(destination: DetailView(channel: channel, index: num, viewModel: viewModel)) {
                    VStack(spacing: 0.0) {
                        ProgramView(title: channel[num].title, subTitle: channel[num].subtitle, time: startTimeArray[num])
                            .padding(1)
                        if num == channel.count - 1 {
                            Divider()
                        }
                    }
                    .frame(height: CGFloat(minuteArray[num]) * 3)
                }
            }
            Spacer()
        }
        .frame(width: viewModel.channelWidth)
    }
}

struct ChannelView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelView(viewModel: ScheduleViewModel(), channel: [], minuteArray: [], startTimeArray: [])
    }
}
