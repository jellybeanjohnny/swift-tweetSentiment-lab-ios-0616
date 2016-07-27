//
//  DataStore.swift
//  swift-tweetSentiment-lab
//
//  Created by Matt Amerige on 7/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class DataStore {
  
  static let sharedDataStore = DataStore()
  
  var polarities: [Int] = []
  let serialQueue = dispatch_queue_create("mySerialQueue", DISPATCH_QUEUE_SERIAL)
  
  func averagePolarityScoreForSearchTerm(term: String, completion: Int -> Void) {
    
    TwitterAPIClient.fetchTweetsForSearchTerm(term) { (tweetsDictionaries) in
      let downloadGroup = dispatch_group_create()
      for tweetDictionary in tweetsDictionaries {
        dispatch_group_enter(downloadGroup)
        let text = tweetDictionary["text"] as! String
        TweetSentimentAPIClient.getPolarityForTweetText(text, completion: { (polarity) in
          
          dispatch_group_async(downloadGroup, self.serialQueue) {
            self.polarities.append(polarity)
          }
          DataStore.sharedDataStore.polarities.append(polarity)
          dispatch_group_leave(downloadGroup)
          print(DataStore.sharedDataStore.polarities)
        })
      }
      
      dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), {
        
        print("done")
        
        let average = self.calculateAverage(DataStore.sharedDataStore.polarities)
        
        completion(average)
      })
    }
  }
  
  
  func calculateAverage(array: [Int]) -> Int  {
    var sum = 0
    for number in array {
      sum += number
    }
    return sum / array.count
  }
  
}

