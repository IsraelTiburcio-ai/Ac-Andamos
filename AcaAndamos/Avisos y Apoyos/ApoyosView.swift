//
//  ApoyosView.swift
//  AcaAndamos2
//
//  Created by DEVELOP10 on 31/03/25.
//

import SwiftUI

struct ApoyosView: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack {
                    Text("Apoyos")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                    Image(systemName: "figure.2.right.holdinghands")
                        .font(.title2)
                }
                Divider()
                
                Text("Registrate en la")
                    .font(.caption)
                    .foregroundStyle(.gray)
                Text("Pension mujeres Bienestar")
                Image("ApoyoMujeres")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 370)
                    .cornerRadius(20)
                    .shadow(radius: 100, x: 20, y:40)
                Text("Ir al sitio oficial")
                    .foregroundStyle(.blue)
                
                Divider()
                
                
                Text("Si tienes 60 a 64 años registrate en la ")
                    .font(.caption)
                    .foregroundStyle(.gray)
                Text("Pension 60 y más")
                    
                Image("60ymas")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 370)
                    .cornerRadius(20)
                    .shadow(radius: 100, x: 20, y:40)
                Text("Ir al sitio oficial")
                    .foregroundStyle(.blue)
                
                Divider()
                
                Text("No te olvides")
                    .font(.caption)
                    .foregroundStyle(.gray)
                Text("de pagar el Agua")
                    
                
                Image("Agua")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 370)
                    .cornerRadius(20)
                    .shadow(radius: 100, x: 20, y:40)
                Text("Ir al sitio oficial")
                    .foregroundStyle(.blue)
                
                Divider()
                
                Text("Fechas de")
                    .font(.caption)
                    .foregroundStyle(.gray)
                Text("paga a Pensionados")
                    
                
                Image("Pensionados")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 370)
                    .cornerRadius(20)
                    .shadow(radius: 100, x: 20, y:40)
                Text("Ir al sitio oficial")
                    .foregroundStyle(.blue)
                
                Divider()
                
                Text("No te olvides")
                    .font(.caption)
                    .foregroundStyle(.gray)
                Text("de pagar la Verificación")
                    
                
                Image("Verificación")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 370)
                    .cornerRadius(20)
                    .shadow(radius: 100, x: 20, y:40)
                Text("Ir al sitio oficial")
                    .foregroundStyle(.blue)
                Divider()
                
                
                
                
                
                
                    
            }.padding(.horizontal)
        }
    }
}

#Preview {
    ApoyosView()
}
