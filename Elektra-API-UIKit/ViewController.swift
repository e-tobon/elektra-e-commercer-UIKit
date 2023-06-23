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
    var precionFinal: Double?
    var precioRegular:Double?
    var montoDescuento:Double?
    var pagoSemanal: Int?
    var porcentajeDescuento: Double?
    
    
    
 
  
    
    @IBOutlet weak var myBackButton: UIButton!
    @IBOutlet weak var StackViewPrecios: UIStackView!
    @IBOutlet weak var labelDescuento: UILabel!
    @IBOutlet weak var OfertaStackView: UIStackView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myPagecontrol: UIPageControl!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myActivity: UIActivityIndicatorView!
    @IBOutlet weak var labelPagoSemanal: UILabel!
    @IBOutlet weak var labelPrecioRegular: UILabel!
    
    @IBOutlet weak var stackViewSemanal: UIStackView!
    @IBOutlet weak var LabelPrecioFinal: UILabel!
    
    @IBOutlet weak var labelMontoDescuento: UILabel!
    override func viewDidLoad() {
        
    
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
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
            
            
            
            if(self.porcentajeDescuento != 0){
                
                labelDescuento.text = "\(porcentajeDescuento?.redondear(numeroDeDecimales: 0) ?? "")%"
                
                labelPrecioRegular.text =
                
                "Antes $\(self.precioRegular?.redondear(numeroDeDecimales: 0) ?? "")"
                
                LabelPrecioFinal.text = "Ahora $\(self.precionFinal?.redondear(numeroDeDecimales: 0) ?? "")"
                
                labelMontoDescuento.text = "Ahorras $\(self.montoDescuento?.redondear(numeroDeDecimales: 0) ?? "")"
            }else{
                OfertaStackView.isHidden = true
                labelMontoDescuento.isHidden = true
                labelPrecioRegular.isHidden = true
                LabelPrecioFinal.textColor = .black
                LabelPrecioFinal.text = "$\(self.precionFinal?.redondear(numeroDeDecimales: 0) ?? "")"
            }
            
            labelPagoSemanal.text = "$\(self.pagoSemanal ?? 0)"
        }
        if Booleano == false{
            myBackButton.isHidden = true
            myLabel.isHidden = true
            myPagecontrol.isHidden = true
            myPagecontrol.currentPageIndicatorTintColor = .blue
            myPagecontrol.pageIndicatorTintColor = .lightGray
            
            OfertaStackView.isHidden = true
            StackViewPrecios.isHidden = true
            stackViewSemanal.isHidden = true
        }
    }


  
    @IBAction func myBackButtonAction(_ sender: Any) {
        print("Hola")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func myButtonAction(_ sender: Any) {
        myActivity.startAnimating()
        myButton.isHidden = true
        self.webAPI.getproductos()
//        while(self.productos == nil){
//        }
//
        
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
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "mainToarticulo", sender: self)
        }
        
    }
    
    
}

extension Double {
    func redondear(numeroDeDecimales: Int) -> String {
        let formateador = NumberFormatter()
        formateador.maximumFractionDigits = numeroDeDecimales
        formateador.roundingMode = .down
        return formateador.string(from: NSNumber(value: self)) ?? ""
    }
}

