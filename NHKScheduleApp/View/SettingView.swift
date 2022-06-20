//
//  SettingView.swift
//  NHKScheduleApp
//
//  Created by cmStudent on 2022/05/09.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject var viewModel : ScheduleViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("チャンネル選択")
                    .padding()
                    .font(.title)
                Spacer()
            }
            
            Picker(selection: $viewModel.serviceValue, label: Text("チャンネル選択")) {
                ForEach(0..<viewModel.serviceArray.count, id: \.self) { num in
                    Text(viewModel.serviceArray[num][0]).tag(num)
                }
            }
            
            HStack {
                Text("地域選択")
                    .padding()
                    .font(.title)
                Spacer()
            }
            
            Picker(selection: self.$viewModel.areaValue, label: Text("地域選択")) {
                ForEach(0..<viewModel.areaArray.count, id: \.self) { num in
                    Text(viewModel.areaArray[num][0]).tag(num)
                }
            }
            
            HStack {
                Text("日付選択")
                    .padding()
                    .font(.title)
                Spacer()
            }
            
            Picker(selection: $viewModel.dateValue, label: Text("日付選択")) {
                ForEach(0..<viewModel.dateArray.count, id: \.self) { num in
                    Text(viewModel.dateArray[num]).tag(num)
                }
            }
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(viewModel: ScheduleViewModel())
    }
}
