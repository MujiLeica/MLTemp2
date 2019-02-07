//
//  BirdDataTableViewController.swift
//  MLTemp2
//
//  Created by CHONG LIU on 25/1/19.
//  Copyright © 2019 CHONG LIU. All rights reserved.
//

import UIKit

var birdSpecies = ["Australian King Parrot", "Australian Magpie", "Australian Raven", "Eastern Koel", "Myna", "Crested Pigeon", "Crimson Rosella", "Eastern Spinebill", "Eastern Yellow Robin", "Galah", "Grey Butcherbird", "Grey Fantail", "House Sparrow", "Laughing Kookaburra", "Little Wattlebird", "Magpie-lark", "New Holland Honeyeater", "Noisy Miner", "Pied Currawong", "Rainbow Lorikeet", "Red Wattlebird", "Red-Browed Finch", "Red-whiskered Bulbul", "Silvereye", "Spotted Pardalote", "Spotted Turtle Dove", "Sulphur-crested Cockatoo", "Superb Fairy-wren", "Willie Wagtail", "Yellow-tailed Black-Cockatoo"]

var birdDataURL = ["Alisterus-scapularis", "Cracticus-tibicen", "Corvus-coronoides", "Eudynamys-orientalis", "Sturnus-tristis", "Ocyphaps-lophotes", "Platycercus-elegans", "Acanthorhynchus-tenuirostris", "Eopsaltria-australis", "Eolophus-roseicapillus", "Cracticus-torquatus", "Rhipidura-albiscapa", "Passer-domesticus", "Dacelo-novaeguineae", "Anthochaera-chrysoptera", "Grallina-cyanoleuca", "Phylidonyris-novaehollandiae", "Manorina-melanocephala", "Strepera-graculina", "Trichoglossus-haematodus", "Anthochaera-carunculata", "Neochmia-temporalis", "Pycnonotus-jocosus", "Zosterops-lateralis", "Pardalotus-punctatus", "Streptopelia-chinensis", "Cacatua-galerita", "Malurus-cyaneus", "Rhipidura-leucophrys", "Calyptorhynchus-funereus"]

var myIndex = 0

class BirdDataTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Bird Species"
        navigationController?.navigationBar.prefersLargeTitles = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return birdSpecies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath) as! SampleCellTableViewCell
        
        cell.nameLabel.text = birdSpecies[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: birdSpecies[indexPath.row] + ".jpg")
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "webSegue", sender: self)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
