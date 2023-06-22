//
//  Producto.swift
//  Elektra-API-UIKit
//
//  Created by Edgar Tobón Sosa on 22/06/23.
//

import Foundation
//Creacion del modelo producto con el protocolo Decodable
struct Producto: Decodable{
    let resultado:Productos?
}

struct Productos:Decodable{
    let productos:[Articulos]?
}

struct Articulos:Decodable{
    let id:String?
    let nombre:String?
    let codigoCategoria:String?
    let urlImagenes:[String]?
    let precioFinal: Int?
}
