//
//  metronome.swift
//  SongBook
//
//  Created by Bridget Peterkin on 5/3/22.
//


import AVKit
import SwiftUI
import AVFoundation
/** DrumPad widget to play different drum sound via DrumButtons*/
struct DrumPad: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let meterBackgroundColor = Color(white: 0.95, opacity: 1.0)
    @State var playButton = "play.circle"
    var drum1 = "Bass"
    var drum2 = "Drum-Stick"
    var drum3 = "Snare"
    var drum4 = "Crash-Cymbal"
    var drum5 = "Hi-Hat"
    var drum6 = "Triangle"
    var drum7 = "Floor-Tom"
    var drum8 = "Medium-Tom"
    var drum9 = "Small-Tom"
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("BackColor"),Color("BackColor")],startPoint: .top, endPoint: .bottom)
            VStack() {
                // setup drum buttons
                Text("Drum Pad")
                    .font(.title)
                    .multilineTextAlignment(.leading)
                Spacer()
                    HStack(spacing: 24) {
                        DrumButton(fileName: drum1)
                        DrumButton(fileName: drum2)
                        DrumButton(fileName: drum3)
                    }.font(.title2)
                    HStack(spacing: 24) {
                        DrumButton(fileName: drum4)
                        DrumButton(fileName: drum4)
                        DrumButton(fileName: drum6)
                    }.font(.title2)
                    HStack(spacing: 24) {
                        DrumButton(fileName: drum7)
                        DrumButton(fileName: drum8)
                        DrumButton(fileName: drum9)
                    }.font(.title2)
                Spacer()
            
            }.padding(.all)
                
        }
    }

}
    
