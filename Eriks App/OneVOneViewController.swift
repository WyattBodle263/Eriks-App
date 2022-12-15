//
//  ViewController.swift
//  Eriks App
//
//  Created by Wyatt Bodle on 12/13/22.
//

import UIKit

class OneVOneViewController: UIViewController {

    //Label connections
    @IBOutlet weak var wyattScoreLabel: UILabel!
    @IBOutlet weak var erikScoreLabel: UILabel!
    
    //Score Variable
    var erikScore = 0
    var wyattScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }

    @IBAction func erikStepper(_ sender: UIStepper) {
        erikScore = Int(sender.value)
        erikScoreLabel.text = String(erikScore)
    }
    
    @IBAction func wyattStepper(_ sender: UIStepper) {
        wyattScore = Int(sender.value)
        wyattScoreLabel.text = String(wyattScore)
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
        saveData(erikScore: erikScore, wyattScore: wyattScore, gameType: "1v1")
        self.performSegue(withIdentifier: "unwind1v1", sender: self)
    }
    
    
}

