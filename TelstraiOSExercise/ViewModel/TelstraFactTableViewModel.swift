//
//  TelstraFactTableViewModel.swift
//  TelstraiOSExercise
//
//  Created by Digvijay.digvijay on 6/20/20.
//  Copyright © 2020 Digvijay.digvijay. All rights reserved.
//

import Foundation

//MARK: -  RESPONDER TO UPDATE DATA ON TELSTRA VIEW CONTROLER
protocol TelstraViewResponder {
    func updateTelstraFactList(_ data: [TelstraFactData])
    func updateTelstraTitle(_ title: String)
}



// MARK: -  VIEW MODEL FOR TELSTRA VIEW CONTROLER
class TelstraFactTableViewModel {
    let responder: TelstraViewResponder
    init(responder: TelstraViewResponder) {
        self.responder = responder
    }
       /*
        @description: - Call netowork manager to get api response
        @return: -      Void
        */
    func loadTelstraData() {
        NetworkManager.networkManagerObj.getNetworkHandler(urlString: GET_TELSTRA_FACT ) { (factArray: TelstraFacts?, response: URLResponse?, error: Error?) in
            
            if let titile = factArray?.title {
                self.responder.updateTelstraTitle(titile)
            }
            if let rows = factArray?.rows{
                self.responder.updateTelstraFactList(rows)
            }
            
        }
    }
    
    
    /*
    @description: - Check network availability
    @return: -      Void
    */
    func isNetworkAvailable() -> Bool {
        if ConnectionCheck.isConnectedToNetwork() {
            return true
        }
        else{
            return false
        }
    }
    
}



