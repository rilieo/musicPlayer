//
//  mainThing.swift
//  um
//
//  Created by riley dou on 2023/1/3.
//

import SwiftUI
import AVKit
import AVFoundation

var player: AVAudioPlayer?

struct MusicPlayer: View {
    @ObservedObject var audiosettings = audioSettings()
    @State private var playButton: Image = Image(systemName: "play.circle")
    @State var value: Double = 0.0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            GeometryReader{ geo in
                PlayerView()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height+100)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(Color.black.opacity(0.2))
                    .blur(radius: 1)
                    .edgesIgnoringSafeArea(.all)
                
                Button(action: {
                    dismiss()
                },
                       label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 12, height: 20)
                        .foregroundColor(.white)
                    
                })
                .position(.init(x: 20, y: 10))
                
                VStack{
                    Spacer()
                    Text("please don't go")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .font(.title)
                    
                    Text("beowulf")
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                        .font(.body)
                    
                    VStack{
                        Slider(value: $audiosettings.playValue, in: TimeInterval(0.0)...(audiosettings.playerDuration), onEditingChanged: { _ in
                            self.audiosettings.changeSliderValue()
                        })
                        .onReceive(audiosettings.timer) { _ in
                                        
                                if self.audiosettings.playing {
                                    if let currentTime = self.audiosettings.audioPlayer?.currentTime {
                                        self.audiosettings.playValue = currentTime
                                                
                                        if currentTime == TimeInterval(0.0){
                                        self.audiosettings.playing = false
                                                }
                                            }
                                        }
                                    else {
                                        self.audiosettings.playing = false
                                        self.audiosettings.timer.upstream.connect().cancel()
                                }
                            }
                        
                        HStack{
                            Text(DateComponentsFormatter.positions.string(from: audiosettings.audioPlayer?.currentTime ?? 0.00) ?? "0.00")
                            Spacer()
                            Text(DateComponentsFormatter.positions.string(from: (audiosettings.playerDuration) - (audiosettings.audioPlayer?.currentTime ?? 0.00)) ?? "0.00")
                        }
                        .foregroundColor(.white)
                        .font(.caption)
                    }
                    
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            
                        },
                               label: {
                            Image(systemName: "backward.end.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            if (self.playButton == Image(systemName: "play.circle")) {
                                print("All Done")
                                // MARK: change song
                                self.audiosettings.playSound(sound: "please don't go")
                                self.audiosettings.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                                self.playButton = Image(systemName: "pause.circle")
                                
                            } else {
                                
                                self.audiosettings.pauseSound()
                                self.playButton = Image(systemName: "play.circle")
                            }
                        }) {
                            self.playButton
                                .foregroundColor(Color.blue)
                                .font(.system(size: 50))
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            
                        },
                               label: {
                            Image(systemName: "forward.end.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                        })
                        
                        Spacer()
                    }
                }
            }
        }
    }
}
    
struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }
        
    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}
    
class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: change background
        let fileUrl = Bundle.main.url(forResource: "please don't go", withExtension: "mov")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
            
        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
            
        // Start the movie
        player.play()
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
        
struct ContentView: View {
    var body: some View {
            MusicPlayer()
        }
    }
        
struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
                ContentView()
        }
    }


