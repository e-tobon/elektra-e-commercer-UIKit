//
//  ListaProductosViewController.swift
//  Elektra-API-UIKit
//
//  Created by Edgar Tobón Sosa on 22/06/23.
//

import UIKit

class ListaProductosViewController: UIViewController {

    let apiService = webService()
    
    var productos:Productos?
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var productosTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Productos"
        activity.color = .red
        activity.startAnimating()
        productosTableView.register(UINib(nibName: "ArticuloTableViewCell", bundle: nil), forCellReuseIdentifier: "articuloCell")
        productosTableView.rowHeight = 500
        apiService.getproductos()
        
        apiService.delegate = self
        productosTableView.dataSource = self
        productosTableView.delegate = self
        
    }
    



}

extension ListaProductosViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numProductos = apiService.numeroProductos{
            return numProductos
        }else{
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articuloCell", for: indexPath) as? ArticuloTableViewCell
        
        if let articulos = self.productos {
            cell!.articuloNombreLabel.text = articulos.resultado!.productos![indexPath.row].nombre
            cell!.precioLabel.text = "$\(articulos.resultado!.productos![indexPath.row].precioFinal ?? 0 )"
            cell!.categoriaLabel.text = articulos.resultado!.productos![indexPath.row].codigoCategoria
            if let urlImage = articulos.resultado!.productos![indexPath.row].urlImagenes![0] as? String{
                if let imageURL = URL(string: urlImage){
                    DispatchQueue.global().async {
                        guard let imagenData = try? Data(contentsOf: imageURL) else{return}
                        let imageArticulo = UIImage(data: imagenData)
                        DispatchQueue.main.async {
                            cell!.articuloImageView.image = imageArticulo
                        }
                    }
                }
                    
            }
        }
        return cell!
    }
    
}

extension ListaProductosViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Seleccionas: \(self.productos?.resultado?.productos?[indexPath.row].nombre ?? "")")
    }
}

extension ListaProductosViewController: webServiceDelegate{
    func updateProductos(productos: Productos) {
            DispatchQueue.main.async {
                if productos != nil {
                    self.productos = productos
                }
            
                self.activity.isHidden = true
                self.productosTableView.reloadData()
                
            }
        
       
    }
    
    
}


