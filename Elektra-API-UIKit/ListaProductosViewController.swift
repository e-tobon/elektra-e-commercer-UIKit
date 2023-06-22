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
    @IBOutlet weak var productosTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
       
        if let articulos = productos{
            
            DispatchQueue.main.async {
                cell?.textLabel?.text = articulos.resultado?.productos?[indexPath.row].nombre
            }
            
        }
        
        return cell!
    }
    

}

extension ListaProductosViewController: webServiceDelegate{
    func updateProductos(productos: Productos) {
        self.productos = productos
    }
    
    
}
