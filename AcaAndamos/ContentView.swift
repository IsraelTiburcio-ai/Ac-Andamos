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
    @State private var weatherIcon = "sun.max.fill"
    @State private var temperature = "24°C"
    var body: some View {
        ZStack {
            // Fondo rosa en toda la pantalla
            Color.pink.opacity(0.2).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Barra superior
                HStack {
                    HStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .scaledToFit()
                        Spacer()
                        Text("24°C")
                            .font(.title3)
                            .bold()
                        
                        Image(systemName: "sun.max.fill")
                            .foregroundStyle(.red)
                            
                    }
                    .padding(10)
                    .background(.pink.opacity(0.001))
                    .cornerRadius(10)
                    Spacer()
                    // Botón de notificaciones
                    Button(action: {
                        showingNotifications.toggle()
                    }) {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .sheet(isPresented: $showingNotifications) {
                        NotificationsView()
                            .background(Color.pink.opacity(0.1))
                    }
                    
            
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color.pink.opacity(0.01))
                
                // Contenido principal con tabs
                TabView {
                    NoticiasView()
                        .tabItem {
                            Image(systemName: "newspaper.fill")
                            Text("Noticias")
                        }
                        .background(Color.pink.opacity(0.2))
                    
                    AvisosyApoyos()
                        .tabItem {
                            Image(systemName: "bell.fill")
                            Text("Avisos")
                        }
                        .background(Color.pink.opacity(0.2))
                    
                    ConsumeLocalView()
                        .tabItem {
                            Image(systemName: "bag.fill")
                            Text("Consume Local")
                        }
                        .background(Color.pink.opacity(0.2))
                    
                    DondeIrView()
                        .tabItem {
                            Image(systemName: "figure.walk")
                            .foregroundStyle(.pink)
                            Text("¿A dónde ir?")
                        }
                        .background(Color.pink.opacity(0.2))
                }
                
               
            }
        }
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
                .listRowBackground(Color.pink.opacity(0.1))
                
                NotificationRow2(
                    icon: "calendar",
                    color: .blue,
                    title: "Evento cultural",
                    message: "Festival de primavera este fin de semana",
                    time: "Ayer"
                )
                .listRowBackground(Color.pink.opacity(0.1))
                
                NotificationRow2(
                    icon: "wrench.fill",
                    color: .gray,
                    title: "Mantenimiento",
                    message: "Cierre parcial de Línea 1 del Metro",
                    time: "20/04/24"
                )
                .listRowBackground(Color.pink.opacity(0.1))
            }
            .navigationTitle("Notificaciones")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Listo") {}
                }
            }
            .background(Color.pink.opacity(0.2))
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
                .background(.pink)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
                
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
