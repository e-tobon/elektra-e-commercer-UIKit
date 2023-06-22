//
//  Producto.swift
//  Elektra-API-UIKit
//
//  Created by Edgar Tobón Sosa on 22/06/23.
//

import Foundation
//Creacion del modelo producto con el protocolo Decodable
struct Productos: Codable{
    let codigo:String?
    let resultado:Articulos?
    
    
}

struct Articulos: Codable{
    let productos: [producto]?
}

struct producto: Codable{
    let id: String?
    let nombre: String?
    let urlImagenes:[String]?
    let precioFinal: Double?
    let codigoCategoria: String?
}
