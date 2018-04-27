//
//  YouTubeTheoryViewController.swift
//  evys
//
//  Created by Nikita Zlain on 22.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import UIKit
import YouTubePlayer

class YouTubeTheoryViewController: ViewController {
    
    @IBOutlet weak var youtubePlayer: YouTubePlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myVideoURL = URL(string: "https://www.youtube.com/watch?v=_TiH1u1-kdc")
        youtubePlayer.loadVideoURL(myVideoURL!)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
