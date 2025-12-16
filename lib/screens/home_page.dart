import 'package:flutter/material.dart';
import 'package:tarea_2_multimedia/models/persona.dart';
import 'personal_page.dart';

// Creamos HomePage como StatefulWidget porque necesitará cambiar su estado cuando
// creemos otro de los widgets, concretamete PersonalPage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // Utilizamos createState para almacenar los datos y que flutter no redibuje todo el widget
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Persona? personaRecibida;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PF2')),
      body: Center(
        child: Column(
          children: [
            // Le ponemos un poco más de tamaño de fuente para que se aprecie mejor.
            Text("¡Bienvenidos!", style: TextStyle(fontSize: 30)),
            // Flutter permite condiciones en children. Si la persona recibida es diferente de null
            // mostrará los datos indicados en pantalla.
            if (personaRecibida != null)
              Text(
                "Recibido instancia de Persona: ${personaRecibida!.nombre} ${personaRecibida!.apellidos}",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ElevatedButton(
              // con Async y Await lo que haremos es una sincronización de esperar a que estén
              // los datos para ser mandados a home_page
              onPressed: () async {
                final miPersona = Persona(
                  nombre: 'Rubén',
                  apellidos: 'Gómez Hernández',
                  fechaNacimiento: DateTime(1990, 11, 28),
                  correo: 'rubengomez@paucasesnovescifp.cat',
                  contrasenya: '12345',
                );
                final datosDevueltos = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalPage(persona: miPersona),
                  ),
                );

                if (datosDevueltos != null) {
                  setState(() {
                    personaRecibida = datosDevueltos;
                  });
                }
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
