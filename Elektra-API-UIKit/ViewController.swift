//
//  ViewController.swift
//  Elektra-API-UIKit
//
//  Created by Edgar Tobón Sosa on 22/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    let webAPI = webService()
    var productos: Productos?
    
    @IBOutlet weak var myButton: UIButton!
  
    @IBOutlet weak var myActivity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myActivity.isHidden = true
        myActivity.color = .red
        webAPI.delegate = self
    
            
    }

    @IBAction func myButtonAction(_ sender: Any) {
        webAPI.getproductos()
        myActivity.isHidden = false
        myActivity.startAnimating()
    
        while(self.productos == nil){
           
        }
        myActivity.isHidden = true
        performSegue(withIdentifier: "mainToarticulo", sender: self)
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToarticulo"{
            if let destino = segue.destination as? ListaProductosViewController{
                destino.productos = self.productos
            }
        }
    }
}

extension ViewController:webServiceDelegate{
    func updateProductos(productos: Productos) {
            self.productos = productos
    }
    
    
}
