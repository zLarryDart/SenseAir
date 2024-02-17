import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sens_air/TarjetaMedicion.dart';
import 'package:sens_air/pantalla_tiempo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitoreo Ambiental',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo para los gráficos
    List<FlSpot> datosEjemploTemperatura = [
      FlSpot(0, 10),
      FlSpot(1, 70),
      FlSpot(2, 15),
      FlSpot(3, 200),
      FlSpot(4, 22),
      // Añade más puntos aquí
    ];
    List<FlSpot> datosEjemploCo2 = [
      FlSpot(0, 6),
      FlSpot(1, 12),
      FlSpot(2, 1),
      FlSpot(3, 70),
      FlSpot(4, 64),
      // Añade más puntos aquí
    ];

    List<FlSpot> datosEjemploHumedad = [
      FlSpot(0, 60),
      FlSpot(1, 12),
      FlSpot(2, 51),
      FlSpot(3, 3),
      FlSpot(4, 64),
      // Añade más puntos aquí
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Icon(
          Icons.eco,
          size: 50,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          TarjetaMedicion(
            titulo: "Temperatura",
            icono: Icons.thermostat_outlined,
            datos: datosEjemploTemperatura,
          ),
          TarjetaMedicion(
            titulo: "Humedad",
            icono: Icons.water_damage_outlined,
            datos: datosEjemploHumedad,
          ),
          TarjetaMedicion(
            titulo: "CO2",
            icono: Icons.cloud_outlined,
            datos: datosEjemploCo2,
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 50.0, // Ajusta el ancho del botón
        height: 50.0, // Ajusta la altura del botón

        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PantallaTiempo()),
            );
          },
          child: Icon(Icons.sunny, size: 40), // Ajusta el tamaño del ícono aquí
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
