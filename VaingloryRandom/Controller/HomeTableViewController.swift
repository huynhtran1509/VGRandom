//
//  HomeTableViewController.swift
//  VaingloryRandom
//
//  Created by Htain Lin Shwe on 31/12/15.
//  Copyright © 2015 comquas. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var currentGamers = [String]()
    var teamOne = [String]()
    var teamTwo = [String]()
    var spectator = [String]()
    var gamers = Gamers()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func randomNumberBySpector() -> Int {
        let rnd = arc4random_uniform(UInt32(spectator.count))
        return Int(rnd)
    }
    @IBAction func random() {
        spectator = gamers.enabledGamers()
        teamOne = [String]()
        teamTwo = [String]()
        let count:Double = Double(spectator.count)
        let perTeam = Int(ceil(count/2.00))
        var max = perTeam

        if perTeam > 3 {
            max = 3;
        }
        
        for _ in 0..<max {
            let r = randomNumberBySpector()
            teamOne.append(spectator[r])
            spectator.removeAtIndex(r)
        }
        
        max = spectator.count
        
        if spectator.count > 3 {
            max = 3
        }
        
        for _ in 0..<max {
            let r = randomNumberBySpector()
            teamTwo.append(spectator[r])
            spectator.removeAtIndex(r)
        }
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 0) {
            return teamOne.count
        }
        else if (section == 1) {
            return teamTwo.count
        }
        else if (section == 2) {
            return spectator.count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        var gamer:[String] = [String]()
        
        if indexPath.section == 0 {
            gamer = teamOne
        }
        else if indexPath.section == 1 {
            gamer = teamTwo
        }
        else if indexPath.section == 2 {
            gamer = spectator
        }
        
        cell.textLabel?.text = gamer[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Team 1"
        }
        else if (section == 1) {
            return "Team 2"
        }
        else if (section == 2) {
            return "Spectators"
        }
        return ""
    }
    

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
