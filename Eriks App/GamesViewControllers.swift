//
//  ViewController.swift
//  Eriks App
//
//  Created by Wyatt Bodle on 12/13/22.
//

import UIKit
import FirebaseDatabase



class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Defines the height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Array Count ", dateArray.count)
        return dateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! myCell
        let thisErikScore = erikScoreArray[indexPath.row]
        let thisWyattScore = wyattScoreArray[indexPath.row]
        let thisGameType = gameTypeArray[indexPath.row]
        let thisDate = dateArray[indexPath.row]
        if(thisErikScore > thisWyattScore){
            cell.winImage?.text = "E"
            cell.winImage?.textColor = UIColor.systemGreen
            cell.scoreLabel?.text = "\(thisErikScore) - \(thisWyattScore)"
        }else if(thisWyattScore > thisErikScore){
            cell.winImage?.text = "W"
            cell.winImage?.textColor = UIColor.systemTeal
            cell.scoreLabel?.text = "\(thisWyattScore) - \(thisErikScore)"
        }
        cell.dateLabel?.text = thisDate
        cell.gameTypeLabel?.text = thisGameType
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    
    let refreshControl = UIRefreshControl()
    
    //Connections
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tableView.addSubview(refreshControl) // not required when using UITableViewController
        fetchSheets()
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        loadData()
        fetchSheets()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
        getData()
        tableView.delegate = self
        tableView.dataSource = self
        fetchSheets()
    }
    //Gets data for cells
    func loadData (){
        
        // Making a reference
        let ref = Database.database().reference(withPath: "Games")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            // Printing the child count
            print("There are \(snapshot.childrenCount) children found")

            // Checking if the reference has some values
            if snapshot.childrenCount > 0 {

                // Go through every child
                for data in snapshot.children.allObjects as! [DataSnapshot] {
                    if let data = data.value as? [String: Any] {

                        // Retrieve the data per child


                        // Puts data in a datebase
                        let date = data["Date"] as? String
                        let eriksScore = data["Erik Score"] as? Int
                        let wyattScore = data["Wyatt Score"] as? Int
                        let gameType = data["Game Type"] as? String
                        if(dateArray.contains(date ?? "") && erikScoreArray.contains(eriksScore ?? 0)){
                            //Array already exists
                        }else {
                            dateArray.append(date ?? " ")
                            erikScoreArray.append(eriksScore ?? 0)
                            wyattScoreArray.append(wyattScore ?? 0)
                            gameTypeArray.append(gameType ?? " ")
                        }
                       

                        // Print the values for each child or do whatever you want
                        print(dateArray, erikScoreArray, wyattScoreArray, gameTypeArray)
                        
                        self.fetchSheets()
                        print("Fetching Sheets")
                    }
                }
            }
            self.refreshControl.endRefreshing()

        })
    }
    //Function to get the tableview to reload
    func fetchSheets() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

    //Unwind Segue
    //Anchor for unwind segue
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        print("Unwind to Main View Controller")
        loadData()
        fetchSheets()
    }
}

