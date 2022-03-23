//
//  OficinalTableViewCell.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 22/03/22.
//

import UIKit

class OficinaTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var enderecoLabel: UILabel!
    
    func configuraTableViewCell(_ viewModel: OficinaViewModel?) {
//        nomeLabel.text = viewModel?.nome
//        descricaoLabel.text = viewModel?.descricaoCurta
//        enderecoLabel.text = viewModel?.endereco
//        fotoImageView.image = viewModel?.foto
        
        self.configuraLayout()
    }
    
    func configuraLayout() {
        cardView.layer.cornerRadius = 10
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        fotoImageView.layer.cornerRadius = 10
    }
    
}
