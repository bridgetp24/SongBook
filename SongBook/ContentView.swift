//
//  ContentView.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/7/22.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                TitleBar()
                HStack {
                    LyricView()
                    VStack {
                        KeyWidget()
                        RecordWidget()
                    }
                }
            }
        }
    }
}
struct TitleBar: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Title: ")
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                Text("Description: ")
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
        .padding(.leading)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
