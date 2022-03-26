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
        nomeLabel.text = viewModel?.nome
        descricaoLabel.text = viewModel?.descricaoCurta
        enderecoLabel.text = viewModel?.endereco
        fotoImageView.image = viewModel?.foto

        cardView.adicionarBorda(cornerRadius: 10, color: UIColor.grayLightColor())
    }
    
}
