//
//  MUSC291Q_MIDIModule.swift
//
//  Created by Brian Moore on 3/4/22.
//  Based on update 3/22/21
//  Modified by Daniel Riedel on 3/27/22

import Foundation
import AVKit
/**
 The MUSC291Q_MIDISynthesizer class involves two components: (1) an AVAudioMIDIInstrument and (2) an AVAudioSequencer.
 
 The AVAudioMIDIInstrument can handle note on/off as well as other MIDI events.
 The AVAudioSequencer is for advanced playback of MIDI files.
 The output of the sequencer will always be the primary AVAudioEngine which is connected to the AVAudioMIDIInstrument
 
 NOTE: If you want to use a different sound font than gs_instruments.dls, you'll need to make that change in the class...
 
```swift
 var soundFontURL = Bundle.main.url(forResource: "gs_instruments", withExtension: "dls")
 */
class MIDIModule {
    static var mainEngine = AVAudioEngine()
    
    var instrument:AVAudioUnitMIDIInstrument
    var sequencer:AVAudioSequencer
    var sequencerTrackArray = [AVMusicTrack]()
    var soundFontURL = Bundle.main.url(forResource: "gs_instruments", withExtension: "dls")
    
    private let instrumentDescription = AudioComponentDescription(
        componentType: kAudioUnitType_MusicDevice,
        componentSubType: kAudioUnitSubType_MIDISynth,
        componentManufacturer: kAudioUnitManufacturer_Apple,
        componentFlags: 0,
        componentFlagsMask: 0)
    
    private enum MUSC291QError: Error {
        case badURLforFile
        case illegalPatchNumber
        case undefined
    }
    

    
    //MARK: -
    //MARK: init routine
    /**
     
    If you do not wish to include a midi file, simply use "" for fileName and fileExt
     */
    init(defaultPatch:UInt8?, defaultChannel:UInt8?, midiFileName:String?, midiFileExt:String?) {
        
        // step #1 - create a basic AVAudioUnitMIDIInstrument
        instrument = AVAudioUnitMIDIInstrument(audioComponentDescription: instrumentDescription)
        
        // step #2 - tweak the instrument to support soundfont
        let status = AudioUnitSetProperty(
            instrument.audioUnit,
            AudioUnitPropertyID(kMusicDeviceProperty_SoundBankURL),
            AudioUnitScope(kAudioUnitScope_Global),
            AudioUnitElement(0),
            &soundFontURL,
            UInt32(MemoryLayout<URL>.size))
        if status != noErr {
            print("error with AudioUnitSetProperty")
        }
        
        // step #3 - connect the instrument to the primary audio engine
        MIDIModule.mainEngine.attach(instrument)
        MIDIModule.mainEngine.connect(instrument, to: MIDIModule.mainEngine.mainMixerNode, format: nil)
        
        // step #4 - assign the sequencer to the primary audio engine
        sequencer = AVAudioSequencer(audioEngine: MIDIModule.mainEngine)
        
        // step #4 - last todo... preload a default patch for the instrument
        //but first prepare the mainEngine so that the patch can be loaded
        MIDIModule.mainEngine.prepare()
        
        if !(0...127).contains(defaultPatch!) {
            print("WARNING: \(MUSC291QError.illegalPatchNumber)")
            loadPatchFromSoundBank(patchNum: 0, ch: 0) // use channel 0
        } else {
            loadPatchFromSoundBank(patchNum: defaultPatch!, ch: defaultChannel!)
        }
        
        // step B - load the sequencer with the midi file - check for errors as well
        let fileURL = Bundle.main.url(forResource: midiFileName, withExtension: midiFileExt)
        
        /**
         If AVMusicSequenceLoadSMF_ChannelsToTracks is set, the loaded MIDI Sequence will contain a
         tempo track, one track for each MIDI channel that is found in the SMF, and one track for
         SysEx and/or MetaEvents (this will be the last track in the sequence).

         If AVMusicSequenceLoadSMF_ChannelsToTracks is not set, the loadad MIDI Sequence will
         contain one track for each track that is found in the SMF, plus a tempo track (if not found
         in the SMF).
         */
        if fileURL != nil {
            do {
                try sequencer.load(from: Bundle.main.url(forResource: midiFileName,
                            withExtension: midiFileExt)!)
                                 // options: .smf_ChannelsToTracks) // smf_ChannelsToTracks
                sequencerTrackArray = sequencer.tracks
                sequencer.prepareToPlay()
            } catch {
                print("Problems loading midi file: \(error)")
            }
        } else {
            print("WARNING: \(MUSC291QError.badURLforFile)")
        }
        
        do {
            try MIDIModule.mainEngine.start()
        } catch {
            print("Error starting the AVAudioEngine in MIDIModule")
        }
    }
    
    //MARK:
    //MARK: Set Patch
    /**
     Patch numbers (0-127) and channel numbers (0-15) are Zero based
     */
    func loadPatchFromSoundBank(patchNum:UInt8, ch:UInt8) {
        var enabled = UInt32(1)
        var status = AudioUnitSetProperty(
            instrument.audioUnit,
            AudioUnitPropertyID(kAUMIDISynthProperty_EnablePreload),
            AudioUnitScope(kAudioUnitScope_Global),
            0,
            &enabled,
            UInt32(MemoryLayout<UInt32>.size))
        
        if status != noErr {
            print("Issue with loadPatchFromSoundBank audio set \(status)")
        }
        
        // set the patch on channel
        status = MusicDeviceMIDIEvent(
            instrument.audioUnit,
            UInt32(0xC0 + ch),
            UInt32(patchNum),
            0,
            0)
        
        if status != 0 {
            print("Issue with MusicDeviceMIDIEvent \(status)")
        }
        
        // turn off preload of sound bank
        enabled = UInt32(0)
        status = AudioUnitSetProperty(
            instrument.audioUnit,
            AudioUnitPropertyID(kAUMIDISynthProperty_EnablePreload),
            AudioUnitScope(kAudioUnitScope_Global),
            0,
            &enabled,
            UInt32(MemoryLayout<UInt32>.size))
        
        if status != 0 {print("Issue with loadPatchFromSoundBank enable OFF")
        }
        // finally ask the instrument to assign the patch
        instrument.sendProgramChange(patchNum, onChannel: ch)
    }

    //MARK: Play note for duration (in seconds)
    /**
    Duration is in seconds and channel is 0 to 15
     */
    func note(pitch:UInt8, duration:Double, channel:UInt8) {
        if (0...15).contains(channel) {
            instrument.startNote(pitch, withVelocity: 100, onChannel: channel)
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                self.instrument.stopNote(pitch, onChannel: channel)
            })
        } else {
            print("Warning: Channel is out of range!!")
        }
    }
    //MARK: -
    //MARK: Sequencer Playback Controls
    
    func play() {
        do {
            try sequencer.start()
        } catch {
            print("Error in Play: \(error)")
        }
    }
    
    func pause() {
        sequencer.stop()
    }
    
    func stop() {
        sequencer.stop()
        sequencer.currentPositionInSeconds = 0.0 // rewind
    }
}
