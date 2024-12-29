import SwiftUI
import AVFoundation

struct LyricsWithMusicView: View {
    @State private var currentLineIndex = 0
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    
    // Lyrics with timestamps in seconds
    let lyrics: [(text: String, time: Double)] = [
        ("Ooh", 0.0),
        ("I, I just woke up from a dream", 9.0),
        ("Where you and I had to say goodbye", 16.0),
        ("And I don't know what it all means", 20.0),
        ("But since I survived, I realized", 25.0),
        ("Wherever you go, that's where I'll follow", 30.0),
        ("Nobody's promised tomorrow", 34.0),
        ("So I'ma love you every night like it's the last night", 39.0),
        ("Like it's the last night", 43.0),
        ("If the world was ending, I'd wanna be next to you", 45.0),
        ("If the party was over and our time on Earth was through", 54.0),
        ("I'd wanna hold you just for a while and die with a smile", 60.4),
        ("If the world was ending, I'd wanna be next to you", 60.12),
        ("Ooh", 60.21),
        ("Oh, lost, lost in the words that we scream", 60.25),
        ("I don't even wanna do this anymore", 60.34),
        ("'Cause you already know what you mean to me", 60.38),
        ("And our love's the only war worth fighting for", 60.41),
        ("Wherever you go, that's where I'll follow", 60.47),
        ("Nobody's promised tomorrow", 60.52),
        ("So I'ma love you every night like it's the last night", 60.56),
        ("Like it's the last night", 61.0),
        ("If the world was ending, I'd wanna be next to you", 61.3),
        ("If the party was over and our time on Earth was through", 61.12),
        ("I'd wanna hold you just for a while and die with a smile", 61.21),
        ("If the world was ending, I'd wanna be next to you", 61.30),
        ("Right next to you", 61.38),
        ("Next to you", 61.43),
        ("Right next to you", 61.48),
        ("Oh-oh, oh", 61.52),
        ("If the world was ending, I'd wanna be next to you", 62.11),
        ("If the party was over and our time on Earth was through", 62.20),
        ("I'd wanna hold you just for a while and die with a smile", 62.29),
        ("If the world was ending, I'd wanna be next to you", 62.38),
        ("If the world was ending, I'd wanna be next to you", 62.47),
        ("Ooh", 62.56),
    ]
    
    var body: some View {
        ZStack {
            // Background with animated glowing love effect
            LinearGradient(
                colors: [.black, .purple, .pink],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Lyrics display
            VStack {
                Spacer()
                Text(lyrics[currentLineIndex].text)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .shadow(color: .yellow, radius: 10, x: 0, y: 0)
                    .scaleEffect(1.2)
                    .animation(.easeInOut(duration: 0.5), value: currentLineIndex)
                Spacer()
                
                // Play/Pause Button
                Button(action: {
                    if isPlaying {
                        audioPlayer?.pause()
                    } else {
                        audioPlayer?.play()
                    }
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.yellow)
                        .padding()
                }
            }
        }
        .onAppear {
            startAudioPlayback()
            syncLyricsWithAudio()
        }
    }
    
    // Start audio playback
    private func startAudioPlayback() {
        if let url = Bundle.main.url(forResource: "DieWithASmile", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                isPlaying = true
            } catch {
                print("Error loading audio: \(error)")
            }
        }
    }
    
    // Sync lyrics with the audio
    private func syncLyricsWithAudio() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            guard let player = audioPlayer else {
                timer.invalidate()
                return
            }
            let currentTime = player.currentTime
            
            // Find the next lyric that matches the current time
            if let nextLineIndex = lyrics.firstIndex(where: { $0.time > currentTime }) {
                // Update the lyric only if it's a new line (avoid redundant updates)
                if currentLineIndex != nextLineIndex - 1 {
                    currentLineIndex = max(0, nextLineIndex - 1)
                }
            } else {
                // If we've reached the end of the lyrics, stop the timer
                currentLineIndex = lyrics.count - 1
                timer.invalidate()
            }
        }
    }
}

