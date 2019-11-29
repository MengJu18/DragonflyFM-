//
//  PlayListController.swift
//  DragonflyFM
//
//  Created by 2017yd on 2019/11/23.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import Alamofire
import AlamofireImage
import UIKit

class PlayListController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnReturn: UIButton!
    @IBOutlet weak var lblTitle: UILabel!

    
    var chennel:VMChannels?
    var haderTitle:String?
    var returnText:String?
    var playbills:[VMPlaybills]?
    let playbillsCell = "playbillsCell"
    let musicSegu = "musicSegu"
    var pos = 100
    var index = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooks(kw: chennel!.contentId!)
        btnReturn.setTitle(returnText, for: .normal)
        lblTitle.text = haderTitle
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnReturn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  playbills?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: playbillsCell, for: indexPath) as! PlayListCell
        let playbill = playbills![indexPath.item]
        cell.lblTitle.text = playbill.title
        if playbill.username == "" {
            cell.lblUserName.text = "未知"
        } else {
            cell.lblUserName.text = playbill.username
        }
        cell.lblCount.text = "0"
        cell.lblTime.text = "[" + playbill.starItme! + "-" + playbill.endTime! + "]"
        if playbill.title == chennel?.nowplaying && playbill.starItme == chennel?.startTime{
            cell.imgCover.image = UIImage(named: "play")
            cell.lblTitle.textColor = UIColor.blue
            pos = indexPath.item
        } else if indexPath.item > pos{
            cell.imgCover.image = UIImage(named: "time")
            cell.lblTitle.textColor = UIColor.black
        }else if playbill.title != chennel?.nowplaying && playbill.starItme != chennel?.startTime{
            cell.imgCover.image = UIImage(named: "big")
            cell.lblTitle.textColor = UIColor.black
        }
        if indexPath.item == index {
            cell.imgCover.image = UIImage(named: "listen")
            cell.lblTitle.textColor = UIColor.red
        }
        return cell
    }
    
    func loadBooks(kw: Int32){
        Alamofire.request(PlaybillsJson.getSearchUrl(id: kw))
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let json = response.result.value {
                        let playbill = PlaybillsConverter.getPlaybills(json: json)
                        if playbill != nil || playbill!.count != 0 {
                            if self.playbills == nil {
                                self.playbills = playbill
                            } else {
                                self.playbills! += playbill!
                            }
                            self.tableView.reloadData()
                        }
                    }
                case let .failure(error):
                    UIAlertController.showAlert("网络错误：\(error.localizedDescription)", in: self)
                }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.item
        tableView.reloadData()
        performSegue(withIdentifier: musicSegu, sender: indexPath.item)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == musicSegu {
            let destinations = segue.destination as! PlayController
            if sender is Int {
                destinations.cover = chennel!.cover
                destinations.play = playbills![sender as! Int]
                destinations.haderTitle = haderTitle
                destinations.plays = playbills
                destinations.pos = (sender as! Int)
            }
        }
    }

}
