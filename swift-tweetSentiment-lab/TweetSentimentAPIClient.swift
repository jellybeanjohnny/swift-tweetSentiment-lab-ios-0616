//
//  TweetSentimentAPIClient.swift
//  swift-tweetSentiment-lab
//
//  Created by Matt Amerige on 7/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

struct TweetSentimentAPIClient {
  
  static func getPolarityForTweetText(tweetText: String, completion: Int -> Void) {
    
    guard let URLEncodedText = tweetText.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet()) else { return }
    
    let URLString = "http://www.sentiment140.com/api/classify?appid=\(PrivateKeys.tweetSentimentAppID)&text=\(URLEncodedText)"
    
    guard let sentimentURL = NSURL(string: URLString) else { return }
    
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    let dataTask = session.dataTaskWithURL(sentimentURL) { (data, response, error) in
      
      guard let data = data else { return }
      
      do {
        let result = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
        
        if let info = result["results"], polarity = info["polarity"] as? Int {
          completion(polarity)
        }
      }
      catch {
        print(error)
      }
    }
    dataTask.resume()
  }
  
}