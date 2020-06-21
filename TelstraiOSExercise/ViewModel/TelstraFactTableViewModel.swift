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
            guard let title = factArray?.title else {
                return
            }
            self.responder.updateTelstraTitle(title)
            guard let rows = factArray?.rows else {
                return
            }
            self.responder.updateTelstraFactList(rows)
        }
        
    }
}



