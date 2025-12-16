import 'package:flutter/material.dart';
import 'package:tarea_2_multimedia/models/persona.dart';

//PersonalPage será StatefulWidget porque al ser un formulario modificará su
//estado y su texto continuamente.
class PersonalPage extends StatefulWidget {
  final Persona persona;
  const PersonalPage({super.key, required this.persona});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  // Tras investigar, al separar clases por temas de StatefulWidget, Dart nos proporciona
  // widget. como una especie de "this." para poder hacer llamadas a los datos.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gómez')),
      body: Center(
        child: Column(
          children: [
            Text(style: TextStyle(fontSize: 30), widget.persona.nombre),
            Text(style: TextStyle(fontSize: 30), widget.persona.apellidos),
            Text(
              style: TextStyle(fontSize: 30),
              // Ponemos una vista más adecuada para la fecha de nacimiento.
              "${widget.persona.fechaNacimiento.day}-${widget.persona.fechaNacimiento.month}-${widget.persona.fechaNacimiento.year}",
            ),
            Text(style: TextStyle(fontSize: 30), widget.persona.correo),
            Text(style: TextStyle(fontSize: 30), widget.persona.contrasenya),
            //ElevatedButton por estilo
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, widget.persona);
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
