//
//  NetworkManager.swift
//  TelstraiOSExercise
//
//  Created by Digvijay.digvijay on 6/20/20.
//  Copyright © 2020 Digvijay.digvijay. All rights reserved.
//

import Foundation

//MARK: -  NETWORK MANAGER TO MANGER API CALLS
class NetworkManager: NSObject {
    static let networkManagerObj = NetworkManager()
    /*
       @description: - This method is for network call
       @parameter:- urlString: String
       completionHandler: taking parameter T, URLResponse,NSError
       @return: -      Void
       */
    func getNetworkHandler<T: Decodable>(urlString: String,completion: @escaping (T?, URLResponse?, Error?) -> ()) {
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url, completionHandler: {
                (data, response, error) in
                if(error != nil){
                    print("error")
                }else{
                    guard let data = data else { return }
                    let jsonString = String(decoding: data, as: UTF8.self)
                    do {
                        let utfData = Data(jsonString.utf8)
                        let dataReceived = try JSONDecoder().decode(T.self, from: utfData)
                         completion(dataReceived,response, error)
                        }catch let error as NSError{
                        print(error)
                    }
                }
            }).resume()
            
        }
    }
}
