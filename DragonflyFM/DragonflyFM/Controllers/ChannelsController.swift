//
//  ChannelsController.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
private let reuseIdentifier = "Cell"
import CoreData
class ChannelsController: UICollectionViewController,UISearchBarDelegate, EmptyViewDelegate,UITableViewDelegate,UITableViewDataSource{
    
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
   
    
    var channels :[VMChannels]?
    var regions:[VMRegions]?
    var currentPage = 1
    var isLoading = false
    var region = "广西"
    var button:UIButton?
    let factory = ChannelsFactory.getInstance(UIApplication.shared.delegate as! AppDelegate)
    let musicPlaySegu = "musicPlaySegu"

    override func viewDidLoad() {
        super.viewDidLoad()
        loadChennels(kw: 239)
        loadRegions()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: navigations), object: nil)
        collectionView.setEmtpyCollectionViewDelegate(target: self)
      
       
    }
    @objc func reload(){
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: musicPlaySegu, sender: indexPath.item)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == musicPlaySegu {
            let destinatons = segue.destination as! PlayListController
            if sender is Int {
                let channels = self.channels![sender as! Int]
                destinatons.haderTitle = channels.title
                destinatons.returnText = region
                destinatons.chennel = channels
            }
        }
    }
 

    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let hader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "serachHeader", for: indexPath) as! HeaderReusableView
        hader.seaechBar.delegate = self
        hader.btnRegions.addTarget(self, action: #selector(btnRegios(_:)), for: .touchUpInside)
        return hader
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         if let k = searchBar.text {
            channels = nil
            loadSearchChennels(kw: k)
        }
    }
    
    @objc func btnRegios(_ btn: UIButton) {
        picker = ActionTablePicker(title: "选择地区", count: regions!.count, dataSource: self , delegate: self).show(superView: self.view)
        button = btn
    }
    
    
    private var picker:ActionTablePicker?
    func itemSelectde(index: Int) {
       let regio = regions![index]
        region = regio.title!
        channels = nil
        loadSearchChennels(kw: regio.title!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let region = regions![indexPath.row]
        cell.textLabel?.text = region.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemSelectde(index: indexPath.row)
        button!.setTitle(region, for: .normal)
        if picker != nil {
            picker?.cancel()
        }
    }

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChannelsCell
        let channel = channels![indexPath.item]
        cell.lblName.text = channel.title
        cell.lblCount.text = channel.audienceCount!
        if channel.cover != nil {
            Alamofire.request(channel.cover!).responseImage{ response in
                if let imag = response.result.value {
                    cell.imgCover.image = imag
                }
            }
        } else {
            cell.imgCover.image = UIImage(named: "no")
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(starTab(_:)))
        cell.imgStar.isUserInteractionEnabled = true
        cell.imgStar.addGestureRecognizer(tap)
        cell.imgStar.tag = indexPath.item
        var star = "star_off"
        if (try! factory.isChannelsRxists(channels: channel) ?? false) {
            star = "star_on"
        }
        cell.imgStar.image = UIImage(named: star)
        return cell
    }
    
    @objc func starTab(_ tap:UITapGestureRecognizer) {
        if let pos = tap.view?.tag{
            let channel = channels![pos]
             let exists = (try? factory.isChannelsRxists(channels: channel)) ?? false
            if exists {
                let (success, error) = try! factory.removeChannels(channels: channel)
                if !success {
                     UIAlertController.showAlert(error!, in: self)
                }
            }else {
                let (success,_) = factory.addChannels(channels: channel)
                if success {
//                    collectionView.reloadData()
                }
            }
        }
    }
    
    
    func loadChennels(kw:Int32) {
        Alamofire.request(ChannelsJson.getSearchUrl(id: kw, page: currentPage))
            .validate(statusCode: 200..<300)
            .validate(contentType:  ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let json = response.result.value {
                        let chenn = ChennelsConverter.getChennels(json: json)
                        if chenn == nil || chenn!.count == 0 {
                            self.isLoading = true
                        } else {
                            if self.channels == nil {
                                self.channels = chenn
                            } else {
                                self.channels! += chenn!
                            }
                            self.collectionView.reloadData()
                            self.isLoading = false
                        }
                    } else {
                        self.isLoading = true
                    
                    }
                case let .failure(error):
                UIAlertController.showAlert("网络错误：\(error.localizedDescription)", in: self)
                        self.isLoading = true
            }
        }
    }
    
    func loadRegions(){
        Alamofire.request(RegionsJson.getSearchUrl())
            .validate(statusCode: 200..<300)
            .validate(contentType:  ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let json = response.result.value {
                        let regions = RegionsConverter.getRegions(json: json)
                        if regions == nil || regions!.count == 0 {
                            self.isLoading = true
                        } else {
                            if self.regions == nil {
                                self.regions = regions
                            } else {
                                self.regions! += regions!
                            }
                            self.collectionView.reloadData()
                            self.isLoading = false
                        }
                    } else {
                        self.isLoading = true
                        
                    }
                case let .failure(error):
                    UIAlertController.showAlert("网络错误：\(error.localizedDescription)", in: self)
                    self.isLoading = true
                }
        }
    }
    
    func loadSearchChennels(kw:String) {
        Alamofire.request(ChannelsJson.getStarSearchUrl(kw: kw))
            .validate(statusCode: 200..<300)
            .validate(contentType:  ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let json = response.result.value {
                        let chenn = ChennelsConverter.getChennel(json: json)
                        if chenn == nil || chenn!.count == 0 {
                            self.isLoading = true
                        } else {
                            if self.channels == nil {
                                self.channels = chenn
                            } else {
                                self.channels! += chenn!
                            }
                            self.collectionView.reloadData()
                            self.isLoading = false
                        }
                    } else {
                        self.isLoading = true
                        
                    }
                case let .failure(error):
                    UIAlertController.showAlert("网络错误：\(error.localizedDescription)", in: self)
                    self.isLoading = true
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
 
}
