//
//  APIClient.swift
//  MemeGenerator
//
//  Created by Flatiron School on 10/29/16.
//  Copyright © 2016 Susan Zheng. All rights reserved.
//

import Foundation

class APIClient
{
    
    
    var memesArray : [meme] = []
    
    func getMemeInfo(completion: @escaping (NSArray)->())
    {
        let urlString = "https://api.imgflip.com/get_memes"
        
        let url = URL(string: urlString)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? NSDictionary
                
                guard let dictionary = json else {return}
                
                let dataDictionary = dictionary["data"] as? NSDictionary
                
                guard let data = dataDictionary else {return}
                
                let memes = data["memes"] as? NSArray
                
                guard let memesArray = memes else {return}
                
                for theMemes in memesArray
                {
                    let memesVariables = meme.init(dictionary: theMemes as! NSDictionary)
                    self.memesArray.append(memesVariables)
                    completion(memesArray)
                }
                
            }
            catch
            {
                print("error")
            }
            
        }
        task.resume()
    }
}
