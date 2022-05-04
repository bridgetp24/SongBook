//
//  KeyWidget.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/12/22.
//

import Foundation
import SwiftUI
struct KeyWidget: View {

    var chordNames = ["A","B","C","D","E","F","G","Am","Bm","C#m","Dm","D#m","Em","F#m","Gm","G#m","Ab","Bb","Db","Eb","G#dim","Adim","A#dim","Bdim","C#dim","D#dim","Edim","F#dim","Gdim","F#"]
    var keyNames = ["AMajor","BMajor","CMajor","DMajor","EMajor","FMajor","GMajor"]
    @State var chords = [String: Chord]()
    @State var Keys = [String: Key]()
    @State var KeyString = ""
    @State private var selectedKey = 0
    @State var selectChords: [Chord?] = []
    @State var numChord = 0
    @State var selectedImage = "a"
    var romanNums = ["I","I","II","IV","V","VI","VII"]
    var chordProgs = ["I V VI IV","VI IV I V","I IV V IV","I VI IV V","II V I VI"]
    @State var selectedProg = 0
    @State var keyProg = ""
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
                                        Text(keyNames[index])
                                            .foregroundColor(Color("AccentColor"))
                                        
                                    }).foregroundColor(Color.red)
                    }).onChange(of: selectedKey) { _ in
                        print("Key selected " + (keyNames[selectedKey]))
                        var newKeyString = ""
                        let chords = Keys[keyNames[selectedKey]]?.chords
                        for val in 0..<((chords?.count)!) {
                            newKeyString = newKeyString + "  " + (chords?[val]?.name ?? "error")
                        }
                        selectChords = chords!
                        KeyString = newKeyString
                    }
                    // chord
                    Text("    I                  II                  III                  IV                  V                  VI                  VII ")
                        .multilineTextAlignment(.center)
                        
                    HStack {
                        ForEach(selectChords, id: \.?.name) {chor in
                            VStack {
                                ChordButton(text: chor?.name ?? "error")
                                    .scaleEffect()
                                    .foregroundColor(Color.black)
                            }

                        }
                    }
                    Spacer()
                    HStack {
                        Picker("Chord Progression", selection: $selectedProg, content: {
                                        ForEach(0..<chordProgs.count, content: { index in // <2>
                                            Text(chordProgs[index])
                                                .foregroundColor(Color("AccentColor"))// <3>
                                        })
                        }).onChange(of: selectedProg) { _ in
                            let prog = getNewProg()
                            keyProg = prog
                        }
                        Text(keyProg)
                            .foregroundColor(Color("AccentColor"))// <3>
                    }

                    Spacer()
                    

                }
            }
            .padding(.all)

        }.onAppear {
            defineKeys()
            var newKeyString = ""
            let chords = Keys[keyNames[selectedKey]]?.chords
            for val in 0..<((chords?.count)!) {
                newKeyString = newKeyString + "  " + (chords?[val]?.name ?? "error")
            }
            selectChords = chords!
            KeyString = newKeyString
            
            let prog = getNewProg()
            keyProg = prog
        }
    
    }
    func getNewProg()-> String {
        let chords = Keys[keyNames[selectedKey]]?.chords
        print("new chord progression selected")
        let progArr = chordProgs[selectedProg].components(separatedBy: " ")

        var prog = ""
        print(selectedProg)
        print(progArr)
        for num in progArr{
            print(num)
            var chordNum = ""
            if(num == "I") {
                chordNum = chords?[0]?.name ?? "chord not found"
            }else if(num == "II") {
                chordNum = chords?[1]?.name ?? "chord not found"
            }else if(num == "III") {
                chordNum = chords?[2]?.name ?? "chord not found"
            }else if(num == "IV") {
                chordNum = chords?[3]?.name ?? "chord not found"
            }else if(num == "V") {
                chordNum = chords?[4]?.name ?? "chord not found"
            } else if(num == "VI"){
                chordNum = chords?[5]?.name ?? "chord not found"
            }else if (num == "VII") {
                chordNum = chords?[6]?.name ?? "chord not found"
            }
            prog = prog + " " + chordNum
            print(prog)
        }
        return prog
    }
    func defineKeys() {
        for chord in chordNames {
            chords[chord] = Chord(chordName: chord)
        }
        Keys["AMajor"] = Key(keyName: "Amajor", chordList: [chords["A"],chords["Bm"],chords["C#m"],chords["D"],chords["E"],chords["F#m"],chords["G#dim"]])
        Keys["BMajor"] = Key(keyName: "Bmajor", chordList: [chords["B"],chords["C#m"],chords["D#m"],chords["E"],chords["F#"],chords["G#m"],chords["A#dim"]])
        Keys["CMajor"] = Key(keyName: "Cmajor", chordList: [chords["C"],chords["Dm"],chords["Em"],chords["F"],chords["G"],chords["Am"],chords["Bdim"]])
        Keys["DMajor"] = Key(keyName: "Dmajor", chordList: [chords["D"],chords["Em"],chords["F#m"],chords["G"],chords["A"],chords["Bm"],chords["C#dim"]])
        Keys["EMajor"] = Key(keyName: "Emajor", chordList: [chords["E"],chords["F#m"],chords["G#m"],chords["A"],chords["B"],chords["C#m"],chords["D#dim"]])
        Keys["FMajor"] = Key(keyName: "Fmajor", chordList: [chords["F"],chords["Gm"],chords["Am"],chords["Bb"],chords["C"],chords["Dm"],chords["Edim"]])
        Keys["GMajor"] = Key(keyName: "Gmajor", chordList: [chords["G"],chords["Am"],chords["Bm"],chords["C"],chords["D"],chords["Em"],chords["F#dim"]])
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



