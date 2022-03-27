//
//  DataUtils.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 26/03/22.
//

import Foundation

class DataHelper {
    
    static func formatarData(_ data: Date, formato: String) -> String {
        let formatador = DateFormatter()
        formatador.timeZone = TimeZone(abbreviation: "GMT-3")
        formatador.dateFormat = formato
        return formatador.string(from: data)
    }
}
