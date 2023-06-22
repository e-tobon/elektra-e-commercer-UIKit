//
//  webService.swift
//  Elektra-API-UIKit
//
//  Created by Edgar Tobón Sosa on 22/06/23.
//

import Foundation




protocol webServiceDelegate{
    func updateProductos(productos:Productos)
}

class webService{
    var delegate:webServiceDelegate?
    var numeroProductos:Int?
 
   
    func getproductos(){
        let urlString = "http://alb-dev-ekt-875108740.us-east-1.elb.amazonaws.com/sapp/productos/plp/1/ad2fdd4bbaec4d15aa610a884f02c91a"
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if error != nil{
                    print(error!.localizedDescription)
                }
                
                if let productosModel = try? JSONDecoder().decode(Productos.self, from: data!){
                   self.delegate?.updateProductos(productos: productosModel)
                    self.numeroProductos = productosModel.resultado?.productos?.count
                    
                    
                    
                }
            }
            task.resume()
        }
        
        
    }
}
