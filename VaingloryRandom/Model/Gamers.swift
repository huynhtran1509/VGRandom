//
//  Gamers.swift
//  VaingloryRandom
//
//  Created by Htain Lin Shwe on 7/1/16.
//  Copyright © 2016 comquas. All rights reserved.
//

import UIKit

var PEOPLE_LIST = "pplList"
var SELECTED_PEOPLE_LIST = "selectedPplList"

class Gamers: NSObject {

    let usrDefault = NSUserDefaults.standardUserDefaults()
    
    func enabledGamers()-> [String] {
        
        let ppl = currentGamers()
        let enableGamerArr = selectedGamers()
        
        var currentGammer = [String]()
        
        for k in 0..<ppl.count
        {
            if(enableGamerArr[k]) {
                currentGammer.append(ppl[k])
            }
        }
        
        return currentGammer
    }
    
    func currentGamers()-> [String] {
        
        guard let pplList = usrDefault.stringArrayForKey(PEOPLE_LIST) else {
            return [String]()
        }
        
        return pplList
        
    }
    
    func selectedGamers()-> [Bool] {
        
        guard let selected = usrDefault.objectForKey(SELECTED_PEOPLE_LIST) as? [Bool] else {
            return [Bool]()
        }

        return selected
        
    }
    
    

}
