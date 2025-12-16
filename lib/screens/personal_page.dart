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
  // Tras investigar, utilizaremos controladores de texto declarados primero como Late.
  late TextEditingController nombreControlador;
  late TextEditingController apellidosControlador;
  late TextEditingController emailControlador;
  late TextEditingController contrasenyaControlador;
  late DateTime fechaSeleccionada;

  @override
  //Iniciamos los controladores.
  void initState() {
    super.initState();
    nombreControlador = TextEditingController(text: widget.persona.nombre);
    apellidosControlador = TextEditingController(
      text: widget.persona.apellidos,
    );
    emailControlador = TextEditingController(text: widget.persona.correo);
    contrasenyaControlador = TextEditingController(
      text: widget.persona.contrasenya,
    );
    fechaSeleccionada = widget.persona.fechaNacimiento;
  }

  @override
  //Dispose para cerrar las memorias y que no haya fuga de rendimiento.
  void dispose() {
    nombreControlador.dispose();
    apellidosControlador.dispose();
    emailControlador.dispose();
    contrasenyaControlador.dispose();
    super.dispose();
  }

  // Tras investigar, al separar clases por temas de StatefulWidget, Dart nos proporciona
  // widget. como una especie de "this." para poder hacer llamadas a los datos.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gómez')),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: nombreControlador,
              style: TextStyle(fontSize: 30),
            ),
            TextField(
              controller: apellidosControlador,
              style: TextStyle(fontSize: 30),
            ),
            //Utilizaremos un gestureDetector al click, para abrir el calendario.
            GestureDetector(
              onTap: () {
                _seleccionarFecha();
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Text(
                  "${fechaSeleccionada.day}-${fechaSeleccionada.month}-${fechaSeleccionada.year}",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Divider(color: Colors.black, thickness: 1.0),
            TextField(
              controller: emailControlador,
              style: TextStyle(fontSize: 30),
            ),
            TextField(
              controller: contrasenyaControlador,
              style: TextStyle(fontSize: 30),
            ),
            //ElevatedButton por estilo
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  Persona(
                    nombre: nombreControlador.text,
                    apellidos: apellidosControlador.text,
                    fechaNacimiento: fechaSeleccionada,
                    correo: emailControlador.text,
                    contrasenya: contrasenyaControlador.text,
                  ),
                );
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  //Creación del método seleccionarFecha con el fin de poner un calendario más orientativo para el usuario.
  Future<void> _seleccionarFecha() async {
    final DateTime? fechaEscogida = await showDatePicker(
      context: context,
      initialDate: fechaSeleccionada,
      firstDate: DateTime(1950),
      lastDate: DateTime(2007),
    );

    if (fechaEscogida != null && fechaEscogida != fechaSeleccionada) {
      setState(() {
        fechaSeleccionada = fechaEscogida;
      });
    }
  }
}
