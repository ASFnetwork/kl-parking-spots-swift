//
//  TableViewController.swift
//  kl-parking-spots-swift
//
//  Created by Mohammad Nurdin bin Norazan on 6/23/15.
//  Copyright (c) 2015 Nurdin Norazan Services. All rights reserved.
//

import UIKit
import Alamofire
import Toucan

class TableViewController: UITableViewController {

    var timer = NSTimer()
    var spots: [JSON] = []
    var thumbils : [String] = ["Sungei_Wang_Plaza.png","Plaza_Low_Yat.png","Lot_10.png","Fahrenheit88.png","Starhill_Gallery.png","Pavilion.png","KLCC.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        

        
        Alamofire.request(.GET, "https://kl-parking-spots.herokuapp.com").responseJSON { (request, response, json, error) in
            if json != nil {
                var jsonObj = JSON(json!)
                
                if let data = jsonObj.arrayValue as [JSON]?{
                    //println(data)
                    self.spots = data
                    self.tableView.reloadData()
                }

            }
        }

        self.scheduledTimerWithTimeInterval()
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function **Countdown** with the interval of 5 seconds
        timer = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: Selector("reload"), userInfo: nil, repeats: true)
    }
    
    func reload(){
        println("fire!!")
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return spots.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SpotCell", forIndexPath: indexPath) as! UITableViewCell //1
        let spot = spots[indexPath.row]
        
            if let nameLabel = cell.viewWithTag(100) as? UILabel {
                if let name = spot["name"].string{
                    nameLabel.text = name
                }
            }
            
            if let lotLabel = cell.viewWithTag(101) as? UILabel {
                if let hahahahaha = spot["lot"].int{
                    lotLabel.text = String(hahahahaha)
                }
            }
            
            if let datetimeLabel = cell.viewWithTag(102) as? UILabel {
                if let datetime = spot["datetime"].string{
                    datetimeLabel.text = datetime
                }
            }
        
            if let imageView = cell.viewWithTag(103) as? UIImageView {
                let image = UIImage(named: thumbils[indexPath.row])
                imageView.image = Toucan(image: image!).maskWithEllipse(borderWidth: 5, borderColor: UIColor.blackColor()).image
            }
        
        return cell

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
