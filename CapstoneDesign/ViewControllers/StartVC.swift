//
//  LoginViewController.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/01/19.
//

import UIKit
import AVKit
import AVFoundation

class startVC: UIViewController {
    var playerLooper: AVPlayerLooper!
    var playerLayer: AVPlayerLayer!
    var queuePlayer: AVQueuePlayer!
    @IBOutlet weak var videoLayer: UIView!
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAnimation()
    }
    
    func setAnimation() {
        guard let path = Bundle.main.path(forResource: "LoginAni", ofType: "mp4") else {
            print("no file")
            return }
        let asset = AVAsset(url: URL(fileURLWithPath: path))
        let item = AVPlayerItem(asset: asset)
        
        queuePlayer = AVQueuePlayer(playerItem: item)
        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: item)
        playerLayer = AVPlayerLayer(player: queuePlayer)
        playerLayer.frame = videoLayer.bounds
        playerLayer.videoGravity = .resizeAspectFill
        
        self.videoLayer.layer.addSublayer(playerLayer)
        queuePlayer.play()
        
    }
}
