//
//  SwiftUIView.swift
//  AcaAndamos
//
//  Created by CEDAM 11 on 31/03/25.
//

import SwiftUI

struct CDMXNewsView: View {
    @State private var showNotifications = false
    @State private var showFilters = false
    @State private var selectedCategory = "Todas"
    @State private var breakingNewsShown = true
    
    let categories = ["Todas", "Política", "Cultura", "Economía", "Seguridad", "Movilidad", "Medio Ambiente"]
    
    let cdmxNews = [
        CDMXNews(titulo: "Gobierno capitalino lanza programa de apoyo a pequeños comercios",
                 subtitulo: "Inversión de 200 millones de pesos para reactivar la economía local en las 16 alcaldías",
                 imagen: "comercios_cdmx",
                 categoria: "Economía",
                 fecha: "Hace 2 horas",
                 destacada: true),
        
        CDMXNews(titulo: "Ampliación de Línea 12 del Metro inicia en junio",
                 subtitulo: "Obras contemplan 5 nuevas estaciones hacia Observatorio",
                 imagen: "metro_cdmx",
                 categoria: "Movilidad",
                 fecha: "Hace 5 horas",
                 destacada: true),
        
        CDMXNews(titulo: "Contingencia ambiental por alta concentración de ozono",
                 subtitulo: "Se activa Fase 1; recomiendan evitar actividades al aire libre",
                 imagen: "contigencia_cdmx",
                 categoria: "Medio Ambiente",
                 fecha: "Ayer",
                 destacada: false),
        
        CDMXNews(titulo: "Festival Internacional de Cine en CDMX tendrá sede en Reforma",
                 subtitulo: "Se proyectarán más de 100 películas al aire libre",
                 imagen: "cine_cdmx",
                 categoria: "Cultura",
                 fecha: "Ayer",
                 destacada: true),
        
        CDMXNews(titulo: "Hallazgo de vestigios aztecas en obras de Línea 3 del Cablebús",
                 subtitulo: "Arqueólogos descubren ofrenda con 20 piezas prehispánicas",
                 imagen: "arqueologia_cdmx",
                 categoria: "Cultura",
                 fecha: "Hace 3 días",
                 destacada: false),
        
        CDMXNews(titulo: "Refuerzan operativos de seguridad en Tepito y La Merced",
                 subtitulo: "Despliegan 500 elementos de la SSC para combatir comercio informal",
                 imagen: "seguridad_cdmx",
                 categoria: "Seguridad",
                 fecha: "Hace 3 días",
                 destacada: false)
    ]
    
    var filteredNews: [CDMXNews] {
        if selectedCategory == "Todas" {
            return cdmxNews
        } else {
            return cdmxNews.filter { $0.categoria == selectedCategory }
        }
    }
    
    var breakingNews: CDMXNews? {
        cdmxNews.first(where: { $0.destacada }) ?? cdmxNews.first
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Header con logo de CDMX
                    headerView
                    
                    // Noticia de última hora
                    if breakingNewsShown, let breakingNews = breakingNews {
                        BreakingNewsView(noticia: breakingNews, closeAction: { breakingNewsShown = false })
                            .padding(.horizontal, 16)
                            .padding(.bottom, 10)
                    }
                    
                    // Categorías
                    categoriesView
                        .padding(.bottom, 10)
                    
                    // Lista de noticias
                    LazyVStack(spacing: 16) {
                        ForEach(filteredNews) { noticia in
                            NewsCard(noticia: noticia)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 20)
            }
            .background(Color("CDMXBackground"))
            .navigationBarHidden(true)
            .sheet(isPresented: $showNotifications) {
                NotificationsView()
            }
        }
        .accentColor(Color("CDMXBlue"))
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image("escudo_cdmx") // Añadir este asset a tu proyecto
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                    
                    Text("CDMX Informa")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("CDMXBlueDark"))
                }
                
                Text("Información oficial del Gobierno de la Ciudad de México")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: {
                    showFilters.toggle()
                }) {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .font(.title2)
                        .foregroundColor(Color("CDMXBlue"))
                }
                
                Button(action: {
                    showNotifications.toggle()
                }) {
                    ZStack {
                        Image(systemName: "bell.fill")
                            .font(.title2)
                            .foregroundColor(Color("CDMXBlue"))
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 8, height: 8)
                            .offset(x: 8, y: -8)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 15)
        .background(Color(.systemBackground))
    }
    
    private var categoriesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories, id: \.self) { category in
                    CategoryPill(category: category,
                                isSelected: selectedCategory == category,
                                action: { selectedCategory = category })
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - Componentes Reutilizables (modificados para CDMX)

struct BreakingNewsView: View {
    let noticia: CDMXNews
    let closeAction: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                    Text("ÚLTIMA HORA")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(.red)
                    Spacer()
                }
                
                Text(noticia.titulo)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Text(noticia.subtitulo)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red.opacity(0.3), lineWidth: 1)
            )
            
            Button(action: closeAction) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(8)
            }
        }
    }
}

