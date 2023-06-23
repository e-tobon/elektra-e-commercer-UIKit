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
    var titulo: String?
    var Booleano: Bool = false
    
    //Transferencia de Datos
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
  
    @IBOutlet weak var myActivity: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myActivity.hidesWhenStopped = true
        myActivity.color = .red
        myActivity.stopAnimating()
        webAPI.delegate = self
        
        if Booleano == true{
            myLabel.isHidden = false
            myButton.isHidden = true
            myLabel.text = self.titulo ?? ""
        }
        if Booleano == false{
            myLabel.isHidden = true
        }
    }

    @IBAction func myButtonAction(_ sender: Any) {
        myActivity.startAnimating()
        myButton.isHidden = true
        self.webAPI.getproductos()
        while(self.productos == nil){
        }
    
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


