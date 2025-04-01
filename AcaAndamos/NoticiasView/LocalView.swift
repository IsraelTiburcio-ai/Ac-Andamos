import SwiftUI

struct LocalNewsView: View {
    @State private var showNotifications = false
    @State private var showLocationSettings = false
    @State private var currentLocation = "CDMX"
    
    let noticias = [
        Noticia(titulo: "Nuevo programa de mantenimiento en parques",
                subtitulo: "La alcaldía invertirá 15MDP en renovación de áreas verdes en Chapultepec y otros parques",
                imagen: "parques_mh",
                url: "https://www.mhidalgo.cdmx.gob.mx"),
        
        Noticia(titulo: "Refuerzan seguridad en Polanco y Lomas",
                subtitulo: "Aumentan patrullajes tras reportes de robos a comercios",
                imagen: "seguridad_mh",
                url: "https://www.mhidalgo.cdmx.gob.mx"),
        
        Noticia(titulo: "Festival Cultural en Av. Paseo de la Reforma",
                subtitulo: "Evento con artistas locales este fin de semana, cierre parcial de carriles",
                imagen: "festival_mh",
                url: "https://www.mhidalgo.cdmx.gob.mx"),
        
        Noticia(titulo: "Obras de drenaje en Tacubaya",
                subtitulo: "Prevén terminarlas antes de temporada de lluvias, alternativas viales disponibles",
                imagen: "obras_mh",
                url: "https://www.mhidalgo.cdmx.gob.mx")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Encabezado personalizado
                    headerView
                    
                    // Historias destacadas
                    storiesView
                    
                    // Lista de noticias
                    ForEach(noticias) { noticia in
                        NoticiaPost(noticia: noticia)
                    }
                }
                .padding(.bottom)
            }
            .navigationBarHidden(true)
            .background(Color(.pink.opacity(0.2)))
            .sheet(isPresented: $showNotifications) {
                NotificationsViewMH()
            }
            .sheet(isPresented: $showLocationSettings) {
                LocationSettingsView(location: $currentLocation)
            }
        }
        .accentColor(Color(.blue))
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Miguel Hidalgo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.yellow)
                    Text(currentLocation)
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                // Botón de notificaciones
                Button(action: {
                    showNotifications.toggle()
                }) {
                    
                }
                
                // Botón de configuración de ubicación
                Button(action: {
                    showLocationSettings.toggle()
                }) {
                    Image(systemName: "location.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    
    private var storiesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(noticias.prefix(4)) { noticia in
                    StoryCard(noticia: noticia, imageName: noticia.imagen)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
    }
}

// Vista de notificaciones específica para MH
struct NotificationsViewMH: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(notificationData) { notification in
                        NotificationRowMH(notification: notification)
                    }
                }
            }
            .navigationTitle("Notificaciones")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Listo") {
                        // Cerrar vista
                    }
                }
            }
        }
    }
    
    let notificationData = [
        MHNotification(title: "Cierre programado en Av. Constituyentes",
                      message: "Por obras de mantenimiento, 12-15 de abril",
                      time: "Hace 2 horas",
                      isUnread: true),
        
        MHNotification(title: "Talleres gratuitos en centros comunitarios",
                      message: "Inscripciones abiertas para cursos de abril",
                      time: "Ayer",
                      isUnread: true),
        
        MHNotification(title: "Recolección de residuos voluminosos",
                      message: "Programa especial en colonia Tacubaya este sábado",
                      time: "Hace 2 días",
                      isUnread: false)
    ]
}

struct NotificationRowMH: View {
    let notification: MHNotification
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Circle()
                    .fill(notification.isUnread ? Color(.red) : Color.gray)
                    .frame(width: 8, height: 8)
                
                Text(notification.title)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(notification.isUnread ? .primary : .secondary)
                
                Spacer()
                
                Text(notification.time)
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            Text(notification.message)
                .font(.caption)
                .foregroundColor(.blue)
                .padding(.leading, 16)
            
