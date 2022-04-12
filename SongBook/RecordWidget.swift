//
//  RecordWidget.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/12/22.
//

import Foundation
import SwiftUI
struct RecordWidget: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("BackColor"),Color("BackColor")],startPoint: .top, endPoint: .bottom)
            HStack {
                VStack() {
                    Text("Record Widget")
                        .font(.title)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            .padding(.all)
        }
    }
}
