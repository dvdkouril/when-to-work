//
//  TimeFragment.swift
//  when-to-work
//
//  Created by David Kouril on 03/06/2017.
//  Copyright © 2017 David Kouřil. All rights reserved.
//

import Foundation

class TimeFragment : Equatable, CustomStringConvertible, CustomDebugStringConvertible {
    
    let timeStamp : String
    var activities : [(String, Int, Int)]
    
    init(timeStamp : String) {
        self.timeStamp = timeStamp
        activities = [(String, Int, Int)]()
    }
    
    func add(activity: String, withTime time: Int, withScore score: Int) {
        activities.append((activity, time, score))
    }
    
    var description: String {
        var retString = "TimeFragment \(timeStamp), activities: "
        
        for (activity, time, productivity) in activities {
            retString += " (\(activity), \(time) s, \(productivity))"
        }
        
        return retString
    }
    
    var debugDescription: String {
        var retString = "TimeFragment \(timeStamp), activities: "
        
        for (activity, time, productivity) in activities {
            retString += " (\(activity), \(time) s, \(productivity))"
        }
        
        return retString
    }
    
    func weightedAverageOfActivities() -> Double {
        var sum : Int = 0
        var sumWeights : Int = 0
        
        for (_, time, productivity) in activities {
            sum += productivity * time
            sumWeights += time
        }
        
        return Double(sum) / Double(sumWeights)
    }
}

func ==(lhs: TimeFragment, rhs: TimeFragment) -> Bool {
    return lhs.timeStamp == rhs.timeStamp
}
