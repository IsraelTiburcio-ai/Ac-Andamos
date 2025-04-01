//
//  TusAvisosView.swift
//  AcaAndamos2
//
//  Created by DEVELOP10 on 31/03/25.
//
//
//  AvisosView.swift
//  AcaAndamos2
//
//  Created by DEVELOP10 on 31/03/25.
//
import SwiftUI

struct AvisosView: View {
    let avisos = [
        Aviso(
            categoria: "Seguridad",
            subcategoria: "Robo",
            titulo: "Reporte de robo en zona centro",
            descripcion: "Se reportan robos a transeúntes en las calles del centro histórico",
            imagen: "alerta_robo",
            url: "https://www.ssp.mx/reportes",
            destacado: true,
            fecha: "02/04/2023",
            ubicacion: "Centro Histórico"
        ),
        Aviso(
            categoria: "Tránsito",
            subcategoria: "Accidente",
            titulo: "Accidente vehicular en Periférico",
            descripcion: "Choque múltiple en Periférico Norte a la altura de Santa Fe",
            imagen: "Accidente",
            url: "https://www.sct.gob.mx/transito",
            destacado: true,
            fecha: "01/04/2023",
            ubicacion: "Periférico Norte"
        ),
        Aviso(
            categoria: "Clima",
            subcategoria: "Lluvias",
            titulo: "Alerta por lluvias intensas",
            descripcion: "Se pronostican lluvias intensas para esta tarde en toda la ciudad",
            imagen: "alerta_clima",
            url: "https://www.conagua.gob.mx",
            destacado: false,
            fecha: "02/04/2023",
            ubicacion: "Toda la ciudad"
        ),
        Aviso(
            categoria: "Servicios",
            subcategoria: "Agua",
            titulo: "Corte de agua programado",
            descripcion: "Suspensión de servicio de agua por mantenimiento en colonias del poniente",
            imagen: "alerta_agua",
            url: "https://www.sacmex.cdmx.gob.mx",
            destacado: false,
            fecha: "03/04/2023",
            ubicacion: "Zona Poniente"
        ),
        Aviso(
            categoria: "Salud",
            subcategoria: "Epidemiología",
            titulo: "Alerta sanitaria por dengue",
            descripcion: "Aumento de casos de dengue en colonias del sur de la ciudad",
            imagen: "alerta_salud",
            url: "https://www.salud.cdmx.gob.mx",
            destacado: true,
            fecha: "30/03/2023",
            ubicacion: "Zona Sur"
        ),
        Aviso(
            categoria: "Eventos",
            subcategoria: "Manifestación",
            titulo: "Manifestación en Reforma",
            descripcion: "Protesta ciudadana bloqueará Paseo de la Reforma de 10 a 14 hrs",
            imagen: "alerta_evento",
            url: "https://www.ssp.cdmx.gob.mx",
            destacado: false,
            fecha: "02/04/2023",
            ubicacion: "Paseo de la Reforma"
        ),
        Aviso(
            categoria: "Transporte",
            subcategoria: "Metro",
            titulo: "Cierre temporal de Línea 3",
            descripcion: "Servicio suspendido por mantenimiento entre Indios Verdes y La Raza",
            imagen: "alerta_metro",
            url: "https://www.metro.cdmx.gob.mx",
            destacado: false,
            fecha: "03/04/2023",
            ubicacion: "Línea 3 del Metro"
        ),
        Aviso(
            categoria: "Educación",
            subcategoria: "Universidad",
            titulo: "Paro de actividades en UNAM",
            descripcion: "Suspensión de clases por protesta estudiantil en CU",
            imagen: "alerta_educacion",
            url: "https://www.unam.mx",
            destacado: false,
            fecha: "02/04/2023",
            ubicacion: "Ciudad Universitaria"
        )
    ]
    
    @State private var categoriaSeleccionada = "Todos"
    @State private var subcategoriaSeleccionada = "Todos"
    
    let categorias = ["Todos", "Seguridad", "Tránsito", "Clima", "Servicios", "Salud", "Eventos", "Transporte", "Educación"]
    
