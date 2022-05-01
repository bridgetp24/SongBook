//
//  ChordButton.swift
//  SongBook
//
//  Created by Daniel Riedel on 3/29/22.
//  Modified by Bridget Peterkin on 4/21/22
//

import Foundation
import SwiftUI
import AVKit

struct ChordButton: View {
    var text: String
    @State var midiPlayer1 = AVMIDIPlayer()
    
    var body: some View {
        VStack {
        Text(text)
            .onTouchDownGesture {
              playChord()
            }
        Image(text)
            .resizable()
            .frame(width: 75.0, height: 150.0)
        }.onAppear{
            setup(text: text)
        }.onTouchDownGesture {
            playChord()
        }
    }
    func setup(text: String) {
        print("setting up " + text)
        midiPlayer1 = try! AVMIDIPlayer(
              contentsOf: Bundle.main.url(forResource: text, withExtension: "mid", subdirectory: "GuitarChords")!, soundBankURL: Bundle.main.url(forResource: "gs_instruments", withExtension: "dls"))
    }
    func playChord() {
        midiPlayer1.currentPosition = 0.0
        midiPlayer1.play()
    }
}

extension View {
    func onTouchDownGesture(callback: @escaping () -> Void) -> some View {
        modifier(OnTouchDownGestureModifier(callback: callback))
    }
}

private struct OnTouchDownGestureModifier: ViewModifier {
    @State private var tapped = false
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !self.tapped {
                        self.tapped = true
                        self.callback()
                    }
                
                }
                .onEnded { _ in
                    self.tapped = false
                })
    }
}
