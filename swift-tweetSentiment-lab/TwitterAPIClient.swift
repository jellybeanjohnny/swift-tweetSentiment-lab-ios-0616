//
//  TwitterApiClient.swift
//  swift-tweetSentiment-lab
//
//  Created by Matt Amerige on 7/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import STTwitter

struct TwitterAPIClient {
  
  static func fetchTweetsForSearchTerm(seachTerm: String, completion: [NSDictionary] -> Void) {
      let twitter = STTwitterAPI(appOnlyWithConsumerKey: PrivateKeys.twitterConsumerKey, consumerSecret: PrivateKeys.twitterConsumerSecret)
      twitter.verifyCredentialsWithUserSuccessBlock({ (username, password) in
        
        twitter.getSearchTweetsWithQuery(seachTerm, successBlock: { (searchMetadata, results) in
          
          let resultsArray = results as! [NSDictionary]
          
          print("Successfully fetched tweets")
          completion(resultsArray)
          
          }, errorBlock: { (error) in
            print("Error getting tweets")
        })
        
        print("credentials verified")
        }) { (error) in
          print("error verifying credentials")
      }
  }
  
  // For the tests
  
  static func getAveragePolarityOfTweetsFromQuery(searchTerm: String, completion: String -> Void) {
    
    DataStore.sharedDataStore.averagePolarityScoreForSearchTerm(searchTerm) { (polarity) in
      completion("\(polarity)")
    }
    
  }
  
  
  
  
  
  
  
  
  
  
}