//
//  RequestFetcher.swift
//  hbo-app
//
//  Created by Aravinda Rathnayake on 2/5/20.
//  Copyright © 2020 Aravinda Rathnayake. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class RequestFetcher {
    var searchResults = [JSON]()
    
    public func search(searchText: String, completionHandler: @escaping ([JSON]?, NetworkStatus) -> ()) {
        let urlToSearch = "https://www.omdbapi.com/?apikey=c24b2a95&s=\(searchText)&type=movie&page=1"
        
        Alamofire.request(urlToSearch).responseJSON { response in
            guard let data = response.data else {
                completionHandler(nil, .failure)
                return
            }
            
            let json = try? JSON(data: data)
            
            if json?["Response"] == "True" {
                let results = json?["Search"].arrayValue
                completionHandler(results, .success)
            } else {
                completionHandler(nil, .failure)
            }
        }
    }
    
    public func fetchImage(url: String, completionHandler: @escaping (UIImage?, NetworkStatus) -> ()) {
        Alamofire.request(url).responseData { responseData in
            
            guard let imageData = responseData.data else {
                completionHandler(nil, .failure)
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                completionHandler(nil, .failure)
                return
            }
            
            completionHandler(image, .success)
        }
    }
}
