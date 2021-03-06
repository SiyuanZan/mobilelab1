//
//  ContentView.swift
//  MobileLabOneButtonKit
//
//  Created by Nien Lam on 1/5/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    // Track current index.
    @State private var currentIndex = 0
    
    // Player for sound clips.
    let audioPlayer = AVPlayer()
    
    ///////////////////////////////////////////////////////////////////////////
    // EDIT START /////////////////////////////////////////////////////////////
    
    // Set to 'true' or 'false' to control content sequence.
    // Either flip through content in sequence or randomize.
    let randomize = false
    
    // Set to array size.
    // Make sure all arrays are the same length and matches array size.
    let arraySize = 4
    
   
   
    
    // Background colors.
    let bgColors = [0x61BB46,
                    0xFDB827,
                    0xF5821F,
                    0xE03A3E,
                    ]
    
    // Image name array.
    // Set to image name or set to empty string.
    @State private var  imageNames:[String] = ["mb1",
                      "mb2",
                      "mb3",
                      "4"]
    
//    var imageNames2:[String] = ["4",
//    "5",
//    "6"]
    
    
    // String array for label.
    // Set text or set to empty string.
    let labels = ["",
                  "",
                  "",
                  "",
                  ]
    
    // MP3 sound file array.
    // Set mp3 file name or set to empty string.
    let sounds = ["",
                  "3.mp3",
                  "2.mp3",
                  "ding.wav",
                  
                  ]
    
    // EDIT END   /////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
   //returns 0 to 2 randomly
    
    // Compute next index.
    var nextIndex: Int {
        if randomize {
            return Int.random(in: 1..<arraySize)
        } else {
            return (currentIndex + 1 == arraySize) ? 0 : currentIndex + 1
        }
    }
    
    // Play sound helper method.
    func playSound(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "") else { return }
        
        let playerItem = AVPlayerItem(url: url)
        audioPlayer.replaceCurrentItem(with: playerItem)
        audioPlayer.play()
    }
    
    // Main view render method.
    var body: some View {
        // Use ZStack to layer elements.
        ZStack {
            // Backgrond color.
            Color(bgColors[currentIndex])
            
            // Show image if available.
            if !imageNames[currentIndex].isEmpty {
                Image(imageNames[currentIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }

            // Set text.
            Text(labels[currentIndex])
                .font(.custom("Futura-Medium", size: 48))
                .foregroundColor(.white)
                .padding()
                
            // Button for entire view.
            Button(action: {
                // Increment index when tapped.
                 var ci = arc4random_uniform(3) + 4
                self.currentIndex = self.nextIndex
                if(self.currentIndex==3){
                    self.imageNames[3]="\(ci)"
                    
                }
                print(  self.imageNames[3]="\(ci)")
                //self.MyInt=newValue
                //var newMyInt=myInt
                //newMyInt = newValue
                // Play sound if available.
                let sound = self.sounds[self.currentIndex]
                if !sound.isEmpty {
                    self.playSound(filename: sound)
                }
            }) {
                Color.clear.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            do {
               // Override device mute control.
               try AVAudioSession.sharedInstance().setCategory(.playback)
            } catch(let error) {
                print(error.localizedDescription)
            }
        }
    }
}

// Show preview in Canvas.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
