//
//  LyricView.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/7/22.
//

/** Default view if no canvas is selected */
import Foundation
import SwiftUI
import PencilKit
struct LyricView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("BackColor"),Color("BackColor")],startPoint: .top, endPoint: .bottom)
            VStack{
                Image(systemName: "scribble.variable")
                    .font(.largeTitle)
                Text("No canvas has been selected")
                    .font(.title)
            }
        }
    }
}


