//
//  SwiftUIView.swift
//  AcaAndamos
//
//  Created by CEDAM 11 on 31/03/25.
//
//
//  SwiftUIView.swift
//  AcaAndamos
//
//  Created by CEDAM 11 on 31/03/25.
//

import SwiftUI

struct NoticiasView: View {
    @State private var selectedSection = "Miguel Hidalgo"
    
    var body: some View {
        VStack {
            Picker("Sección", selection: $selectedSection) {
                Text("Miguel Hidalgo").tag("Miguel Hidalgo")
                Text("CDMX").tag("CDMX")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedSection == "Miguel Hidalgo" {
                LocalNewsView()
            } else {
                CDMXNewsView()
            }
        }
        .navigationTitle("Noticias")
    }
}

#Preview {
    NoticiasView()
}
