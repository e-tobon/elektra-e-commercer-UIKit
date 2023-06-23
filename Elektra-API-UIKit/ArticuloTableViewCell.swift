//
//  ArticuloTableViewCell.swift
//  Elektra-API-UIKit
//
//  Created by Edgar Tobón Sosa on 22/06/23.
//

import UIKit

class ArticuloTableViewCell: UITableViewCell {

    @IBOutlet weak var articuloNombreLabel: UILabel!

    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var categoriaLabel: UILabel!

    @IBOutlet weak var articuloImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
            
    }
    
}
