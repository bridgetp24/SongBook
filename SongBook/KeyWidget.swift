//
//  KeyWidget.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/12/22.
//

import Foundation
import SwiftUI
struct KeyWidget: View {

    var chordNames = ["A","B","C","D","E","F","G","Am","Bm","C#m","Dm","D#m","Em","F#m","Gm","G#m","Ab","Bb","Db","Eb","G#dim","Adim","A#dim","Bdim","C#dim","D#dim","Edim","F#dim","Gdim"]
    var keyNames = ["Amajor","BMajor","CMajor","DMajor","EMajor","FMajor","GMajor"]
    @State var chords = [String: Chord]()
    @State var Keys = [String: Key]()
    @State private var selectedKey = 0
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("BackColor"),Color("BackColor")],startPoint: .top, endPoint: .bottom)
            HStack {
                VStack() {
                    Text("Key Widget")
                        .font(.title)
                        .multilineTextAlignment(.leading)
                    // chord selecter
                    Picker("Key", selection: $selectedKey, content: {
                                    ForEach(0..<keyNames.count, content: { index in // <2>
                                        Text(keyNames[index]) // <3>
                                    })
                    })
                    // chords
                    let currKey = Keys[keyNames[selectedKey]]
//                    ForEach(currKey!.chords, id: \.self) { chord in
//                        Text(chord!.name)
//                    }
                    
                    // show tab check box
                    Spacer()
                }
            }
            .padding(.all)

        }
    }
    func defineKeys() {
        for chord in chordNames {
            chords[chord] = Chord(chordName: chord)
        }
        Keys["Amajor"] = Key(keyName: "Amajor", chordList: [chords["A"],chords["Bm"],chords["C#m"],chords["D"],chords["E"],chords["F#m"],chords["G#dim"]])
        Keys["Bmajor"] = Key(keyName: "Amajor", chordList: [chords["B"],chords["C#m"],chords["D#m"],chords["E"],chords["F#"],chords["G#m"],chords["A#dim"]])
        Keys["Cmajor"] = Key(keyName: "Amajor", chordList: [chords["C"],chords["Dm"],chords["Em"],chords["F"],chords["G"],chords["Am"],chords["Bdim"]])
        Keys["Dmajor"] = Key(keyName: "Amajor", chordList: [chords["D"],chords["Em"],chords["F#m"],chords["G"],chords["A"],chords["Bm"],chords["C#dim"]])
        Keys["Emajor"] = Key(keyName: "Amajor", chordList: [chords["E"],chords["F#m"],chords["G#m"],chords["A"],chords["B"],chords["C#m"],chords["D#dim"]])
        Keys["Fmajor"] = Key(keyName: "Amajor", chordList: [chords["F"],chords["Gm"],chords["Am"],chords["Bb"],chords["C"],chords["Dm"],chords["Edim"]])
        Keys["Gmajor"] = Key(keyName: "Amajor", chordList: [chords["G"],chords["Am"],chords["Bm"],chords["C"],chords["D"],chords["Em"],chords["F#dim"]])
        
    }
}


enum Keys: String, CaseIterable, Identifiable {
    case Amajor
    case BMajor
    case CMajor
    case DMajor
    case EMajor
    case FMajor
    case GMajor
    var id: String { self.rawValue }
}



