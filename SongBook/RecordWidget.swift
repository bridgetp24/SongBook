//
//  RecordWidget.swift
//  SongBook
//
//  Created by Bridget Peterkin on 4/12/22.
//

import AVKit
import SwiftUI
struct RecordWidget: View {

    let meterBackgroundColor = Color(white: 0.95, opacity: 1.0)
    //STEP 1 - create an instance of an AVAudioRecorder
    @State var huskerRecorder: AVAudioRecorder?
    
    //STEP 2 - create an instance of an AVAudioPlayer to hear what's been recorded
    @State var huskerPlayer: AudioPlayerWithDelegate?
    @State var status = false
    
    //STEP 3 - also see setup() - create temp file to store recording
    @State var docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    @State var audioDocument = URL(string: "")
    
    
    @State var statusMessage = "Status..."
    
    let defaultMeterValue = Double(60)
    @State var meterValue = Double(0)
    @State private var selectedRecording = 0
    @State private var recordings = ["recording1"]
    @State var meterTimer:Timer?
    @State var recordingNum = 0
    @State var unit = 0
    @State var isFirst = true
    enum MeterMode {
        case record
        case play
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("BackColor"),Color("BackColor")],startPoint: .top, endPoint: .bottom)
            VStack() {
                Text("Record Widget")
                    .font(.title)
                    .multilineTextAlignment(.leading)
                Spacer()
                if recordingNum > 0 {
                    Text(recordings[selectedRecording])
//                    Button(action: {
//                        rename()
//                    }, label: {
//                        Text(recordings[selectedRecording])
//                    })
                    HStack(spacing: 24) {
                        Button(action: {
                           recording()
                        }, label: {
                            Text("Record")
                            Image(systemName: "record.circle")
                        })
                        
                        Button(action: {
                            stopping()
                        }, label: {
                            Text("Stop")
                            Image(systemName: "stop.circle")
                        })
                        
                        Button(action: {
                            playing()
                        }, label: {
                            Text("Play")
                            Image(systemName: "play.circle")
                        })
                    }.font(.title2)
                    Picker("Recording", selection: $selectedRecording, content: {
                                    ForEach(0..<recordings.count, content: { index in // <2>
                                        Text(recordings[index]) // <3>
                                    })
                    }).onChange(of: selectedRecording) { _ in
                        setupNewRecording(recordingName: recordings[selectedRecording])
                    }.id(unit)
                }
                
                Button(action: {
                    print("making new recording")
                    if recordingNum == 0 {
                        recordingNum += 1
                        setup()
                    }else {
                        recordingNum += 1
                        let name = "recording" + String(recordingNum)
                        setupNewRecording(recordingName: name)
                        recordings.append(name)
                        print(recordings)
                    }
                    selectedRecording = recordings.count-1
                    unit = unit + 1
                }, label: {
                    Label("new recording", systemImage: "plus")
                })
                Spacer()
            }
            .padding(.all)
        }.onAppear() {
            setup()
        }
    }
    func setupNewRecording(recordingName: String){
        audioDocument = docDir
        audioDocument?.appendPathComponent(recordingName + ".caf")
        let audioSession = AVAudioSession.sharedInstance()
        
        print("created document called " + recordingName)
        
        do {
            try audioSession.setCategory(.playAndRecord)
        } catch {
            print(error)
        }
        
        //STEP 4 - settings to be used for recordings - many are available - see documentation for AVAudioRecorder init...
        let recordingSettings = [AVFormatIDKey: kAudioFormatAppleLossless,
                               AVSampleRateKey: 44100.0, // CD Quality
                         AVNumberOfChannelsKey: 2] as [String : Any]
                                 
        do {
            try huskerRecorder = AVAudioRecorder(url: audioDocument!, settings: recordingSettings)
            huskerRecorder?.prepareToRecord()
            huskerRecorder?.isMeteringEnabled = true
        } catch {
            print("issue with recorder setup = \(error)")
        }
//        setupMeterTimer(start: false, mode: .record)
        
        //STEP 5 - setup metering for playback
        huskerPlayer = AudioPlayerWithDelegate(location: audioDocument)
    }
    //STEP 3 (part of creating temp file)
    func setup() {
        audioDocument = docDir
        audioDocument?.appendPathComponent("recording1.caf")

        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord)
        } catch {
            print(error)
        }
        
        //STEP 4 - settings to be used for recordings - many are available - see documentation for AVAudioRecorder init...
        let recordingSettings = [AVFormatIDKey: kAudioFormatAppleLossless,
                               AVSampleRateKey: 44100.0, // CD Quality
                         AVNumberOfChannelsKey: 2] as [String : Any]
                                 
        do {
            try huskerRecorder = AVAudioRecorder(url: audioDocument!, settings: recordingSettings)
            huskerRecorder?.prepareToRecord()
            huskerRecorder?.isMeteringEnabled = true
        } catch {
            print("issue with recorder setup = \(error)")
        }
        setupMeterTimer(start: false, mode: .record)
        
        //STEP 5 - setup metering for playback
        huskerPlayer = AudioPlayerWithDelegate(location: audioDocument)
    }
    //MARK: timer function
    func setupMeterTimer(start: Bool, mode: MeterMode ) {
        if meterTimer?.isValid == true {
            print("meterTimer NOT valid...")
        } else {
            meterTimer = Timer(timeInterval: 0.1, repeats: true, block: { timer in
                switch mode {
                case .record:
                    huskerRecorder?.updateMeters()
                    let ave1 = huskerRecorder?.averagePower(forChannel: 0)
                    let peak1 = huskerRecorder?.peakPower(forChannel: 0)
                    let ave2 = huskerRecorder?.averagePower(forChannel: 1)
                    let peak2 = huskerRecorder?.peakPower(forChannel: 1)
                    print("\(ave1!) | \(ave2!) : \(peak1!) | \(peak2!)")
                    meterValue = Double(ave1!) * -1.0
                case .play:
                    huskerPlayer?.player?.updateMeters()
                    let ave1 = huskerPlayer?.player?.averagePower(forChannel: 0)
                    let peak1 = huskerPlayer?.player?.peakPower(forChannel: 0)
                    let ave2 = huskerPlayer?.player?.averagePower(forChannel: 1)
                    let peak2 = huskerPlayer?.player?.peakPower(forChannel: 1)
                    print("\(ave1!) | \(ave2!) : \(peak1!) | \(peak2!)")
                    meterValue = Double(ave1!) * -1.0
                    
                    if huskerPlayer?.isPlaying == false {
                        stopping()
                    }
                }
            })
        }
        
        if start {
            RunLoop.current.add(meterTimer!, forMode: .common)
        }
    }
    
    func recording() {
        setupMeterTimer(start: true, mode: .record)
        huskerRecorder?.record()
        statusMessage = "Recording..."
    }
    
    func stopping() {
        huskerRecorder?.stop()
        statusMessage = "Stopping..."
        meterTimer!.invalidate()
        meterValue = defaultMeterValue
    }
    
    func playing() {
            huskerPlayer = AudioPlayerWithDelegate(location: huskerRecorder?.url)
            setupMeterTimer(start: true, mode: .play)
            huskerPlayer?.play()
        statusMessage = "Playing..."
    }
}

class AudioPlayerWithDelegate: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    var player:AVAudioPlayer?
    @Published var isPlaying = false
    
    init(location: URL?) {
        super.init()
        
        if location == nil {return}
            
        do {
            try player = AVAudioPlayer(contentsOf: location!)
            player?.delegate = self
            player?.isMeteringEnabled = true
        } catch {
            print(error)
        }
    }
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func stop() {
        player?.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
    
}

