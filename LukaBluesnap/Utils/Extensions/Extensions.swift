//
//  Extensions.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

extension String {
  func replaceWithRegex(pattern: String, character: String) -> String {
    do {
      let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
      let range = NSMakeRange(0,self.count)
      return regex.stringByReplacingMatches(in: self, range: range, withTemplate: character)
    }catch let error {
      #if DEBUG
      print(error)
      #endif
      return self
    }
  }
}


