//
//  LaunchScreenViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/19/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class LaunchScreenViewController: UIViewController {

    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadVideo()
    }
    
    private func loadVideo() {
        
        //this line is important to prevent background music stop
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch { }
        
        let path = Bundle.main.path(forResource: "Erad-Animated", ofType:"mp4")
        
        player = AVPlayer(url: URL(fileURLWithPath: path!) as URL)
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1
        
        self.view.layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    @objc func playerDidFinishPlaying(note: NSNotification){
        performSegue(withIdentifier: "launch", sender: self)
        print("lannnn")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "launch" {
            _ = segue.destination as! LoginViewController
        }
    }
}
