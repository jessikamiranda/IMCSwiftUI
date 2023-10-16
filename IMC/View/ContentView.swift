//
//  ContentView.swift
//  IMC
//
//  Created by Jessika Miranda on 13/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var height: String = ""
    @State private var weight: String = ""
    
    @State private var isEditing = false
    
    @State private var isMale: Bool = true
    @State private var isFemale: Bool = true
    
    @State private var showingAlert = false
    @State private var navigationActive = false
    
    
    func onClick() -> Void {
        if (isMale == true && isFemale == true) || (height == "" || weight == "") {
            showingAlert = true
        } else {
            navigationActive = true
        }
    }
    
    func formatHeight() {
        let cleanedText = height.filter { "0123456789".contains($0) }
        
        if cleanedText.count > 3 {
            height = String(cleanedText.prefix(3))
        } else {
            height = cleanedText
        }
        
        if height.count > 1 {
            let index = height.index(height.startIndex, offsetBy: 1)
            height.insert(",", at: index)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("neutral")
                    .ignoresSafeArea()
                
                VStack {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Calculadora de")
                                .foregroundStyle(Color("text.primary"))
                            Text("IMC")
                                .foregroundStyle(Color("brand"))
                        }
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("O índice de massa corporal (IMC) é uma medida internacional usada para calcular se uma pessoa está no peso ideal.")
                            .font(.callout)
                            .foregroundStyle(Color("text.primary"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Selecione seu sexo")
                            .textCase(.uppercase)
                            .font(.caption)
                            .foregroundStyle(Color("text.secondary"))
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                isFemale = true
                                isMale = false
                            }) {
                                VStack {
                                    Image("female")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    Text("Feminino")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color("text.primary"))
                                }
                                .opacity(isFemale ? 1.0 : 0.5)
                            }
                            
                            Button(action: {
                                isFemale = false
                                isMale = true
                            }) {
                                VStack {
                                    Image("male")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    Text("Masculino")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color("text.primary"))
                                }
                                .opacity(isMale ? 1.0 : 0.5)
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Digite sua altura")
                                .textCase(.uppercase)
                                .font(.caption)
                                .foregroundStyle(Color("text.secondary"))
                            
                            HStack() {
                                Image(systemName: "lines.measurement.vertical")
                                
                                TextField("Ex: 1,65", text: $height)
                                    .keyboardType(.decimalPad)
                                    .onChange(of: height) {
                                        formatHeight()
                                    }
                            }
                            .padding(16)
                            .foregroundStyle(Color("text.primary"))
                            .background(
                                Color("brand").opacity(0.1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Digite seu peso")
                                .textCase(.uppercase)
                                .font(.caption)
                                .foregroundStyle(Color("text.secondary"))
                            
                            HStack() {
                                Image(systemName: "scalemass")
                                
                                TextField("Ex: 62,5", text: $weight)
                                    .keyboardType(.decimalPad)
                                    .onChange(of: weight) {
                                        let cleanedWeight = weight.filter { "0123456789,".contains($0) }
                                        weight = cleanedWeight
                                    }
                            }
                            .padding(16)
                            .foregroundStyle(Color("text.primary"))
                            .background(
                                Color("brand").opacity(0.1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: onClick) {
                        Text("Calcular IMC →")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("brand"))
                            .foregroundStyle(Color("neutral"))
                            .bold()
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    
                    .alert("Preencha todas as informações.", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    
                    .navigationDestination(isPresented: $navigationActive) {
                        let formattedweight = Double(weight.replacingOccurrences(of: ",", with: ".")) ?? 0
                        let formattedheight = Double(height.replacingOccurrences(of: ",", with: ".")) ?? 0
                        let formattedgender = isMale ? "male" : "female"
                        
                        ResultView(height: formattedheight, weight: formattedweight, gender: formattedgender)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
