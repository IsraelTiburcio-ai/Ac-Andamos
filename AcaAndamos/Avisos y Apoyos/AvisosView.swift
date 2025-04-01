//
//  TusAvisosView.swift
//  AcaAndamos2
//
//  Created by DEVELOP10 on 31/03/25.
//

import SwiftUI

struct AvisosView: View {
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading){
                HStack {
                    Text("Avisos")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                   
                }
                Divider()
                
                Text("No te olvides")
                    .font(.caption)
                    .foregroundStyle(.gray)
                Text("de la Tenencia")
                Image("Tenencia")
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
                Text("de pagar el Predial")
                    
                Image("Predial")
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
                    
                
                Image("Verificacion")
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
    AvisosView()
}
