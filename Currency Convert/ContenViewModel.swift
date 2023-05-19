//
//  ContenViewModel.swift
//  Currency Convert
//
//  Created by Armando Maldonado Romo on 19/05/23.
//

import Foundation


final class DivisasViewModel: ObservableObject {
    
    init(){
    }
    
    @Published var divisa: Convert = Convert.init(success: false, timestamp: 0, base: "", date: "", rates: Rates.init(usd: 0.0, eur: 0.0, gbp: 0.0, cad: 0.0, mxn: 0.0))
    @Published var show: Bool = false
    @Published var moneda:  Moneda = Moneda.init(date: "", info: Info.init(rate: 0.0, timestamp: 0), query: Query.init(amount: 0, from: "", to: ""), result: 0.0, success: false)
    
    func getDivisas() {
        self.show = true
        var base = "https://api.apilayer.com/fixer/latest?base=HNL&symbols=USD,EUR,GBP,CAD,MXN";
        let urlSession = URLSession.shared
        var request = URLRequest(url: URL(string: base)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("eVo2DKcPkb7whP4hog8RwkXc9NNIuGfg", forHTTPHeaderField: "apikey")
        request.httpMethod = "GET"
     
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                print("Error")
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                   let datos = try!  JSONDecoder().decode(Convert.self, from: data)
                print("datos: \(datos)")
                DispatchQueue.main.async {
                    print("si")
                    print("datos: \(datos)")
                    self.divisa = datos
                    
                    self.show = false

                   
                }
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                DispatchQueue.main.async {
                    self.show = false

                    print("Error: \(data)")
                    print(String(data: data, encoding: .utf8)!)
                }
            }
        }.resume()
    }
    
    func getMoneda( valor : String) {
        self.show = true
        
        let base = "https://api.apilayer.com/fixer/convert?to=JPY&from=HNL&amount=\(valor)"
        let urlSession = URLSession.shared
        var request = URLRequest(url: URL(string: base)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("eVo2DKcPkb7whP4hog8RwkXc9NNIuGfg", forHTTPHeaderField: "apikey")
        request.httpMethod = "GET"
     
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                print("Error")
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                   let datos = try!  JSONDecoder().decode(Moneda.self, from: data)
                print("datos: \(datos)")
                DispatchQueue.main.async {
                    print("si")
                    print("datos: \(datos)")
                    self.moneda = datos
                    
                    self.show = false

                   
                }
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                DispatchQueue.main.async {
                    self.show = false

                    print("Error: \(data)")
                    print(String(data: data, encoding: .utf8)!)
                }
            }
        }.resume()
    }
    
    
}
