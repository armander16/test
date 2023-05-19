//
//  ContentView.swift
//  Currency Convert
//
//  Created by Armando Maldonado Romo on 19/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject  var apiservice: DivisasViewModel = DivisasViewModel()
    @State private var valor: String = ""


    var body: some View {
        
        ZStack(){
            if( apiservice.show == true){
                ProgressView()
            } else {
                
                
                VStack {
                    Text("Currency Converter")
                 
                    Text( " USD:\(String((apiservice.divisa.rates?.usd)!))")
                        .padding()
                    Text( " EUR:\(String((apiservice.divisa.rates?.eur)!))")
                        .padding()
                    Text( " GBP:\(String((apiservice.divisa.rates?.gbp)!))")
                        .padding()

                    Text( " CAD:\(String((apiservice.divisa.rates?.cad)!))")
                        .padding()

                    Text( " MXN:\(String((apiservice.divisa.rates?.mxn)!))")
                        .padding()

                    TextField ("HNL convert", text: $valor)
                        .padding()

                    
                    Text( " JPY:\(String((apiservice.moneda.result)!))")
                        .padding()
                    
                    Button(action: {
                        apiservice.getMoneda(valor: valor.self)
                    }) {
                        Text("Convert JPY")
                    }
                    .padding()
                    
                    
                    Button(action: {
                        apiservice.getDivisas()
                    }) {
                        Text("Get Rates")
                    }
                    .padding()
            
                }
                
                
                
            }
           
            
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
