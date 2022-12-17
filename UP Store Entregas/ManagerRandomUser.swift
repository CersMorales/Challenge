//
//  ManagerRandomUser.swift
//  UP Store Entregas
//
//  Created by Emanuel Morales on 16/12/22.
//  Copyright © 2022 ASNK. All rights reserved.
//

import Foundation
/*
protocol DelegadoRandomUser {
    func showUserRandom(lista: [userRandom])
}
struct userManager{
    var delegado :DelegadoRandomUser?
    func verUser(){
        let urlString = "https://randomuser.me/api/"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url) {datos, respuesta, error in
                if error != nil {
                    print("Error al obtener datos de la API", error?.localizedDescription as Any)
                }
                if let datosSeguros = datos?.parseData(quitarString: "null,"){
                    if let  listaUser = self.parsearJSON(datosUser: datosSeguros){
                        print("Datos de usuario", listaUser)

                    }
                }
            }
            
tarea.resume()
            
        }
      
    }
    func parsearJSON(datosUser: Data) -> [userRandom]? {
        let decodificador = JSONDecoder()
        do {
            let datosDecodificados = try decodificador.decode([userRandom]?.self, from: datosUser)
            return datosDecodificados
        } catch  {
            //print("Error al decodificar los datos :", error.localizedDescription)//
            print(String(describing: error))
            return nil
        }
    }
}
extension Data{
    func parseData(quitarString palabra: String) -> Data? {
        let dataAsString  = String(data: self, encoding : .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: palabra, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil}
        return data
    }
}
*/
