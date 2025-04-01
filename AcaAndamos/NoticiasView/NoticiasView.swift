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
    @State private var selectedSection = "Local"
    
    var body: some View {
        VStack {
            Picker("Sección", selection: $selectedSection) {
                Text("Local").tag("Local")
                Text("Estatal").tag("Estatal")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedSection == "Local" {
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
