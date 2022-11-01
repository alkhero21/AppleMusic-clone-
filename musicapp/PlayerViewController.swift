//
//  PlayerViewController.swift
//  musicapp
//
//  Created by Alibek Allamzharov on 01.11.2022.
//

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder: UIView!
    
    var player: AVAudioPlayer?
    
    private let albumImageView: UIImageView = {
       let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        return ImageView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let playPauseButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0{
            configure()
        }
    }
    
    func configure(){
        
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else{
                return
            }
            player?.volume = 0.5
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else{
                return
            }
            
            player.play()
        }catch{
            print("error occured")
        }
        
        albumImageView.frame = CGRect(x: 40,
                                      y: 40,
                                      width: holder.frame.size.width-80,
                                      height: holder.frame.size.width-80)
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)



        songNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 55,
                                     width: holder.frame.size.width-20,
                                     height: 90)
        albumNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 60 + 50,
                                     width: holder.frame.size.width-20,
                                     height: 70)
        artistNameLabel.frame = CGRect(x: 10,
                                       y: albumImageView.frame.size.height + 75 + 60,
                                       width: holder.frame.size.width-20,
                                       height: 70)
        
        songNameLabel.font = UIFont(name: "Helvetica-Bold", size: 22)
        artistNameLabel.font = UIFont(name: "Helvetica", size: 16)
    
        artistNameLabel.textColor = UIColor.red
        
        

        songNameLabel.text = song.name
        albumNameLabel.text = song.albumName
        artistNameLabel.text = song.artistName
        // songNameLabel.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)

        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)

        //PLayerControls

        
        let nextButton = UIButton()
        let backButton = UIButton()
        
        //Frame
        
        let yPosition = artistNameLabel.frame.origin.y + 85 + 30
        let size: CGFloat = 40
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                       y: yPosition,
                                       width: size,
                                       height: size)
        
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 60,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        backButton.frame = CGRect(x: 60,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        
        //Add actions
        playPauseButton.addTarget(self, action: #selector(didTapPLayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        
        
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        
        
        playPauseButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black
        
        
        holder.addSubview(playPauseButton)
        holder.addSubview(backButton)
        holder.addSubview(nextButton)
        
        

        //Slider
        let slider = UISlider(frame: CGRect(x: 0,
                                            y: holder.frame.size.height - 95,
                                            width: holder.frame.size.height - 30,
                                            height: 10))

        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
        
        
        
        
    }
    
    @objc func didTapBackButton(){
        
        if position > 0{
            position = position - 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
        
    }
    
    @objc func didTapNextButton(){
        
        if position < (songs.count - 1){
            position = position + 1
            player?.stop()
            for subview in holder.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
        
    }
    
    @objc func didTapPLayPauseButton(){
        if player?.isPlaying == true{
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
            self.albumImageView.frame = CGRect(x: 60,
                                          y: 60,
                                          width: self.holder.frame.size.width-120,
                                          height: self.holder.frame.size.width-120)
        }else{
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 40,
                                              y: 40,
                                              width: self.holder.frame.size.width-80,
                                              height: self.holder.frame.size.width-80)
            })
        }
    }
    
    @objc func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player{
            player.stop()
        }
    }

}
