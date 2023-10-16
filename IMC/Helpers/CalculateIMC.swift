//
//  CalculateIMC.swift
//  IMC
//
//  Created by Jessika Miranda on 16/10/23.
//

import Foundation
import SwiftUI

func calculateIMCResult(imc: Double, gender: String) -> (result: String, color: Color, description: String) {
    let low = "está abaixo do recomendado para a sua altura"
    let normal = "é considerado normal para a sua altura"
    let high = "está acima do recomendado para a sua altura"
    
    if gender == "male" {
        if imc < 18.5 {
            let result = "Magreza"
            let color = Color(.blue)
            let description = low
            
            return (result, color, description)
        }
        
        if 18.5...24.9 ~= imc {
            let result = "Normal"
            let color = Color(.green)
            let description = normal
            
            return (result, color, description)
        }
    } else {
        if imc < 17.9 {
            let result = "Magreza"
            let color = Color(.blue)
            let description = low
            
            return (result, color, description)
        }
        
        if 17.9...24.9 ~= imc {
            let result = "Normal"
            let color = Color(.green)
            let description = normal
            
            return (result, color, description)
        }
    }
    
    if 25...29.9 ~= imc {
        let result = "Sobrepeso"
        let color = Color(.orange)
        let description = high
        
        return (result, color, description)
    }
    
    if 30...34.9 ~= imc {
        let result = "Obesidade grau I"
        let color = Color(.red)
        let description = high
        
        return (result, color, description)
    }
    
    if 35...39.9 ~= imc {
        let result = "Obesidade grau II"
        let color = Color(.red)
        let description = high
        
        return (result, color, description)
    }
    
    else {
        let result = "Obesidade grau III"
        let color = Color(.red)
        let description = high
        
        return (result, color, description)
    }
}

func calculateIMCRange(height: Double, gender: String) -> (minWeight: Double, maxWeight: Double) {
    let minIMC: Double
    
    if gender == "male" {
        minIMC = 18.5
    } else {
        minIMC = 17.9
    }
    
    let minWeight = minIMC * (height * height)
    let maxWeight = 24.9 * (height * height)
    
    return(minWeight, maxWeight)
}
