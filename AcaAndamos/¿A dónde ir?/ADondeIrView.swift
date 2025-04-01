//
//  ADondeIr.swift
//  AcaAndamos
//
//  Created by CEDAM 11 on 31/03/25.
//
//
//  ADondeIr.swift
//  AcaAndamos
//
//  Created by CEDAM 11 on 31/03/25.
//

import Combine
import ARKit
import SwiftUI
import MapKit
import CoreLocation

struct DondeIrView: View {

    @State private var selectedCategory = "Todos"
    @State private var showARView = false
    @State private var searchText = ""
    
    let categories = ["Todos", "Cultura", "Gastronomía", "Naturaleza", "Históricos", "Entretenimiento"]
    
    let lugares = [
        Lugar(
            nombre: "Museo Frida Kahlo",
            descripcion: "La Casa Azul, hogar de la artista más icónica de México",
            categoria: "Cultura",
            imagen: "Frida_Kahlo",
            ubicacion: CLLocationCoordinate2D(latitude: 19.3554, longitude: -99.1622),
            horario: "10:00 - 17:30",
            precio: "$250 MXN"
        ),
        Lugar(
            nombre: "Bosque de Chapultepec",
            descripcion: "El pulmón de la ciudad con lagos y museos",
            categoria: "Naturaleza",
            imagen: "chapultepec",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4209, longitude: -99.1885),
            horario: "05:00 - 20:00",
            precio: "Gratis"
        ),
        Lugar(
            nombre: "Palacio de Bellas Artes",
            descripcion: "Arquitectura art nouveau y murales famosos",
            categoria: "Históricos",
            imagen: "Bellas_artes",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4352, longitude: -99.1412),
            horario: "11:00 - 17:00",
            precio: "$80 MXN"
        ),
        Lugar(
            nombre: "Zócalo de la Ciudad de México",
            descripcion: "Plaza principal con historia azteca y colonial, corazón político y cultural",
            categoria: "Históricos",
            imagen: "Zocalo",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332),
            horario: "Todo el día",
            precio: "Gratis"
        ),

        Lugar(
            nombre: "Museo Nacional de Antropología",
            descripcion: "Tesoro de culturas prehispánicas con la Piedra del Sol como pieza estrella",
            categoria: "Cultura",
            imagen: "MuseoAntropologia",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4260, longitude: -99.1861),
            horario: "09:00 - 19:00",
            precio: "$90 MXN"
        ),
        Lugar(
            nombre: "Xochimilco",
            descripcion: "Canales prehispánicos donde navegar en trajineras con música y comida",
            categoria: "Naturaleza",
            imagen: "Xochimilco",
            ubicacion: CLLocationCoordinate2D(latitude: 19.2674, longitude: -99.1063),
            horario: "09:00 - 18:00",
            precio: "$500 MXN por trajinera (hasta 10 personas)"
        ),

        Lugar(
            nombre: "Castillo de Chapultepec",
            descripcion: "Único castillo real en América, con vista panorámica de la ciudad",
            categoria: "Históricos",
            imagen: "CastilloChapultepec",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4206, longitude: -99.1817),
            horario: "09:00 - 17:00",
            precio: "$90 MXN"
        ),

        Lugar(
            nombre: "Mercado de Coyoacán",
            descripcion: "Colorido mercado con artesanías y comida tradicional como quesadillas de huitlacoche",
            categoria: "Gastronomía",
            imagen: "MercadoCoyoacan",
            ubicacion: CLLocationCoordinate2D(latitude: 19.3494, longitude: -99.1613),
            horario: "08:00 - 20:00",
            precio: "$50-$150 MXN por platillo"
        ),

        Lugar(
            nombre: "Torre Latinoamericana",
            descripcion: "Mirador con vistas 360° y museo de la historia de la ciudad",
            categoria: "Entretenimiento",
            imagen: "TorreLatino",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4339, longitude: -99.1406),
            horario: "09:00 - 22:00",
            precio: "$150 MXN"
        ),

        Lugar(
            nombre: "Biblioteca Vasconcelos",
            descripcion: "Joy arquitectónica con libros flotantes y jardín botánico",
            categoria: "Cultura",
            imagen: "BibliotecaVasconcelos",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4406, longitude: -99.1528),
            horario: "08:30 - 19:30",
            precio: "Gratis"
        ),

        Lugar(
            nombre: "Salón Corona",
            descripcion: "Cantina clásica fundada en 1928 con los mejores tacos de canasta",
            categoria: "Gastronomía",
            imagen: "SalonCorona",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4350, longitude: -99.1405),
            horario: "12:00 - 02:00",
            precio: "$80-$200 MXN"
        ),

        Lugar(
            nombre: "Foro Sol",
            descripcion: "El escenario más grande para conciertos con capacidad para 65,000 personas",
            categoria: "Entretenimiento",
            imagen: "ForoSol",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4047, longitude: -99.0973),
            horario: "Varía por evento",
            precio: "$500-$3000 MXN"
        ),

        Lugar(
            nombre: "MUAC (Museo Universitario Arte Contemporáneo)",
            descripcion: "Vanguardia artística en la UNAM con obras de artistas internacionales",
            categoria: "Cultura",
            imagen: "MUAC",
            ubicacion: CLLocationCoordinate2D(latitude: 19.3276, longitude: -99.1836),
            horario: "10:00 - 18:00",
            precio: "$40 MXN"
        ),
        Lugar(
            nombre: "Basílica de Guadalupe",
            descripcion: "Santuario religioso más visitado de América, hogar de la Virgen Morena",
            categoria: "Históricos",
            imagen: "Basilica",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4846, longitude: -99.1173),
            horario: "06:00 - 21:00",
            precio: "Gratis"
        ),
        Lugar(
            nombre: "Casa de los Azulejos",
            descripcion: "Palacio barroco del siglo XVI con fachada de cerámica de Puebla",
            categoria: "Históricos",
            imagen: "Azulejos",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4344, longitude: -99.1403),
            horario: "07:00 - 22:00",
            precio: "$200 MXN (consumición mínima en café)"
        ),

        Lugar(
            nombre: "Museo Soumaya",
            descripcion: "Colección privada con obras de Dalí y Rodin en edificio futurista",
            categoria: "Cultura",
            imagen: "Soumaya",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4419, longitude: -99.2056),
            horario: "10:30 - 18:30",
            precio: "Gratis"
        ),

        Lugar(
            nombre: "Parque La Mexicana",
            descripcion: "Área verde moderna con lago artificial y pistas para correr",
            categoria: "Naturaleza",
            imagen: "LaMexicana",
            ubicacion: CLLocationCoordinate2D(latitude: 19.3788, longitude: -99.2625),
            horario: "06:00 - 23:00",
            precio: "Gratis"
        ),

        Lugar(
            nombre: "Pujol",
            descripcion: "Restaurante estrella Michelin con menú degustación de alta cocina mexicana",
            categoria: "Gastronomía",
            imagen: "Pujol",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4268, longitude: -99.1936),
            horario: "13:00 - 21:00",
            precio: "$2,500 MXN (menú)"
        ),

        Lugar(
            nombre: "Arena México",
            descripcion: "Catedral de la lucha libre con eventos los martes, viernes y domingos",
            categoria: "Entretenimiento",
            imagen: "Arena",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4195, longitude: -99.1558),
            horario: "Eventos nocturnos",
            precio: "$200-$1,500 MXN"
        ),

        Lugar(
            nombre: "Museo del Juguete Antiguo (MUJAM)",
            descripcion: "Colección nostálgica de 45,000 juguetes mexicanos de los años 30-90",
            categoria: "Cultura",
            imagen: "MUJAM",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4430, longitude: -99.1428),
            horario: "09:00 - 18:00",
            precio: "$100 MXN"
        ),

        Lugar(
            nombre: "Tianguis Cultural del Chopo",
            descripcion: "Mercado alternativo de música, arte y moda underground",
            categoria: "Entretenimiento",
            imagen: "Chopo",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4414, longitude: -99.1470),
            horario: "Sábados 11:00 - 18:00",
            precio: "Gratis (compras variables)"
        ),

        Lugar(
            nombre: "Cineteca Nacional",
            descripcion: "Templo del cine con proyecciones al aire libre y restaurantes gourmet",
            categoria: "Entretenimiento",
            imagen: "cineteca",
            ubicacion: CLLocationCoordinate2D(latitude: 19.3557, longitude: -99.1623),
            horario: "12:00 - 22:00",
            precio: "$70 MXN (boleto)"
        ),

        Lugar(
            nombre: "Alameda Central",
            descripcion: "Primer parque urbano de América con fuentes art nouveau y murales",
            categoria: "Naturaleza",
            imagen: "alameda",
            ubicacion: CLLocationCoordinate2D(latitude: 19.4362, longitude: -99.1443),
            horario: "05:00 - 20:00",
            precio: "Gratis"
        )
    ]
    
    var filteredLugares: [Lugar] {
        if selectedCategory == "Todos" {
            return lugares
        } else {
            return lugares.filter { $0.categoria == selectedCategory }
        }
    }
    
    var searchResults: [Lugar] {
        guard !searchText.isEmpty else { return [] }
        return filteredLugares.filter {
            $0.nombre.localizedCaseInsensitiveContains(searchText) ||
            $0.descripcion.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                MapContainerView(lugares: filteredLugares/*, userLocation: locationManager.location?.coordinate*/)
                
                VStack(spacing: 0) {
                    SearchBar(searchText: $searchText)
                        .padding()
                    
                    CategoriesScrollView(
                        categories: categories,
                        selectedCategory: $selectedCategory
                    )
                    
                    Spacer()
                }
                
                ARButton(showARView: $showARView, lugares: lugares)
                
                if !searchResults.isEmpty {
                    SearchResultsView(lugares: searchResults)
                }
            }
            .navigationTitle("¿A dónde ir?")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    RandomRouteButton(action: generarRutaAleatoria)
                }
            }
        }
        .accentColor(Color("CDMXBlue"))
    }



    
    func generarRutaAleatoria() {
        print("Ruta generada!")
    }
}

