import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TarjetaMedicion extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final List<FlSpot> datos;

  TarjetaMedicion(
      {required this.titulo, required this.icono, required this.datos});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icono, size: 50),

                // Añade un espacio entre el icono y el texto

                SizedBox(width: 10),
                Text(titulo, style: TextStyle(fontSize: 20)),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity, // Ajusta el ancho del gráfico
              height: 40, // Ajusta la altura del gráfico
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: datos,
                      isCurved: true,
                      barWidth: 3,
                      colors: [Colors.green],
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
