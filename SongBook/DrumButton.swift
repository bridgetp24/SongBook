//
//  DrumButton.swift
//  SongBook
//
//  Created by Bridget Peterkin on 5/3/22.
//
import AVKit
import SwiftUI
import AVFoundation
/**
 Drum Button struct to play a drum hit on a button press
 */
struct DrumButton: View {
    let meterBackgroundColor = Color(white: 0.95, opacity: 1.0)
    
    @State var drum:AVAudioPlayer?
    @State var meterTimer:Timer?
    
    var fileName: String
    
    var body: some View {
       
        ZStack {
            LinearGradient(colors: [Color("Color"),Color("Color-1")],startPoint: .top, endPoint: .bottom)
            VStack() {
                    // button to play sound
                    HStack(spacing: 24) {
                        Button(action: {
                            play()
                        }, label: {
                            Text(fileName)
                                .fontWeight(.semibold)
                                .foregroundColor(Color("AccentColor"))
                        })
                    }.font(.title2)
                    .padding(.all)
            
            }
                
        }.onAppear() {
            setup()
        }
    }
    func setup() {
        // setup audio file for drum sound
        let fileUrl = Bundle.main.url(forResource:fileName,withExtension:"mp3")
        drum = try! AVAudioPlayer(contentsOf: fileUrl!)
        drum?.prepareToPlay()
    }
    func play() {
        drum?.prepareToPlay()
        drum?.play()
    }
}
    