// MARK: - Subvistas

struct MapContainerView: View {
    var lugares: [Lugar]
    var userLocation: CLLocationCoordinate2D?
    
    var body: some View {
        MapView(lugares: lugares, userLocation: userLocation)
            .edgesIgnoringSafeArea(.top)
    }
}

struct CategoriesScrollView: View {
    let categories: [String]
    @Binding var selectedCategory: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories, id: \.self) { category in
                    CategoryPill(
                        category: category,
                        isSelected: selectedCategory == category,
                        action: { selectedCategory = category }
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}


struct ARButton: View {
    @Binding var showARView: Bool
    var lugares: [Lugar]
    
    var body: some View {
        Button(action: { showARView.toggle() }) {
            Image(systemName: "viewfinder.circle.fill")
                .font(.system(size: 40))
                .foregroundColor(.black)
                .padding()
                .background(Color.accentColor)
                .clipShape(Circle())
                .shadow(radius: 10)
        }
        .padding()
        .sheet(isPresented: $showARView) {
            ARContainerView(lugares: lugares)
        }
    }
}

struct SearchResultsView: View {
    var lugares: [Lugar]
    
    var body: some View {
        LugaresListView(lugares: lugares)
            .frame(height: 300)
            .transition(.move(edge: .bottom))
    }
}

struct RandomRouteButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "dice.fill")
                .foregroundStyle(.blue)
        }
    }
}



