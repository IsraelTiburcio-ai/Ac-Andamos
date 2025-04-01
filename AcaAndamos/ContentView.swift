//
//  ContentView.swift
//  AcaAndamos
//
//  Created by CEDAM 11 on 31/03/25.
//
import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var showingNotifications = false
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack(spacing: 0) {
            // Barra superior
            HStack {
                // Botón de notificaciones
                Button(action: {
                    showingNotifications.toggle()
                }) {
                    Image(systemName: "bell.fill")
                        .foregroundColor(.white)
                        .padding()
                }
                .sheet(isPresented: $showingNotifications) {
                    NotificationsView()
                }
                
                Spacer()
                
                // Mostrar ubicación actual
                if let location = locationManager.location {
                    Text("\(location.coordinate.latitude.roundTo(places: 4)), \(location.coordinate.longitude.roundTo(places: 4))")
                        .foregroundColor(.white)
                        .font(.caption)
                } else {
                    VStack {
                        Text("Obteniendo ubicación...")
                            .foregroundColor(.white)
                            .font(.caption)
                        
                        if locationManager.authorizationStatus == .denied {
                            Text("Activa ubicación en Ajustes")
                                .font(.caption2)
                                .foregroundColor(.yellow)
                        }
                    }
                }
                
                Spacer()
                
                // Icono de ubicación (balance visual)
                Image(systemName: "location.fill")
                    .foregroundColor(.white)
                    .padding()
                    .opacity(0)
            }
            .frame(maxWidth: .infinity)
            .background(Color.black)
            
            // Contenido principal con tabs
            TabView {
                NoticiasView()
                    .tabItem {
                        Image(systemName: "newspaper.fill")
                        Text("Noticias")
                    }
                
                AvisosyApoyos()
                    .tabItem {
                        Image(systemName: "bell.fill")
                        Text("Avisos")
                    }
                
                ConsumeLocalView()
                    .tabItem {
                        Image(systemName: "bag.fill")
                        Text("Consume Local")
                    }
                
                DondeIrView()
                    .tabItem {
                        Image(systemName: "figure.walk")
                        Text("¿A dónde ir?")
                    }
            }
        }
        .background(.black)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            locationManager.requestPermission()
        }
    }
}

// Vista de notificaciones mejorada
struct NotificationsView: View {
    var body: some View {
        NavigationView {
            List {
                NotificationRow2(
                    icon: "exclamationmark.triangle.fill",
                    color: .orange,
                    title: "Alerta climática",
                    message: "Contingencia ambiental activa hoy",
                    time: "Hace 1 hora"
                )
                
                NotificationRow2(
                    icon: "calendar",
                    color: .blue,
                    title: "Evento cultural",
                    message: "Festival de primavera este fin de semana",
                    time: "Ayer"
                )
                
                NotificationRow2(
                    icon: "wrench.fill",
                    color: .gray,
                    title: "Mantenimiento",
                    message: "Cierre parcial de Línea 1 del Metro",
                    time: "20/04/24"
                )
            }
            .navigationTitle("Notificaciones")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Listo") {}
                }
            }
        }
    }
}

struct NotificationRow2: View {
    let icon: String
    let color: Color
    let title: String
    let message: String
    let time: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(color)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .bold()
                
                Text(message)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                Text(time)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.vertical, 6)
    }
}

// LocationManager implementado correctamente
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestPermission() {
        if authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("Ubicación denegada")
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error de ubicación: \(error.localizedDescription)")
    }
}

// Extensión para redondear coordenadas
extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

#Preview {
    ContentView()
}
