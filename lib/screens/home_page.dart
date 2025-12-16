import 'package:flutter/material.dart';
import 'package:tarea_2_multimedia/models/persona.dart';

// Creamos HomePage como StatefulWidget porque necesitará cambiar su estado cuando
// creemos otro de los widgets, concretamete PersonalPage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // Utilizamos createState para almacenar los datos y que flutter no redibuje todo el widget
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PF2')),
      body: Center(
        child: Column(
          children: [
            // Le ponemos un poco más de tamaño de fuente para que se aprecie mejor.
            Text("¡Bienvenidos!", style: TextStyle(fontSize: 30)),
            ElevatedButton(
              onPressed: () {
                final miPersona = Persona(
                  nombre: 'Rubén',
                  apellidos: 'Gómez Hernández',
                  fechaNacimiento: DateTime(1990, 11, 28),
                  correo: 'rubengomez@paucasesnovescifp.cat',
                  contrasenya: '12345',
                );
              },
              child: Text('Ir a Personal Page'),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Ir a Widget Page')),
          ],
        ),
      ),
    );
  }
}
