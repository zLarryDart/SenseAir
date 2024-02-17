import 'package:flutter/material.dart';
import 'weather_api.dart'; // Asegúrate de tener este archivo y ruta correctos

class PantallaTiempo extends StatefulWidget {
  @override
  _PantallaTiempoState createState() => _PantallaTiempoState();
}

class _PantallaTiempoState extends State<PantallaTiempo> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic> _datosTiempo = {};
  bool _cargando = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _actualizarTiempo({String ciudad = 'Madrid'}) async {
    setState(() {
      _cargando = true;
    });
    try {
      final datos = await WeatherApi.obtenerPronosticoDelTiempo(ciudad);
      setState(() {
        _datosTiempo = datos;
        _cargando = false;
      });
    } catch (e) {
      setState(() {
        _datosTiempo = {};
        _cargando = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener datos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Pronóstico del Tiempo'),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Introduce tu ciudad',
                labelStyle: TextStyle(
                    color: Colors
                        .green), // Opcional: También puedes hacer verde el texto del label
                // Contorno normal
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Colors.green, // Define el color del borde aquí
                    width: 60.0, // Ajusta el ancho del borde si lo deseas
                  ),
                ),
                // Contorno cuando el TextField está enfocado
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color:
                        Colors.green, // Define el color del borde enfocado aquí
                    width:
                        2.0, // A menudo se hace el borde enfocado ligeramente más ancho
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.green,
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _actualizarTiempo(ciudad: _controller.text);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: _cargando
                  ? Center(child: CircularProgressIndicator())
                  : _datosTiempo.isNotEmpty
                      ? _construirVistaTiempo()
                      : Text('Introduce una ciudad para ver el tiempo.'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirVistaTiempo() {
    return ListView(
      children: <Widget>[
        Text(
          _controller.text,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30, width: 30, key: Key('espacio')),
        _crearElementoTiempo(Icons.thermostat_outlined,
            "${_datosTiempo['main']['temp']}°C", "Temperatura"),
        _crearElementoTiempo(Icons.water_drop,
            "${_datosTiempo['main']['humidity']}%", "Humedad"),
        // Puedes expandir con más datos aquí
      ],
    );
  }

  Widget _crearElementoTiempo(IconData icon, String dato, String etiqueta) {
    return ListTile(
      leading: Icon(icon, size: 50, color: Colors.blue),
      title: Text(dato, style: const TextStyle(fontSize: 50)),
      subtitle: Text(etiqueta, style: const TextStyle(fontSize: 30)),
    );
  }
}