    var subcategorias: [String] {
        if categoriaSeleccionada == "Todos" {
            return ["Todos"]
        } else {
            let subcats = avisos.filter { $0.categoria == categoriaSeleccionada }.map { $0.subcategoria }
            return ["Todos"] + Array(Set(subcats)).sorted()
        }
    }
    
    var avisosFiltrados: [Aviso] {
        var filtrados = avisos
        
        if categoriaSeleccionada != "Todos" {
            filtrados = filtrados.filter { $0.categoria == categoriaSeleccionada }
        }
        
        if subcategoriaSeleccionada != "Todos" {
            filtrados = filtrados.filter { $0.subcategoria == subcategoriaSeleccionada }
        }
        
        return filtrados
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Encabezado
                HStack {
                    Text("Avisos y Alertas")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.title2)
                        .foregroundColor(.pink)
                }
                .padding(.bottom, 5)
                
                Divider()
                
                // Filtros por categoría
                VStack(alignment: .leading, spacing: 10) {
                    Text("Filtrar por:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(categorias, id: \.self) { categoria in
                                Button(action: {
                                    categoriaSeleccionada = categoria
                                    subcategoriaSeleccionada = "Todos"
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
                    }
                    
                    if categoriaSeleccionada != "Todos" {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(subcategorias, id: \.self) { subcategoria in
                                    Button(action: {
                                        subcategoriaSeleccionada = subcategoria
                                    }) {
                                        Text(subcategoria)
                                            .font(.system(size: 12, weight: .medium))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .foregroundColor(subcategoriaSeleccionada == subcategoria ? .white : .black)
                                            .background(subcategoriaSeleccionada == subcategoria ? Color.pink.opacity(0.8) : Color.white)
                                            .cornerRadius(12)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.pink.opacity(0.5), lineWidth: 1)
                                            )
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
                
                // Avisos destacados
                Text("Alertas Destacadas")
                    .font(.title3)
                    .bold()
                    .padding(.top, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(avisos.filter { $0.destacado }) { aviso in
                            AvisoDestacadoCard(aviso: aviso)
                        }
                    }
                }
                .padding(.bottom)
                
                // Todos los avisos
                Text("Todos los Avisos")
                    .font(.title3)
                    .bold()
                
                VStack(spacing: 20) {
                    ForEach(avisosFiltrados) { aviso in
                        AvisoCard(aviso: aviso)
                    }
                }
            }
            .padding()
        }
        .background(Color(.pink.opacity(0.01)))
    }
}

struct AvisoDestacadoCard: View {
    let aviso: Aviso
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(aviso.categoria.uppercased())
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text(aviso.fecha)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Text(aviso.titulo)
                .font(.headline)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Image(aviso.imagen)
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
            
            Text(aviso.descripcion)
                .font(.caption)
                .lineLimit(2)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "mappin")
                    .font(.caption2)
                Text(aviso.ubicacion)
                    .font(.caption)
            }
            .foregroundColor(.pink)
            
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

struct AvisoCard: View {
    let aviso: Aviso
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(aviso.categoria.uppercased())
                            .font(.caption2)
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text(aviso.fecha)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(aviso.subcategoria)
                        .font(.caption)
                        .foregroundColor(.pink)
                    
                    Text(aviso.titulo)
                        .font(.headline)
                    
                    Text(aviso.descripcion)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    HStack {
                        Image(systemName: "mappin")
                            .font(.caption2)
                        Text(aviso.ubicacion)
                            .font(.caption)
                    }
                    .foregroundColor(.pink)
                }
                
                Spacer()
                
                Image(aviso.imagen)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 60)
                    .clipped()
                    .cornerRadius(8)
            }
            
            Button(action: {}) {
                HStack {
                    Text("Ver detalles")
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

struct Aviso: Identifiable {
    let id = UUID()
    let categoria: String
    let subcategoria: String
    let titulo: String
    let descripcion: String
    let imagen: String
    let url: String
    let destacado: Bool
    let fecha: String
    let ubicacion: String
}

#Preview {
    AvisosView()
}
