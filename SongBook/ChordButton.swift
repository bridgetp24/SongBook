//
//  ChordButton.swift
//  SongBook
//
//  Created by Daniel Riedel on 3/29/22.
//  Modified by Bridget Peterkin on 4/21/22
//

import Foundation
import SwiftUI

struct ChordButton: View {
    var text: String
//    var midiModule: MIDIModule
//    var pitch: UInt8
//    var duration: Double
//    var channel: UInt8
    
    var body: some View {
        Text(text)
            .onTouchDownGesture {
                //midiModule.note(pitch: pitch, duration: duration, channel: channel)
            }
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