// MARK: - Vistas de soporte

struct ARContainerView: View {
    var lugares: [Lugar]
    
    var body: some View {
        ARView(lugares: lugares)
    }
}

// Resto de tus estructuras (MapView, ARView, Lugar, LugaresListView, LugarCard, LugarDetailView) permanecen iguales
struct MapView: UIViewRepresentable {
    var lugares: [Lugar]
    var userLocation: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        // Centrar mapa en CDMX
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
        mapView.setRegion(region, animated: true)
        
        // Añadir marcadores
        mapView.removeAnnotations(mapView.annotations)
        for lugar in lugares {
            let annotation = MKPointAnnotation()
            annotation.title = lugar.nombre
            annotation.coordinate = lugar.ubicacion
            mapView.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard !(annotation is MKUserLocation) else { return nil }
            
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "lugar")
            annotationView.glyphImage = UIImage(systemName: "mappin.circle.fill")
            annotationView.markerTintColor = UIColor(Color(.pink))
            return annotationView
        }
    }
}



struct ARView: UIViewControllerRepresentable {
    var lugares: [Lugar]
    
    func makeUIViewController(context: Context) -> ARViewController {
        let viewController = ARViewController()
        viewController.lugares = lugares
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {}
}

class ARViewController: UIViewController, ARSCNViewDelegate {
    var lugares: [Lugar] = []
    var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView = ARSCNView(frame: view.frame)
        view.addSubview(sceneView)
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let config = ARWorldTrackingConfiguration()
        sceneView.session.run(config)
        
