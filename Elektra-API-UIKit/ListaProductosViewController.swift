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
        
        activity.color = .red
        activity.startAnimating()
        productosTableView.register(UINib(nibName: "ArticuloTableViewCell", bundle: nil), forCellReuseIdentifier: "articuloCell")
        productosTableView.rowHeight = 200
        apiService.getproductos()
        apiService.delegate = self
        productosTableView.dataSource = self
        
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
            cell!.precioLabel.text = "\(articulos.resultado!.productos![indexPath.row].precioFinal ?? 0 )"
        }
        
        

        
        return cell!
    }
    

}

extension ListaProductosViewController: webServiceDelegate{
    func updateProductos(productos: Productos) {
        DispatchQueue.main.async {
            self.productos = productos
            self.activity.isHidden = true
            self.productosTableView.reloadData()
            
        }
    }
    
    
}


