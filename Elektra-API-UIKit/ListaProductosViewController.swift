//
//  ListaProductosViewController.swift
//  Elektra-API-UIKit
//
//  Created by Edgar Tobón Sosa on 22/06/23.
//

import UIKit

class ListaProductosViewController: UIViewController {
    
    
    
    var productos:Productos?
    
    var indice:Int?
    
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var productosTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Productos"
        productosTableView.register(UINib(nibName: "ArticuloTableViewCell", bundle: nil), forCellReuseIdentifier: "articuloCell")
        productosTableView.rowHeight = 500
        productosTableView.dataSource = self
        productosTableView.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indicex = self.productosTableView.indexPathForSelectedRow
        let indexNumber = indicex?.row
        
        let cv = segue.destination as? ViewController
        
        
        cv?.Booleano = true
        
        cv?.titulo = productos?.resultado?.productos?[indexNumber!].nombre
        
        cv?.itemImagenes = productos?.resultado?.productos?[indexNumber!].urlImagenes?.count
        
        cv?.imagenesArticulo = productos?.resultado?.productos?[indexNumber!].urlImagenes
        
        cv?.porcentajeDescuento = productos?.resultado?.productos?[indexNumber!].porcentajeDescuento
        }


}

extension ListaProductosViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.productos!.resultado!.productos!.count
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
        performSegue(withIdentifier: "articuloTomain", sender: self)
        
    }
}




