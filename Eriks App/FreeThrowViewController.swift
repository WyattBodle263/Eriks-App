//
//  ViewController.swift
//  Eriks App
//
//  Created by Wyatt Bodle on 12/13/22.
//

import UIKit
import FirebaseDatabase

class FreeThrowViewController: UIViewController {
    var erikScore = 0
    var wyattScore = 0
    var isTenShots = false
    //Erik switch connections
    @IBOutlet weak var shot1Erik: UISwitch!
    @IBOutlet weak var shot2Erik: UISwitch!
    @IBOutlet weak var shot3Erik: UISwitch!
    @IBOutlet weak var shot4Erik: UISwitch!
    @IBOutlet weak var shot5Erik: UISwitch!
    @IBOutlet weak var shot6Erik: UISwitch!
    @IBOutlet weak var shot7Erik: UISwitch!
    @IBOutlet weak var shot8Erik: UISwitch!
    @IBOutlet weak var shot9Erik: UISwitch!
    @IBOutlet weak var shot10Erik: UISwitch!

    //Wyatt switch connections
    @IBOutlet weak var shot1Wyatt: UISwitch!
    @IBOutlet weak var shot2Wyatt: UISwitch!
    @IBOutlet weak var shot3Wyatt: UISwitch!
    @IBOutlet weak var shot4Wyatt: UISwitch!
    @IBOutlet weak var shot5Wyatt: UISwitch!
    @IBOutlet weak var shot6Wyatt: UISwitch!
    @IBOutlet weak var shot7Wyatt: UISwitch!
    @IBOutlet weak var shot8Wyatt: UISwitch!
    @IBOutlet weak var shot9Wyatt: UISwitch!
    @IBOutlet weak var shot10Wyatt: UISwitch!


   //Label connections
    @IBOutlet weak var wyattScoreLabel: UILabel!
    @IBOutlet weak var erikScoreLabel: UILabel!
    @IBOutlet weak var shot6Label: UILabel!
    @IBOutlet weak var shot7Label: UILabel!
    @IBOutlet weak var shot8Label: UILabel!
    @IBOutlet weak var shot9Label: UILabel!
    @IBOutlet weak var shot10Label: UILabel!
    @IBOutlet weak var shot6LabelWyatt: UILabel!
    @IBOutlet weak var shot7LabelWyatt: UILabel!
    @IBOutlet weak var shot8LabelWyatt: UILabel!
    @IBOutlet weak var shot9LabelWyatt: UILabel!
    @IBOutlet weak var shot10LabelWyatt: UILabel!

    var gameCount = 0
    var ErikFreeThrowCount = 0
    var EriktotalWins = 0
    var ErikFreeThrowWins = 0
    var WyattFreeThrowCount = 0
    var WyatttotalWins = 0
    var WyattFreeThrowWins = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initalSetup()
        getData()
    }

    @IBAction func switchHit(_ sender: Any) {
     print("value changed")
        calculateScore()
    }
    func calculateScore(){
        erikScore = 0
        wyattScore = 0
        if(shot1Erik.isOn){
            erikScore += 1
        }
        if(shot2Erik.isOn){
            erikScore += 1
        }
        if(shot3Erik.isOn){
            erikScore += 1
        }
        if(shot4Erik.isOn){
            erikScore += 1
        }
        if(shot5Erik.isOn){
            erikScore += 1
        }
        if(shot1Wyatt.isOn){
            wyattScore += 1
        }
        if(shot2Wyatt.isOn){
            wyattScore += 1
        }
        if(shot3Wyatt.isOn){
            wyattScore += 1
        }
        if(shot4Wyatt.isOn){
            wyattScore += 1
        }
        if(shot5Wyatt.isOn){
            wyattScore += 1
        }
        if(isTenShots){
            if(shot6Erik.isOn){
                erikScore += 1
            }
            if(shot7Erik.isOn){
                erikScore += 1
            }
            if(shot8Erik.isOn){
                erikScore += 1
            }
            if(shot9Erik.isOn){
                erikScore += 1
            }
            if(shot10Erik.isOn){
                erikScore += 1
            }
            if(shot6Wyatt.isOn){
                wyattScore += 1
            }
            if(shot7Wyatt.isOn){
                wyattScore += 1
            }
            if(shot8Wyatt.isOn){
                wyattScore += 1
            }
            if(shot9Wyatt.isOn){
                wyattScore += 1
            }
            if(shot10Wyatt.isOn){
                wyattScore += 1
            }
        }
        wyattScoreLabel.text = "\(wyattScore)"
        erikScoreLabel.text = "\(erikScore)"
        
        
    }
    //Resets all the sliders and data
    func initalSetup () {
        //Unhide all data
        shot6Erik.isHidden = true
        shot6Label.isHidden = true
        shot7Erik.isHidden = true
        shot7Label.isHidden = true
        shot8Erik.isHidden = true
        shot8Label.isHidden = true
        shot9Erik.isHidden = true
        shot9Label.isHidden = true
        shot10Erik.isHidden = true
        shot10Label.isHidden = true
        //Unhide wyatt data
        shot6Wyatt.isHidden = true
        shot6LabelWyatt.isHidden = true
        shot7Wyatt.isHidden = true
        shot7LabelWyatt.isHidden = true
        shot8Wyatt.isHidden = true
        shot8LabelWyatt.isHidden = true
        shot9Wyatt.isHidden = true
        shot9LabelWyatt.isHidden = true
        shot10Wyatt.isHidden = true
        shot10LabelWyatt.isHidden = true
        //Sets the boolean to handle the 10 shots to true
        isTenShots = false
    }

    @IBAction func submitHit(_ sender: Any) {
        //if the game is tied show the next 5 shots
        if(erikScore == wyattScore){
            //Unhide all data
            shot6Erik.isHidden = false
            shot6Label.isHidden = false
            shot7Erik.isHidden = false
            shot7Label.isHidden = false
            shot8Erik.isHidden = false
            shot8Label.isHidden = false
            shot9Erik.isHidden = false
            shot9Label.isHidden = false
            shot10Erik.isHidden = false
            shot10Label.isHidden = false
            //Unhide wyatt data
            shot6Wyatt.isHidden = false
            shot6LabelWyatt.isHidden = false
            shot7Wyatt.isHidden = false
            shot7LabelWyatt.isHidden = false
            shot8Wyatt.isHidden = false
            shot8LabelWyatt.isHidden = false
            shot9Wyatt.isHidden = false
            shot9LabelWyatt.isHidden = false
            shot10Wyatt.isHidden = false
            shot10LabelWyatt.isHidden = false
            //Sets the boolean to handle the 10 shots to true
            isTenShots = true
        }else{
            getData()
            saveData(erikScore: erikScore, wyattScore: wyattScore, gameType: "Free Throws")
            //Unwind Segue
            self.performSegue(withIdentifier: "unwindSend2", sender: self)
        }
        
    }
   
}

