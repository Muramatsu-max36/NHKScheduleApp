//
//  ProgramView.swift
//  NHKScheduleApp
//
//  Created by cmStudent on 2022/05/09.
//

import SwiftUI

struct ProgramView: View {
    
    var title : String
    var subTitle : String
    var time : String
    
    init(title: String, subTitle: String, time: String) {
        self.title = title
        self.subTitle = subTitle
        self.time = time
    }
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0.0) {
                Divider()
                HStack(alignment: .top, spacing: 0.0) {
                    Text(time)
                        .font(.system(size: 7, weight: .black, design: .default))
                        .foregroundColor(.white)
                        .background(Color.gray)
                        
                    Text(title)
                        .font(.system(size: 7, weight: .black, design: .default))
                }
                
                if (geometry.size.height > 10) {
                    Text(subTitle)
                        .font(.system(size: 5, weight: .black, design: .default))
                        .foregroundColor(Color.gray)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
        }
    }
}