            Divider()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(notification.isUnread ? Color(.green).opacity(0.05) : Color.gray.opacity(0.2))
    }
}

struct MHNotification: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let time: String
    let isUnread: Bool
}

struct LocationSettingsView: View {
    @Binding var location: String
    let alcaldias = ["Álvaro Obregón", "Azcapotzalco",
                     "Benito Juárez","Coyoacán","Cuajimalpa de Morelos",
                     "Cuauhtémoc","Gustavo A. Madero","Iztacalco",
                     "Iztapalapa","La Magdalena Contreras", "Miguel Hidalgo","Milpa Alta","Tláhuac","Tlalpan","México Desconocido","Venustian Carranza","Xochimilco​"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Selecciona tu alcaldía")) {
                    ForEach(alcaldias, id: \.self) { alcaldia in
                        Button(action: {
                            location = alcaldia
                        }) {
                            HStack {
                                Text(alcaldia)
                                Spacer()
                                if location == alcaldia {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color(.green))
                                }
                            }
                        }
                        .foregroundColor(.black)
                    }
                }
            }
            .navigationTitle("Configurar ubicación")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Listo") {
                        // Cerrar vista
                    }
                }
            }
        }
    }
}

struct NoticiaPost: View {
    let noticia: Noticia
    @State private var isLiked = false
    @State private var likeCount = Int.random(in: 5...50)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                Image("BJ") // Logo de la alcaldía
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(.blue), lineWidth: 2))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(noticia.titulo)
                        .font(.headline)
                        .bold()
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 5) {
                        Text("Publicado por Alcaldía MH")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("·")
                            .foregroundColor(.secondary)
                        
                        Text("Hace \(Int.random(in: 1...24)) horas")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            Text(noticia.subtitulo)
                .font(.body)
                .lineSpacing(4)
                .padding(.horizontal)
                .padding(.bottom, 8)
                .foregroundColor(.primary)
            
            Image("Parque1")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .clipped()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.3)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            Divider()
                .padding(.top, 4)
            
            HStack(spacing: 0) {
                Button(action: {
                    isLiked.toggle()
                    likeCount += isLiked ? 1 : -1
                }) {
                    HStack {
                        Image(systemName: isLiked ? "bookmark.fill" : "bookmark.fill")
                            .foregroundColor(isLiked ? Color(.blue) : .gray)
                        Text("Guardado")
                            .foregroundStyle(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
                
                Divider()
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right")
                            .foregroundStyle(.black)
                        Text("Ir al articulo")
                            .foregroundStyle(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
            }
            .font(.subheadline)
            .foregroundColor(.gray)
            .frame(height: 44)
        }
        .background()
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct StoryCard: View {
    let noticia: Noticia
    let imageName: String
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Image("History3")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(.red), Color.purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                        .shadow(radius: 3)
                    Text(noticia.titulo)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(width: 100)
                        .padding(.top, 4)
                }
                
                VStack {
                    Image("History1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(.red), Color.purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                        .shadow(radius: 3)
                    Text(noticia.titulo)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(width: 100)
                        .padding(.top, 4)
                }
                VStack {
                    Image("History4")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(.red), Color.purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                        .shadow(radius: 3)
                    Text(noticia.titulo)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(width: 100)
                        .padding(.top, 4)
                }
                VStack {
                    Image("History2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(.red), Color.purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                        .shadow(radius: 3)
                    Text(noticia.titulo)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(width: 100)
                        .padding(.top, 4)
                }

            }
        }
    }
}

struct Noticia: Identifiable {
    let id = UUID()
    let titulo: String
    let subtitulo: String
    let imagen: String
    let url: String
}

// Extensión para el color personalizado
extension Color {
    static let mhBlue = Color(.blue) // Azul característico de Miguel Hidalgo
}

struct LocalNewsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LocalNewsView()
            
            LocalNewsView()
                .preferredColorScheme(.dark)
        }
    }
}