struct CategoryPill: View {
    let category: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category)
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .foregroundColor(isSelected ? .white : Color("CDMXBlueDark"))
                .background(isSelected ? Color("CDMXBlue") : Color(.systemBackground))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("CDMXBlue"), lineWidth: isSelected ? 0 : 1)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct NewsCard: View {
    let noticia: CDMXNews
    @State private var isSaved = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Imagen con categoría
            ZStack(alignment: .topLeading) {
                Image(noticia.imagen)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .black.opacity(0.3)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                Text(noticia.categoria.uppercased())
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color("CDMXBlueDark"))
                    .cornerRadius(4)
                    .padding(8)
            }
            
            // Contenido textual
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(noticia.fecha)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if noticia.destacada {
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                            .foregroundColor(Color("CDMXBlue"))
                    }
                    
                    Spacer()
                    
                    Button(action: { isSaved.toggle() }) {
                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                            .foregroundColor(isSaved ? Color("CDMXBlue") : .gray)
                    }
                }
                
                Text(noticia.titulo)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(noticia.subtitulo)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    Image(systemName: "newspaper.fill")
                        .foregroundColor(Color("CDMXBlue"))
                    Text("Gobierno CDMX")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
    }
}

//struct NotificationsView: View {
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(spacing: 0) {
//                    ForEach(1...6, id: \.self) { index in
//                        NotificationRow(title: notificationTitles[index-1],
//                                       time: "Hace \(index) hora\(index > 1 ? "s" : "")",
//                                       isUnread: index <= 2)
//                    }
//                }
//            }
//            .navigationTitle("Notificaciones")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Listo") {
//                        // Cerrar la vista
//                    }
//                }
//            }
//        }
//    }
//
//    let notificationTitles = [
//        "Nuevo programa de apoyo a comercios en tu alcaldía",
//        "Alerta ambiental: Hoy no circula para holograma 1 y 2",
//        "Actualización: Cierre parcial de Circuito Interior por obras",
//        "Recordatorio: Pago de tenencia vehicular vence en 3 días",
//        "Evento cultural: Festival de Primavera en Chapultepec",
//        "Convocatoria: Becas para estudiantes de universidades públicas"
//    ]
//}

struct NotificationRow: View {
    let title: String
    let time: String
    let isUnread: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: isUnread ? "bell.fill" : "bell")
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(isUnread ? Color("CDMXBlue") : Color.gray)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(isUnread ? .primary : .secondary)
                
                Text(time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if isUnread {
                Circle()
                    .fill(Color("CDMXBlue"))
                    .frame(width: 8, height: 8)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .contentShape(Rectangle())
    }
}

// MARK: - Modelo de Datos para CDMX

struct CDMXNews: Identifiable {
    let id = UUID()
    let titulo: String
    let subtitulo: String
    let imagen: String
    let categoria: String
    let fecha: String
    let destacada: Bool
}

// MARK: - Assets de Color para CDMX

extension Color {
    static let cdmxBlue = Color("CDMXBlue")
    static let cdmxBlueDark = Color("CDMXBlueDark")
    static let cdmxBackground = Color("CDMXBackground")
}

// MARK: - Preview

struct CDMXNewsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CDMXNewsView()
                .preferredColorScheme(.light)
            
            CDMXNewsView()
                .preferredColorScheme(.dark)
        }
    }
}
