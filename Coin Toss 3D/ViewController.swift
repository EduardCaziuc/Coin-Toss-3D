//
//  ViewController.swift
//  Coin Toss 3D
//
//  Created by Eduard Caziuc on 24/04/2018.
//  Copyright © 2018 Eduard Caziuc. All rights reserved.
//

import UIKit
import QuartzCore


let reps = 2
let animation: Double = 0.15

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    @IBOutlet weak private var coinView: UIImageView!
    @IBOutlet weak private var flipButton: UIButton!
    
    private var coinSoundProvider = CoinSoundProvider()
    private var repeatCount = 0
    private var animationDuration = animation
    private var maxReps = reps
    
    private var headsImage = UIImage(named: "Heads")!.cgImage
    private var tailsImage = UIImage(named: "Tails")!.cgImage
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
         coinView.layer.contents = (Int(arc4random()) % 2 == 0) ? self.tailsImage : self.headsImage
    }
    
    @IBOutlet weak var ChangeCoinButton: UIButton!
    
    @IBAction func ChanceCoinButtonPressed(_ sender: Any) {
        let buttonCurrentBackground = ChangeCoinButton.currentBackgroundImage
        let headButtonImage = UIImage(named: "Heads")
        let head1ButtonImage = UIImage(named: "Heads-1")
        
        if buttonCurrentBackground == UIImage(named: "Heads-1") {
            headsImage = UIImage(named: "Heads-1")!.cgImage
            tailsImage = UIImage(named: "Tails-1")!.cgImage
            coinView.layer.contents = self.headsImage
            ChangeCoinButton.setBackgroundImage(headButtonImage, for: .normal)
        } else if buttonCurrentBackground == UIImage(named: "Heads") {
            headsImage = UIImage(named: "Heads")!.cgImage
            tailsImage = UIImage(named: "Tails")!.cgImage
            coinView.layer.contents = self.headsImage
            ChangeCoinButton.setBackgroundImage(head1ButtonImage, for: .normal)
            
        }
    }
    
    func doAnimation() {
        
        if repeatCount > maxReps {
            
            coinView.layer.contents = (Int(arc4random()) % 2 == 0) ? self.tailsImage : self.headsImage
            coinView.layer.transform = CATransform3DIdentity
            flipButton.isEnabled = true
            
            return
        }
        repeatCount += 1
        
        if repeatCount == 1 {                    // first time for this animation
            let duration = animationDuration * Double((maxReps+1))
            
            let startFrame = coinView.frame
            UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                var frame = self.coinView.frame
                
                frame.origin.y = 1
                self.coinView.frame = frame
                
                self.coinView.rotate360Degrees()
               
            }, completion: {
                _ in
                
                UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
                    self.coinView.frame = startFrame
                }, completion: nil)
            })
        }
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            var rotation = CATransform3DIdentity
            
            
            
            rotation = CATransform3DRotate(rotation, 0.8 * CGFloat.pi, 1.0, 0.0, 0.0)
            self.coinView.layer.transform = rotation
        }, completion: {
            _ in
            
            self.coinView.layer.contents = self.tailsImage
            //                self.coinView.layer.contents = (Int(arc4random()) % 2 == 0) ? self.tailsImage : self.headsImage
            
            UIView.animate(withDuration: self.animationDuration, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
                
                var rotation = self.coinView.layer.transform;
                
                rotation = CATransform3DRotate(rotation, 3 * CGFloat.pi, 1.0, 0.0, 0.0);
                self.coinView.layer.transform = rotation;
            }, completion: {
                _ in
                
                //  self.coinView.layer.contents = (Int(arc4random()) % 2 == 0) ? self.tailsImage : self.headsImage
                
                self.coinView.layer.contents = self.headsImage
                
                self.doAnimation()
                
            })
        })
    }
    
    @IBAction func doFlipCoin(_ sender: Any) {
        self.coinView.rotate360Degrees()
        let button = sender as! UIButton
        button.isEnabled = false
        coinSoundProvider.playCoinSound()
        self.repeatCount = 0;
        self.coinView.layer.removeAllAnimations()
        self.coinView.layer.contents = self.headsImage
        doAnimation()
    }
    
}
