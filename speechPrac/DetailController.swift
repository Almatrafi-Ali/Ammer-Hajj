//
//  DetailController.swift
//  speechPrac
//
//  Created by Ali on 20/11/1439 AH.

//

import UIKit
import AVFoundation
import SceneKit

class DetailController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var detailText:String?
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "S1", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch{
                print("ERROR!!")
            }
            
            
            
        } catch {
            print("ERROrR")
        }
        
        audioPlayer.play()

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) { // 8
        super.viewWillAppear(animated)
        
        if let t = detailText {     // جربتها في viewDidLoad وضبطت
            label.text = t
            
            print("ccc\(t)")
        }
    }

    
    @IBAction func btn2(_ sender: Any) {
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "s2", ofType: "mp3")!))
            audioPlayer2.prepareToPlay()
            
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch{
                print("ERROR!!")
            }
            
            
            
        } catch {
            print("ERROrR")
        }
        
        audioPlayer2.play()
    }
    
}
