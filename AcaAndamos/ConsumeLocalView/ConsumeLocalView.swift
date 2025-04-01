//
//  ConsumeLocalView.swift
//  AcaAndamos
//
//  Created by CEDAM 11 on 31/03/25.
//
import SwiftUI

struct ConsumeLocalView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "Todos"
    
    let categories = ["Todos", "Mercados", "Restaurantes", "Cafeterías", "Artesanías", "Tiendas"]
    
    let localBusinesses = [
        LocalBusiness(
            name: "Mercado de Polanco",
            description: "Productos frescos y locales en el corazón de Polanco",
            category: "Mercados",
            images: ["mercado1", "mercado2", "mercado3"], // Múltiples imágenes
            rating: 4.8,
            distance: 1.2,
            isFeatured: true
        ),
        LocalBusiness(
            name: "Cafetería Avellaneda",
            description: "Café de especialidad tostado localmente",
            category: "Cafeterías",
            images: ["cafe1", "cafe2", "cafe3"],
            rating: 4.7,
            distance: 0.8,
            isFeatured: true
        ),
        LocalBusiness(
            name: "Tacos Don José",
            description: "Los mejores tacos al pastor de la zona",
            category: "Restaurantes",
            images: ["tacos1", "tacos2", "tacos3"],
            rating: 4.5,
            distance: 1.5,
            isFeatured: false
        ),
        LocalBusiness(
            name: "Artesanías Oaxaqueñas MH",
            description: "Productos tradicionales hechos por artesanos locales",
            category: "Artesanías",
            images: ["artesania1", "artesania2", "artesania3"],
            rating: 4.9,
            distance: 2.1,
            isFeatured: false
        ),
        LocalBusiness(
            name: "Panadería La Esperanza",
            description: "Pan tradicional hecho diariamente",
            category: "Tiendas",
            images: ["panaderia1", "panaderia2", "panaderia3"],
            rating: 4.6,
            distance: 0.5,
            isFeatured: true
        )
    ]
    
    var filteredBusinesses: [LocalBusiness] {
        if selectedCategory == "Todos" {
            return localBusinesses
        } else {
            return localBusinesses.filter { $0.category == selectedCategory }
        }
    }
    
    var featuredBusinesses: [LocalBusiness] {
        localBusinesses.filter { $0.isFeatured }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    // Barra de búsqueda
                    SearchBar(searchText: $searchText)
                        .padding(.horizontal)
                    
                    // Categorías
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(categories, id: \.self) { category in
                                CategoryPill2(
                                    category: category,
                                    isSelected: selectedCategory == category,
                                    action: { selectedCategory = category }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Negocios destacados (Carousel)
                    Text("Destacados en Miguel Hidalgo")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(featuredBusinesses) { business in
                                FeaturedBusinessCard(business: business)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Lista de negocios locales
                    Text("Todos los negocios")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    LazyVStack(spacing: 16) {
                        ForEach(filteredBusinesses) { business in
                            BusinessCard(business: business)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Consume Local")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.pink.opacity(0.2)))
        }
    }
}

// MARK: - Componentes Reutilizables

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Buscar negocios...", text: $searchText)
                .foregroundColor(.primary)
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

struct CategoryPill2: View {
    let category: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category)
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .foregroundColor(isSelected ? .white : Color(.black))
                .background(isSelected ? Color(.pink) : Color(.systemBackground))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.pink), lineWidth: isSelected ? 0 : 1)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FeaturedBusinessCard: View {
    let business: LocalBusiness
    @State private var currentImageIndex = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Carrusel de imágenes para negocios destacados
            TabView(selection: $currentImageIndex) {
                ForEach(0..<business.images.count, id: \.self) { index in
                    Image(business.images[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 120)
                        .clipped()
                        .cornerRadius(10)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .black.opacity(0.3)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(width: 200, height: 120)
            .cornerRadius(10)
            
            Text(business.name)
                .font(.headline)
                .lineLimit(1)
            
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                
                Text(String(format: "%.1f", business.rating))
                    .font(.caption)
                
                Text("· \(String(format: "%.1f km", business.distance))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 200)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct BusinessCard: View {
    let business: LocalBusiness
    @State private var currentImageIndex = 0
    
    var body: some View {
        HStack(spacing: 12) {
            // Carrusel de imágenes para la vista de lista
            TabView(selection: $currentImageIndex) {
                ForEach(0..<business.images.count, id: \.self) { index in
                    Image(business.images[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(width: 80, height: 80)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(business.name)
                    .font(.headline)
                
                Text(business.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                    
                    Text(String(format: "%.1f", business.rating))
                        .font(.caption)
                    
                    Text("· \(business.category)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(String(format: "%.1f km", business.distance))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

// MARK: - Modelo de Datos Actualizado

struct LocalBusiness: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let category: String
    let images: [String] // Ahora es un array de nombres de imágenes
    let rating: Double
    let distance: Double // en km
    let isFeatured: Bool
}

// MARK: - Preview

struct ConsumeLocalView_Previews: PreviewProvider {
    static var previews: some View {
        ConsumeLocalView()
    }
}
