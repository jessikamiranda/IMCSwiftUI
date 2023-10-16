//
//  ResultView.swift
//  IMC
//
//  Created by Jessika Miranda on 13/10/23.
//

import SwiftUI

struct ResultView: View {
    @State var height: Double
    @State var weight: Double
    @State var gender: String
    
    private var imc: Double {
        return weight / (height * height)
    }
    
    let gradient = Gradient(colors: [.blue, .green, .orange, .red])
    
    var body: some View {
        let imcResult = calculateIMCResult(imc: imc, gender: gender)
        let imcRange = calculateIMCRange(height: height, gender: gender)
        
        ZStack {
            Color("neutral")
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack {
                        Text("Seu")
                            .foregroundStyle(Color("brand"))
                        
                        Text("resultado")
                            .foregroundStyle(Color("text.primary"))
                    }
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 50)
                
                VStack(spacing: 10) {
                    Text("Seu IMC é de")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(Color("text.primary"))
                    
                    Text("\(imc, specifier: "%.1f")")
                        .font(.system(size: 48))
                        .fontWeight(.medium)
                        .foregroundStyle(Color("brand"))
                    
                    Text("kg/m²")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color("text.primary"))
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Gauge(value: imc, in: 15...45) {}
                        .tint(gradient)
                        .gaugeStyle(.accessoryLinear)
                    
                    Text("\(imcResult.result)")
                        .foregroundStyle(imcResult.color)
                        .font(.callout)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .top)
                .background(Color("neutral"))
                .cornerRadius(16)
                .shadow(color: Color("shadow.dark"), radius: 4, x: 6, y: 6)
                .shadow(color: Color("shadow.light"), radius: 4, x: -6, y: -6)
                
                Spacer()
                    .frame(height: 60)
                
                VStack(spacing: 16) {
                    Text("De acordo com a Organização Mundial da Saúde, seu IMC \(imcResult.description).")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color("text.primary"))
                    
                    Text("Para manter o valor de IMC normal, seu peso pode variar entre **\(imcRange.minWeight, specifier: "%.1f")** e **\(imcRange.maxWeight, specifier: "%.1f") kg**.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color("text.primary"))
                    
                    Spacer()
                    
                    Text("Importante: o cálculo de IMC não leva em consideração a composição corporal. Por esse motivo, pessoas com muita massa muscular, como é o caso de alguns atletas, podem apresentar um IMC acima do normal. O ideal é consultar um nutricionista para fazer uma avaliação mais detalhada.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color("text.secondary"))
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ResultView(height: 1, weight: 1, gender: "")
}
