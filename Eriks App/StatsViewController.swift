//
//  ViewController.swift
//  Eriks App
//
//  Created by Wyatt Bodle on 12/13/22.
//

import UIKit

class StatsViewController: UIViewController {
    
    //Erik Stat Connections
    @IBOutlet weak var mainScoreLabel: UILabel!
    
    @IBOutlet weak var theGameStatLabel: UILabel!
    
    @IBOutlet weak var freeThrowStatLabel: UILabel!
    
    @IBOutlet weak var oneVOneStatLabel: UILabel!
    
    @IBOutlet weak var threePointStatLabel: UILabel!
    
    @IBOutlet weak var totalThreePointStatLabel: UILabel!
    
    @IBOutlet weak var freeThrowTotalStatLabel: UILabel!
    
    //Wyatt Stat Connections
    @IBOutlet weak var wyattMainScoreLabel: UILabel!
    
    @IBOutlet weak var wyattTheGameStatLabel: UILabel!

    @IBOutlet weak var wyattFreeThrowStatLabel: UILabel!

    @IBOutlet weak var wyattOneVOneStatLabel: UILabel!

    @IBOutlet weak var wyattThreePointStatLabel: UILabel!

    @IBOutlet weak var wyattTotalThreePointStatLabel: UILabel!

    @IBOutlet weak var wyattFreeThrowTotalStatLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //When view did appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
    
    func setup(){
        // Do any additional setup after loading the view.
        //Total wins
        mainScoreLabel.text = "\(totalWinsErik)"
        wyattMainScoreLabel.text = "\(totalWinsWyatt)"
        //This Game wins
        theGameStatLabel.text = "\(totalTheGameWinsErik)"
        wyattTheGameStatLabel.text = "\(totalTheGameWinsWyatt)"
        //Total three pointers
        totalThreePointStatLabel.text = "\(total3PointersErik)"
        wyattTotalThreePointStatLabel.text = "\(total3PointersWyatt)"
        //Free Throw wins
        freeThrowStatLabel.text = "\(totalFreeThrowWinsErik)"
        wyattFreeThrowStatLabel.text = "\(totalFreeThrowWinsWyatt)"
        //total free throws
        freeThrowTotalStatLabel.text = "\(totalFreeThrowsErik)"
        wyattFreeThrowTotalStatLabel.text = "\(totalFreeThrowsWyatt)"
        //1v1 Stats
        oneVOneStatLabel.text = "\(oneVOneWinsErik)"
        wyattOneVOneStatLabel.text = "\(oneVOneWinsWyatt)"

    }
    


}

