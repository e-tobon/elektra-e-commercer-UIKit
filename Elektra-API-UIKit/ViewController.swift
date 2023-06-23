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
    
    
    //Transferencia de Datos
    
    var titulo: String?
    var Booleano: Bool = false
    var imagenesArticulo: [String]?
    var itemImagenes: Int?
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myPagecontrol: UIPageControl!
    @IBOutlet weak var myImageView: UIImageView!
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
            myPagecontrol.isHidden = false
            myImageView.isHidden = false
            myLabel.text = self.titulo ?? ""
            myPagecontrol.numberOfPages = self.itemImagenes ?? 0
            myPagecontrol.currentPageIndicatorTintColor = .blue
            myPagecontrol.pageIndicatorTintColor = .lightGray
            
            //imagen
            putImage(imagenes: self.imagenesArticulo ?? [""], indiceImagen: 0)
        }
        if Booleano == false{
            myLabel.isHidden = true
            myPagecontrol.isHidden = true
            myPagecontrol.currentPageIndicatorTintColor = .blue
            myPagecontrol.pageIndicatorTintColor = .lightGray
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
    
    
    
    func putImage(imagenes:[String],indiceImagen:Int){
        if let urlImage = imagenes[indiceImagen] as? String{
            if let imageURL = URL(string: urlImage){
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imageURL) else{return}
                    let imageArticulo = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        self.myImageView.image = imageArticulo
                        
                    }
                }
            }
                
        }
    }
    @IBAction func myPageButtonAction(_ sender: Any) {
        
        DispatchQueue.main.async {
            self.putImage(imagenes: self.imagenesArticulo ?? [""], indiceImagen: self.myPagecontrol.currentPage)
        }
       
    }
}
extension ViewController:webServiceDelegate{
    func updateProductos(productos: Productos) {
            self.productos = productos
    }
    
    
}


