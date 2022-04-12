//
//  LyricView.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/7/22.
//

import Foundation
import SwiftUI

struct LyricView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("BackColor"),Color("BackColor")],startPoint: .top, endPoint: .bottom)
            HStack{
                TextEditor(text: .constant("Add your song lyrics here!"))
                    .padding(.all)
            }
        }
    }
}