        añadirLugaresEnAR()
    }
    
    func añadirLugaresEnAR() {
        for _ in lugares {
            let node = SCNNode()
            node.geometry = SCNSphere(radius: 0.1)
            node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
            node.position = SCNVector3(
                x: Float.random(in: -1...1),
                y: Float.random(in: -0.5...0.5),
                z: Float.random(in: -1...1)
            )
            sceneView.scene.rootNode.addChildNode(node)
        }
    }
}
struct Lugar: Identifiable {
    let id = UUID()
    let nombre: String
    let descripcion: String
    let categoria: String
    let imagen: String
    let ubicacion: CLLocationCoordinate2D
    let horario: String
    let precio: String
}


struct LugaresListView: View {
    var lugares: [Lugar]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                ForEach(lugares) { lugar in
                    NavigationLink(destination: LugarDetailView(lugar: lugar)) {
                        LugarCard(lugar: lugar)
                    }
                    .buttonStyle(PlainButtonStyle()) // Elimina el efecto de opacidad al tocar
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
    }
}

// Componente reutilizable para cada tarjeta de lugar
struct LugarCard: View {
    let lugar: Lugar
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Imagen del lugar
            Image(lugar.imagen)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue.opacity(0.2), lineWidth: 1)
                )
            
            // Detalles del lugar
            VStack(alignment: .leading, spacing: 6) {
                Text(lugar.nombre)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(lugar.descripcion)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(2)
                
                HStack(spacing: 10) {
                    // Categoría
                    HStack(spacing: 4) {
                        Image(systemName: "tag.fill")
                            .font(.caption2)
                            .foregroundColor(.black)
                        Text(lugar.categoria)
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Precio
                    HStack(spacing: 4) {
                        Image(systemName: "pesosign.circle.fill")
                            .font(.caption2)
                            .foregroundColor(.green)
                        Text(lugar.precio)
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            
            Spacer()
            
            // Ícono de navegación
            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

// Vista de detalle del lugar (ejemplo básico)
struct LugarDetailView: View {
    let lugar: Lugar
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(lugar.imagen)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    
                    .cornerRadius(30)
                    
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .blue.opacity(0.3)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(lugar.nombre)
                        .font(.title)
                        .bold()
                    
                    HStack(spacing: 15) {
                        Label(lugar.categoria, systemImage: "tag.fill")
                        Label(lugar.precio, systemImage: "pesosign.circle.fill")
                        Label(lugar.horario, systemImage: "clock.fill")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    Divider()
                    
                    Text(lugar.descripcion)
                        .font(.body)
                    
                    // Botón para abrir en Maps
                    Button(action: {
                        let url = URL(string: "http://maps.apple.com/?ll=\(lugar.ubicacion.latitude),\(lugar.ubicacion.longitude)&q=\(lugar.nombre.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!
                        UIApplication.shared.open(url)
                    }) {
                        HStack {
                            Image(systemName: "map.fill")
                            Text("Abrir en Maps")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .padding(.top)
                }
                .padding(30)
            }
            .padding(.horizontal)
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    
    DondeIrView()
}
