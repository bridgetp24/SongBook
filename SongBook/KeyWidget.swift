//
//  KeyWidget.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/12/22.
//

import Foundation
import SwiftUI
struct KeyWidget: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("BackColor"),Color("BackColor")],startPoint: .top, endPoint: .bottom)
            HStack {
                VStack() {
                    Text("Key Widget")
                        .font(.title)
                        .multilineTextAlignment(.leading)
                    // chord selecter
                    Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                        /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                        /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                    }
                    // chords
                    
                    // show tab check box
                    Spacer()
                }
            }
            .padding(.all)

        }
    }
}


