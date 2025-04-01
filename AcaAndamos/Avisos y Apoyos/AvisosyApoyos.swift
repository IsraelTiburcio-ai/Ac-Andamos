//
//  AvisosyApoyos.swift
//  AcaAndamos
//
//  Created by CEDAM 11 on 31/03/25.
//
 
import SwiftUI

struct AvisosyApoyos : View {
    @State private var selectedSection2 = "Avisos"
    var body: some View {
        
        VStack {
            Picker("Sección", selection: $selectedSection2) {
                Text("Avisos").tag("Avisos")
                Text("Apoyos").tag("Apoyos")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedSection2 == "Avisos" {
                AvisosView()
            } else {
                ApoyosView()
            }
        }
    }
}

#Preview {
    AvisosyApoyos()
}
