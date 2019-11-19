//
//  StarChannelsController.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/19.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
private let reuseIdentifier = "ChannelsCell"

class StarChannelsController: UICollectionViewController,EmptyViewDelegate {
    var channels:[VMChannels]?
     let factory = ChannelsFactory.getInstance(UIApplication.shared.delegate as! AppDelegate)
    override func viewDidLoad() {
        super.viewDidLoad()
        channels = try! factory.getAllChannels()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return channels?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StarChannelsCell
        let chennel = channels![indexPath.item]
        cell.lblName.text = chennel.title
        cell.lblCount.text = chennel.audienceCount!
        Alamofire.request(chennel.cover!).responseImage{ response in
            if let imag = response.result.value {
                cell.imgCover.image = imag
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(starTab(_:)))
        cell.imgStar.isUserInteractionEnabled = true
        cell.imgStar.addGestureRecognizer(tap)
        cell.imgStar.tag = indexPath.item
        var star = "star_off"
        if (try! factory.isChannelsRxists(channels: chennel) ?? false) {
            star = "star_on"
        }
        cell.imgStar.image = UIImage(named: star)
       
    
        return cell
    }

    
    @objc func starTab(_ tap:UITapGestureRecognizer) {
        if let pos = tap.view?.tag{
            let chennel = channels![pos]
            let exists = (try? factory.isChannelsRxists(channels: chennel)) ?? false
            if exists {
                let (success, error) = try! factory.removeChannels(channels: chennel)
                if success {
                    collectionView.reloadData()
                }else {
                    UIAlertController.showAlert(error!, in: self)
                }
            }else {
                let (success,_) = factory.addChannels(channels: chennel)
                if success {
                    collectionView.reloadData()
                }
            }
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    var isEmpty: Bool{
        get{
            if let data  = channels {
                return data.count == 0
            }
            return true
        }
    }
    
    var imgEmpty:UIImageView?
    func createEmptyView() -> UIView? {
        if let empty = imgEmpty{
            return empty
        }
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        let batHeigHt = navigationController?.navigationBar.frame.height
        let img = UIImageView(frame: CGRect(x: (w-139)/2, y: (h-128)/2 - (batHeigHt ?? 0), width:139, height: 128))
        img.image = UIImage(named: "no_data")
        img.contentMode = .scaleAspectFit
        return img
    }
}
