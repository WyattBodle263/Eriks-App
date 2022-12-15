//
//  ReusedFunctions.swift
//  Eriks App
//
//  Created by Wyatt Bodle on 12/14/22.
//

import Foundation
import FirebaseDatabase

public var totalWinsErik = 0
public var totalWinsWyatt = 0
public var totalTheGameWinsErik = 0
public var totalTheGameWinsWyatt = 0
public var oneVOneWinsErik = 0
public var oneVOneWinsWyatt = 0
public var total3PointersErik = 0
public var total3PointersWyatt = 0
public var totalFreeThrowWinsErik = 0
public var totalFreeThrowWinsWyatt = 0
public var totalFreeThrowsErik = 0
public var totalFreeThrowsWyatt = 0

public var dateArray = [String]()
public var erikScoreArray = [Int]()
public var wyattScoreArray = [Int]()
public var gameTypeArray = [String]()

//Gets our data and sets our variables for stats
func getData(){
    let refStats = Database.database().reference().child("Stats")
    //Gets the data from the firebase to be used in tableview
    // Making a reference
    //Saves the total games erik has won
    refStats.child("Erik Total Wins").observeSingleEvent(of: .value) { (snapshot) in
        let data = snapshot.value as? Int
        totalWinsErik = data ?? 0
    }
    //Saves the total games wyatt has won
    refStats.child("Wyatt Total Wins").observeSingleEvent(of: .value) { (snapshot) in
        let data = snapshot.value as? Int
        totalWinsWyatt = data ?? 0
    }
    //Saves the total of these games erik has won
    refStats.child("Erik Total \"This Game\" Wins").observeSingleEvent(of: .value) { (snapshot) in
        let data = snapshot.value as? Int
        totalTheGameWinsErik = data ?? 0
    }
    //Saves the total of these games wyatt has won
    refStats.child("Wyatt Total \"This Game\" Wins").observeSingleEvent(of: .value) { (snapshot) in
        let data = snapshot.value as? Int
        totalTheGameWinsWyatt = data ?? 0
    }
    //Saves the total of Erik Three Pointers
    refStats.child("Erik Total 3 Pointers").observeSingleEvent(of: .value) { (snapshot) in
        let data = snapshot.value as? Int
        total3PointersErik = data ?? 0
    }
    //Saves the total of Wyatt Three Pointers
    refStats.child("Wyatt Total 3 Pointers").observeSingleEvent(of: .value) { (snapshot) in
        let data = snapshot.value as? Int
        total3PointersWyatt = data ?? 0
    }
    //Saves the total of Erik Free Thow Wins
    refStats.child("Erik Total Free Throw Wins").observeSingleEvent(of: .value) { (snapshot) in
        let data = snapshot.value as? Int
        totalFreeThrowWinsErik = data ?? 0
    }
    //Saves the total of Erik Free Thow Wins
    refStats.child("Wyatt Total Free Throw Wins").observeSingleEvent(of: .value) { (snapshot) in
        let data = snapshot.value as? Int
        totalFreeThrowWinsWyatt = data ?? 0
    }
    //Saves the total of Erik Free Thows
    refStats.child("Erik Total Free Throws").observeSingleEvent(of: .value) { (snapshot) in
        let data = snapshot.value as? Int
        totalFreeThrowsErik = data ?? 0
    }
    //Saves the total of Wyatt Free Thows
    refStats.child("Wyatt Total Free Throws").observeSingleEvent(of: .value) { (snapshot) in
        let data = snapshot.value as? Int
        totalFreeThrowsWyatt = data ?? 0
    }
    //Saves the total 1v1 wins
    refStats.child("Erik 1v1 Wins").observeSingleEvent(of: .value) { (snapshot) in
        let data = snapshot.value as? Int
        oneVOneWinsErik = data ?? 0
    }
    //Saves the total 1v1 wins
    refStats.child("Wyatt 1v1 Wins").observeSingleEvent(of: .value) { (snapshot) in
        let data = snapshot.value as? Int
        oneVOneWinsWyatt = data ?? 0
    }
}
    
    
    //Saves our data
    func saveData(erikScore : Int, wyattScore : Int, gameType : String){
        let ref = Database.database().reference().child("Games").child("Game \(dateArray.count)")
        let refStats = Database.database().reference().child("Stats")
        //Creates a dictionary from it
        let scoreDictionary = ["Erik Score" : erikScore,
                               "Wyatt Score" : wyattScore, "Game Type" : gameType, "Date" : getTimeStampDateString()
        ] as [String : Any]
        
        if(erikScore > wyattScore){
            totalWinsErik += 1
            if(gameType.elementsEqual("\"The Game\"")){
                totalTheGameWinsErik += 1
                total3PointersErik += erikScore
                total3PointersWyatt += (wyattScore - 1)
            }else if(gameType.elementsEqual("Free Throws")){
                totalFreeThrowWinsErik += 1
                totalFreeThrowsErik += erikScore
                totalFreeThrowsWyatt += wyattScore
            }else if(gameType.elementsEqual("1v1")){
                oneVOneWinsErik += 1
            }
        }else if(erikScore < wyattScore){
            totalWinsWyatt += 1
            if(gameType.elementsEqual("\"The Game\"")){
                totalTheGameWinsWyatt += 1
                total3PointersErik += (erikScore - 1)
                total3PointersWyatt += wyattScore
            }else if(gameType.elementsEqual("Free Throws")){
                totalFreeThrowWinsWyatt += 1
                totalFreeThrowsErik += erikScore
                totalFreeThrowsWyatt += wyattScore
            }else if(gameType.elementsEqual("1v1")){
                oneVOneWinsWyatt += 1
            }
            
        }
        
        if (erikScore != wyattScore){
            let statDictoinary = ["Erik Total Wins" : totalWinsErik, "Wyatt Total Wins" : totalWinsWyatt, "Erik Total \"This Game\" Wins" : totalTheGameWinsErik, "Wyatt Total \"This Game\" Wins" : totalTheGameWinsWyatt, "Erik Total 3 Pointers" : total3PointersErik, "Wyatt Total 3 Pointers" : total3PointersWyatt, "Erik Total Free Throw Wins" : totalFreeThrowWinsErik, "Wyatt Total Free Throw Wins" : totalFreeThrowWinsWyatt, "Erik 1v1 Wins" : oneVOneWinsErik, "Wyatt 1v1 Wins" : oneVOneWinsWyatt, "Erik Total Free Throws" : totalFreeThrowsErik, "Wyatt Total Free Throws" : totalFreeThrowsWyatt]
            //Sets the message data
            ref.setValue(scoreDictionary, withCompletionBlock: { err, ref in
                if let error = err {
                    print("userInfoDictionary was not saved: \(error.localizedDescription)")
                } else {
                    print("userInfoDictionary saved successfully!")
                }
            })
            
            //Sets Stat data the message data
            refStats.setValue(statDictoinary, withCompletionBlock: { err, ref in
                if let error = err {
                    print("userInfoDictionary was not saved: \(error.localizedDescription)")
                } else {
                    print("userInfoDictionary saved successfully!")
                }
            })
            
        }
        
    }


//Gets the time that the message was sent in pacific time
func getTimeStampDateString() -> String {
    let date = Date(timeIntervalSinceNow: 0.0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "PST")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM/dd/yy h:mm a"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }


