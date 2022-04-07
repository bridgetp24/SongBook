//
//  ContentView.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/7/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Hello, world!")
                    Spacer()
                }
                
                LyricView()
            }

            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
