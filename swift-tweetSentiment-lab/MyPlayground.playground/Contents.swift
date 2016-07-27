//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"


let unescaped = "Going to campus is always rewarding @FlatironSchool you guys are the best! #LearnLoveCode https://t.co/VGipQWILTu"
let escapedString = unescaped.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
print("escapedString: \(escapedString)")