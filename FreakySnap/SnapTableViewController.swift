//
//  SnapTableViewController.swift
//  FreakySnap
//
//  Created by Alexander Kotik on 09.08.17.
//  Copyright © 2017 Alexander Kotik. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SnapTableViewController: UITableViewController {

    var snapItems :[SnapItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = Auth.auth().currentUser?.uid {
        
        Database.database().reference().child("users").child(id).child("snaps").observe(.childAdded) { (snapshot) in
            if let userdictionary = snapshot.value as? NSDictionary {
                let snapItem : SnapItem = SnapItem()
                if let from = userdictionary["from"] as? String {
                    snapItem.from = from
                    
                }
                if let imageUrl = userdictionary["imageUrl"] as? String {
                    snapItem.imageUrl = imageUrl
                    
                }
                
                if let imageName = userdictionary["imageName"] as? String {
                    snapItem.imageName = imageName
                    
                }
                
                if let message = userdictionary["message"] as? String {
                    snapItem.message = message
                    
                }
                snapItem.key = snapshot.key
                self.snapItems.append(snapItem)
                self.tableView.reloadData()
            }
            }
        
        
        Database.database().reference().child("users").child(id).child("snaps").observe(.childRemoved) { (snapshot) in
            var index = 0
            for snap in self.snapItems {
                if snap.key == snapshot.key {
                    self.snapItems.remove(at: index)
                }
                index += 1
            }
            self.tableView.reloadData()
            }
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return snapItems.count
    }

    @IBAction func logouTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mySnaps", for: indexPath)

        cell.textLabel?.text = snapItems[indexPath.row].from
        cell.detailTextLabel?.text = snapItems[indexPath.row].message
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = snapItems[indexPath.row]
        performSegue(withIdentifier: "viewDetails", sender: item)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController {
            if let snapItem = sender as? SnapItem {
                vc.snapItem = snapItem
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
