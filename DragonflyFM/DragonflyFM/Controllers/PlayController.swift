//
//  PlayController.swift
//  DragonflyFM
//
//  Created by ChenChaoXiu on 2019/11/21.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import Alamofire
import AlamofireImage
import AVFoundation
import UIKit
var player:AVPlayer?
class PlayController: UIViewController {
    
    @IBOutlet weak var btnReturn: UIButton!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTotla: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblPast: UILabel!
    
    var play:VMPlaybills?
    var plays:[VMPlaybills]?
    var pos:Int?
    var contentId:Int32?
    var cover:String?
    var haderTitle:String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if player == nil {
            player = AVPlayer()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgCover.layer.cornerRadius = imgCover.frame.width / 2
        imgCover.clipsToBounds = true
        initPlay()
    }
    @IBAction func btnReturn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func displayAlbumInfo() {
        btnReturn.setTitle(haderTitle, for: .normal)
        lblTitle.text = plays![pos!].title
        if plays![pos!].username == "" {
            lblName.text =  "未知"
        } else {
            lblName.text = plays![pos!].username
        }
        Alamofire.request(cover!).responseImage{ response in
            if let imag = response.result.value {
                self.imgCover.image = imag
            }
        }
    }
    
    func initPlay() {
        displayAlbumInfo()
        let playItem = AVPlayerItem(url: URL(string: "http://lhttp.qingting.fm/live/" + "\(plays![pos!].channelId)" + "/64k.mp3")!)
        player!.replaceCurrentItem(with: playItem)
        player!.volume = 1
        let duration = playItem.asset.duration
        let seconds = CMTimeGetSeconds(duration)
        slider.minimumValue = 0
        slider.isEnabled = true
        slider.maximumValue = Float(plays![pos!].duration!)
//        slider.maximumValue = Float(3000)
        lblTotla.text = getLegaMinutes(seconds: Float(plays![pos!].duration!))
        slider.isContinuous = false
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1,preferredTimescale:  1), queue: DispatchQueue.main, using:
            {_ in
                if player!.currentItem?.status == .readyToPlay {
                    let currentTime = CMTimeGetSeconds(player!.currentTime())
                    self.slider.value = Float(currentTime)
                    self.lblPast.text = self.getLegaMinutes(seconds: Float(currentTime))
                }
        } )
    }
    
    
    func  getLegaMinutes(seconds:Float) -> String {
        let allTime: Int = Int(seconds)
        var hours = 0
        var minutes = 0
        var seconds = 0
        var hoursText = ""
        var minutesText = ""
        var secondsText = ""
        
        hours = allTime / 3600
        hoursText = hours > 9 ? "\(hours)" : "0\(hours)"
        minutes = allTime % 3600 / 60
        minutesText = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        seconds = allTime % 3600 % 60
        secondsText = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        return "\(hoursText):\(minutesText):\(secondsText)"
    }
    
    @IBAction func play(_ sender: UIButton) {
        if player!.rate == 0 {
            player!.play()
            sender.setImage(UIImage(named: "stop"), for: .normal)
        } else {
            player!.pause()
            sender.setImage(UIImage(named: "open"), for: .normal)
        }
    }
    
    
    @IBAction func upper(_ sender: UIButton) {
        if pos! != 0 {
            pos = pos! - 1
        } else {
            UIAlertController.showAlert("已经是第一首啦！", in: self)
        }
        initPlay()
    }
    
    
    @IBAction func next(_ sender: UIButton) {
        if pos! < plays!.count - 1{
            pos  = pos! + 1
        } else {
            UIAlertController.showAlert("已经是最后一首啦！", in: self)
        }
        initPlay()
    }
    
    
    @IBAction func dragSlider(_ sender: UISlider) {
        let seconds = Int64(slider.value)
        let targetTime = CMTimeMake(value: seconds, timescale: 1)
        player!.seek(to: targetTime)
        if player!.rate == 0 {
            player!.play()
            btnPlay.setImage(UIImage(named: "stop"), for: .normal)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
