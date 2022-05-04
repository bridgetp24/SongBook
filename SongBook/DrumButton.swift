//
//  DrumButton.swift
//  SongBook
//
//  Created by Bridget Peterkin on 5/3/22.
//
import AVKit
import SwiftUI
import AVFoundation
struct DrumButton: View {
    let meterBackgroundColor = Color(white: 0.95, opacity: 1.0)
    
    @State var drum:AVAudioPlayer?
    @State var meterTimer:Timer?
    
    var fileName: String
    
    var body: some View {
       
        ZStack {
            LinearGradient(colors: [Color("Color"),Color("Color-1")],startPoint: .top, endPoint: .bottom)
            VStack() {
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
        let fileUrl = Bundle.main.url(forResource:fileName,withExtension:"mp3")
        drum = try! AVAudioPlayer(contentsOf: fileUrl!)
        drum?.prepareToPlay()
    }
    func play() {
        drum?.prepareToPlay()
        drum?.play()
    }
}
    
