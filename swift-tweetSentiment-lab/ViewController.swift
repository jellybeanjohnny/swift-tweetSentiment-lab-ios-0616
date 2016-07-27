//
//  ViewController.swift
//  swift-tweetSentiment-lab
//
//  Created by susan lovaglio on 7/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var polarityScoreLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    DataStore.sharedDataStore.averagePolarityScoreForSearchTerm("FlatironSchool") { average in
      
      print(average)
      dispatch_async(dispatch_get_main_queue(), { 
        self.polarityScoreLabel.text = "\(average)"
      })
      
    }
    
  }
}

