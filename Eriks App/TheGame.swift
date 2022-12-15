//
//  ViewController.swift
//  Eriks App
//
//  Created by Wyatt Bodle on 12/13/22.
//

import UIKit
import FirebaseDatabase


class TheGame: UIViewController {
    //Button connections
    @IBOutlet weak var leftCroner1: UIButton!
    @IBOutlet weak var leftCorner2: UIButton!
    @IBOutlet weak var leftMiddle1: UIButton!
    @IBOutlet weak var leftMiddle2: UIButton!
    @IBOutlet weak var middle1: UIButton!
    @IBOutlet weak var middle2: UIButton!
    @IBOutlet weak var rightCroner1: UIButton!
    @IBOutlet weak var rightCorner2: UIButton!
    @IBOutlet weak var rightMiddle1: UIButton!
    @IBOutlet weak var rightMiddle2: UIButton!
    //Label Connection
    @IBOutlet weak var sumbitButton: UIButton!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    //Array that holds the index at which the starting and ending shots were
    var shotArray = [Int]()
    //Sets public variables
    var ErikthreePointCount = 0
    var EriktotalWins = 0
    var ErikthisGameWins = 0
    var WyattthreePointCount = 0
    var WyatttotalWins = 0
    var WyattthisGameWins = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //When view did appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
        getData()
    }
    
   
    
    //Sets up the scene every time the view loads
    func setup() {
        //Sets the starting text
        text.text = "Erik Start Point"
        //Sets all the buttons back to black
        leftCroner1.configuration?.baseForegroundColor = UIColor.black
        leftCorner2.configuration?.baseForegroundColor = UIColor.black
        leftMiddle1.configuration?.baseForegroundColor = UIColor.black
        leftMiddle2.configuration?.baseForegroundColor = UIColor.black
        middle1.configuration?.baseForegroundColor = UIColor.black
        middle2.configuration?.baseForegroundColor = UIColor.black
        rightCroner1.configuration?.baseForegroundColor = UIColor.black
        rightCorner2.configuration?.baseForegroundColor = UIColor.black
        rightMiddle1.configuration?.baseForegroundColor = UIColor.black
        rightMiddle2.configuration?.baseForegroundColor = UIColor.black
        //Reset Array
        shotArray.removeAll()
        //Unhide submit and show the start text
        sumbitButton.isHidden = true
        text.isHidden = false
        clearButton.isHidden = true
        
    }
    
    //When a button is pressed this function sets the data and passes in the button that was pressed
    var erikAtZero = Bool()
    func buttonPressed (button: UIButton, index: Int, index2: Int){
        //Sets the variables

        //Checks the point we are at and assigns colors and data
        if(text.text == "Erik Start Point" || text.text == "Incorrect Start Point"){
            button.configuration?.baseForegroundColor = UIColor.systemGreen
            //Sets the first value of the array
            if(index == 0 || index2 == 0){
                //Checks who started on which side
                if(index == 0){
                    erikAtZero = true
                }else{
                    erikAtZero = false
                }
                //Sets the index based on where erik starts
                if(erikAtZero){
                    shotArray.append(index)
                    
                }else{
                    shotArray.append(index2)
                }
                text.text = "Wyatt Start Point"
                
            }else{
                setup()
                text.text = "Incorrect Start Point"
            }
            
        }else if(text.text == "Wyatt Start Point"){
            button.configuration?.baseForegroundColor = UIColor.systemBlue
            if(index == 0 || index2 == 0){
                if(erikAtZero){
                    shotArray.append(index2)
                    
                }else{
                    shotArray.append(index)
                }
                text.text = "Erik End Point"
            }else{
                setup()
                text.text = "Incorrect Start Point"
            }
            
        }else if(text.text == "Erik End Point"){
            button.configuration?.baseForegroundColor = UIColor.systemGreen
            if(erikAtZero){
                shotArray.append(index)
                
            }else{
                shotArray.append(index2)
                }
            text.text = "Wyatt End Point"
        }else if(text.text == "Wyatt End Point"){
            button.configuration?.baseForegroundColor = UIColor.systemBlue
            if(erikAtZero){
                shotArray.append(index2)
                
            }else{
                shotArray.append(index)
                }
            let erikScore = shotArray[2] + 1
            let wyattScore = shotArray[3] + 1
            if(erikScore > wyattScore){
                
                text.text = "Erik Won \(erikScore) - \(wyattScore)"
            }else if(erikScore != wyattScore){
                text.text = "Erik Lost \(wyattScore) - \(erikScore)"
            }else {
                text.text = "Tie"
            }
            sumbitButton.isHidden = false
            clearButton.isHidden = false

        }else {
            setup()
            text.text = "Incorrect Start Point"
            print("Error")
        }
        print(shotArray)
    }
        //Button Presses
    @IBAction func leftCorner1(_ sender: Any) {
        buttonPressed(button: leftCroner1, index : 0, index2 : 4)
    }
    
    //2nd Shot
    @IBAction func leftCorner2(_ sender: Any){
        buttonPressed(button: leftCorner2, index : 9, index2 : 5)
        
    }
    //3rd shot
    @IBAction func leftMiddle1(_ sender: Any){
        buttonPressed(button: leftMiddle1, index : 1, index2 : 2)
    }
    //4thnshot
    @IBAction func leftMiddle2(_ sender: Any){
        buttonPressed(button: leftMiddle2, index : 8, index2 : 6)
    }
    //5th shot
    @IBAction func middle1(_ sender: Any){
        buttonPressed(button: middle1, index : 2, index2 : 2)
    }
    //6th shot
    @IBAction func middle2(_ sender: Any){
        buttonPressed(button: middle2, index : 7, index2 : 7)
    }
    //7th shot
    @IBAction func rightMiddle1(_ sender: Any){
        buttonPressed(button: rightCroner1, index : 3, index2 : 1)
    }
    //8th shot
    @IBAction func rightMiddle2(_ sender: Any){
        buttonPressed(button: rightCorner2, index : 6, index2 : 8)
    }
    //9th shot
    @IBAction func rightCorner1(_ sender: Any){
        buttonPressed(button: rightMiddle1, index : 4, index2 : 0)

    }
    //10th shot
    @IBAction func rightCorner2(_ sender: Any){
        buttonPressed(button: rightMiddle2, index : 5, index2 : 9)

    }
    
    //When submit is pressed hanndle that
    @IBAction func submitPressed(_ sender: Any) {
        let erikScore = shotArray[2] + 1
        let wyattScore = shotArray[3] + 1
        //Sets our data
        getData()
        saveData(erikScore: erikScore, wyattScore: wyattScore, gameType: "\"The Game\"")
        //Unwind Segue
        self.performSegue(withIdentifier: "unwindSend", sender: self)
    }
    
    
    @IBAction func clearPressed(_ sender: Any) {
        setup()
    }
}

