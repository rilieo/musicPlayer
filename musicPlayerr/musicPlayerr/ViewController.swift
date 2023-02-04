//
//  ViewController.swift
//  um
//
//  Created by riley dou on 2023/1/3.
//

import UIKit
import AVFoundation
import SwiftUI
import AVKit

class ViewController: UIViewController {

    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x:0, y:0, width:220, height:50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("fav :)", for: .normal)
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    

    @objc func tapped() {
        
        let vc = UIHostingController(rootView: ContentView())
        present(vc, animated: true)
        
    }
    
}

