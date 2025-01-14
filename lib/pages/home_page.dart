import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart'; // Asegúrate de importar el paquete correcto

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final Uuid uuid = Uuid(); // Crear una instancia de Uuid

  Future<void> insertarUsuario() async {
    final nombre = _nombreController.text.trim();
    final apellido = _apellidoController.text.trim();

    if (nombre.isEmpty || apellido.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete ambos campos.')),
      );
      return;
    }

    try {
      final response = await Supabase.instance.client.from('Usuarios').insert({
        'id': uuid.v4(), // Generar un UUID para el ID
        'nombre': nombre,
        'apellido': apellido,
      });

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario insertado con éxito.')),
        );
        _nombreController.clear();
        _apellidoController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.error!.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error inesperado: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _apellidoController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: insertarUsuario,
              child: const Text('Aceptar'),
            ),
          ],
        ),
      ),
    );
  }
}
