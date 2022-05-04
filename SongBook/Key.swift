//
//  Key.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/12/22.
//

/** musical key class representation*/
class Key {
    var name = ""
    var chords = [Chord?]()
    
    init(keyName: String,chordList: [Chord?]) {
        name = keyName
        chords = chordList
    }
}
