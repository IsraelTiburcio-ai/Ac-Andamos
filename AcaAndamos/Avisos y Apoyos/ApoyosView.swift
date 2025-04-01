//
//  ApoyosView.swift
//  AcaAndamos2
//
//  Created by DEVELOP10 on 31/03/25.
//
import SwiftUI

struct ApoyosView: View {
    let apoyos = [
        Apoyo(
            categoria: "Educación",
            titulo: "Becas Benito Juárez",
            descripcion: "Apoyo económico para estudiantes de educación básica y media superior",
            imagen: "BecasEducacion",
            url: "https://www.gob.mx/becasbenitojuarez",
            destacado: true
        ),
        Apoyo(
            categoria: "Adultos Mayores",
            titulo: "Pensión 65+",
            descripcion: "Apoyo mensual para adultos mayores de 65 años en situación vulnerable",
            imagen: "PensionMayores",
            url: "https://www.gob.mx/bienestar",
            destacado: false
        ),
        Apoyo(
            categoria: "Salud",
            titulo: "Seguro Popular",
            descripcion: "Acceso a servicios médicos gratuitos para personas sin seguridad social",
            imagen: "SeguroPopular",
            url: "https://www.gob.mx/insabi",
            destacado: true
        ),
        Apoyo(
            categoria: "Empleo",
            titulo: "Jóvenes Construyendo el Futuro",
            descripcion: "Capacitación laboral y becas para jóvenes entre 18 y 29 años",
            imagen: "JovenesConstruyendo",
            url: "https://jovenesconstruyendoelfuturo.stps.gob.mx",
            destacado: false
        ),
        Apoyo(
            categoria: "Mujeres",
            titulo: "Apoyo a Madres Solteras",
            descripcion: "Programa de asistencia económica para madres solteras en situación vulnerable",
            imagen: "MadresSolteras",
            url: "https://www.gob.mx/bienestar",
            destacado: true
        ),
        Apoyo(
            categoria: "Cultura",
            titulo: "Becas para Artistas",
            descripcion: "Apoyos a creadores artísticos y culturales",
            imagen: "BecasCultura",
            url: "https://fonca.cultura.gob.mx",
            destacado: false
        ),
        Apoyo(
            categoria: "Desarrollo",
            titulo: "Créditos a la Palabra",
            descripcion: "Financiamiento para proyectos productivos sin aval ni garantía",
            imagen: "CreditosPalabra",
            url: "https://www.gob.mx/nafin",
            destacado: false
        ),
        Apoyo(
            categoria: "Servicios",
            titulo: "Pago de Servicios Básicos",
            descripcion: "Información sobre pagos de agua, luz y otros servicios",
            imagen: "PagoServicios",
            url: "https://www.gob.mx/servicios",
            destacado: false
        )
    ]
    
    @State private var categoriaSeleccionada = "Todos"
    let categorias = ["Todos", "Educación", "Adultos Mayores", "Salud", "Empleo", "Mujeres", "Cultura", "Desarrollo", "Servicios"]
    
    var apoyosFiltrados: [Apoyo] {
        if categoriaSeleccionada == "Todos" {
            return apoyos
        } else {
            return apoyos.filter { $0.categoria == categoriaSeleccionada }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Encabezado
                HStack {
                    Text("Apoyos Sociales")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                    Image(systemName: "hand.raised.fill")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                .padding(.bottom, 5)
                
                Divider()
                
                // Filtros por categoría
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(categorias, id: \.self) { categoria in
                            Button(action: {
                                categoriaSeleccionada = categoria
                            }) {
                                Text(categoria)
                                    .font(.system(size: 14, weight: .medium))
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 8)
                                    .foregroundColor(categoriaSeleccionada == categoria ? .white : .black)
                                    .background(categoriaSeleccionada == categoria ? Color.pink : Color.white)
                                    .cornerRadius(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.pink, lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .padding(.bottom)
                }
                
                // Apoyos destacados
                Text("Apoyos Destacados")
                    .font(.title3)
                    .bold()
                    .padding(.top, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(apoyos.filter { $0.destacado }) { apoyo in
                            ApoyoDestacadoCard(apoyo: apoyo)
                        }
                    }
                }
                .padding(.bottom)
                
                // Todos los apoyos
                Text("Todos los Programas")
                    .font(.title3)
                    .bold()
                
                VStack(spacing: 20) {
                    ForEach(apoyosFiltrados) { apoyo in
                        ApoyoCard(apoyo: apoyo)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .background(Color(.pink.opacity(0.01)))
    }
}

struct ApoyoDestacadoCard: View {
    let apoyo: Apoyo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(apoyo.categoria.uppercased())
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(apoyo.titulo)
                .font(.headline)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Image("apoyo")
                .resizable()
                .scaledToFill()
                .frame(width: 220, height: 120)
                .clipped()
                .cornerRadius(12)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.3)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            Text(apoyo.descripcion)
                .font(.caption)
                .lineLimit(2)
                .foregroundColor(.secondary)
            
            Button(action: {}) {
                Text("Más información")
                    .font(.caption)
                    .foregroundColor(.pink)
            }
        }
        .padding()
        .frame(width: 240)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct ApoyoCard: View {
    let apoyo: Apoyo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(apoyo.categoria.uppercased())
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                    Text(apoyo.titulo)
                        .font(.headline)
                    
                    Text(apoyo.descripcion)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Image(apoyo.imagen)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 60)
                    .clipped()
                    .cornerRadius(8)
            }
            
            Button(action: {}) {
                HStack {
                    Text("Ir al sitio oficial")
                        .font(.caption)
                        .foregroundColor(.pink)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right.circle.fill")
                        .foregroundColor(.pink)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

struct Apoyo: Identifiable {
    let id = UUID()
    let categoria: String
    let titulo: String
    let descripcion: String
    let imagen: String
    let url: String
    let destacado: Bool
}

#Preview {
    ApoyosView()
}
