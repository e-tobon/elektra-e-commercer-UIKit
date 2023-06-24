//
//  webService.swift
//  Elektra-API-UIKit
//
//  Created by Edgar Tobón Sosa on 22/06/23.
//

import Foundation
import UIKit




protocol webServiceDelegate{
    func updateProductos(productos:Productos)
}

class webService{
    var delegate:webServiceDelegate?
    var numeroProductos:Int?
 
   
    func getproductos(){
        let urlString = "http://alb-dev-ekt-875108740.us-east-1.elb.amazonaws.com/sapp/productos/plp/1/ad2fdd4bbaec4d15aa610a884f02c91a"
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil{
                    
                    print(error!.localizedDescription)
                }
                
                guard let respuesta = response as? HTTPURLResponse else {return}
                
                if (respuesta.statusCode == 200){
                    
                    do{
                        if let productosModel = try? JSONDecoder().decode(Productos.self, from: data!){
                            self.delegate?.updateProductos(productos: productosModel)
                            self.numeroProductos = productosModel.resultado?.productos?.count
                        }
                    }
                    catch let error{
                        print(error)
                        
                    }
                }
            }
            task.resume()
        }
        
        
    }
}
