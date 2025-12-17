import 'package:flutter/material.dart';

// Aqui hemos decidido que sea StatefulWidget porque los Widget utilizados implican
// redibujar el estado de WidgetPage.
class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  // Creamos una lista de nombres para usar como objeto ejemplo. Se utiliza ListTile.
  List<String> objetos = ['Rubén', 'Pedro', 'María'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dismissible & Draggable')),
      body: Column(
        children: [
          // Creamos un mensaje para que sepa el usuario que se puede hacer.
          const ListTile(
            leading: Icon(Icons.info, color: Colors.blue),
            title: Text('Desliza para borrar un nombre o arrástralo al cubo.'),
          ),
          // Aqui se expandirá la lista de nombres que ocupara el centro.
          // Se utiliza expanded para ocupar el espacio disponible.
          Expanded(
            //Se utiliza ListView para la cantidad de nombres, aunque tengamos solo 3
            child: ListView(
              children: objetos.map((item) => _crearItem(item)).toList(),
            ),
          ),
          _crearCubo(),
        ],
      ),
    );
  }

  // MÉTODOS WIDGET

  Widget _crearItem(String item) {
    // Dismissible sirve para poder borrar objetos deslizando a la dirección que indiques.
    return Dismissible(
      key: Key(item),
      direction: DismissDirection
          .endToStart, // En este caso borra de derecha a izquierda.
      onDismissed: (direction) {
        setState(() {
          objetos.remove(item);
        });
      },

      //Aqui le hemos puesto un fondo que se ve en el slider cuando se desliza para borrar.
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        title: Text(item),
        //Aqui utilizamos Draggable que sirve para coger un objeto y moverlo.
        trailing: Draggable<String>(
          data: item, // Lo que se mueve será el nombre
          feedback: Material(
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.blueAccent,
              child: Text(item, style: TextStyle(color: Colors.white)),
            ),
          ),
          childWhenDragging: const Icon(Icons.drag_handle, color: Colors.grey),
          child: const Icon(Icons.drag_handle),
        ),
      ),
    );
  }

  Widget _crearCubo() {
    // Utilizamos este widget para crear un recipiente que detecta cuando le soltamos un objeto encima.
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 100,
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            // Si hay un objeto sobre la caja donde vamos a droppear, se pone verde.
            color: candidateData.isNotEmpty
                ? Colors.green[200]
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: candidateData.isNotEmpty ? Colors.green : Colors.grey,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_outline,
                size: 40,
                color: candidateData.isNotEmpty
                    ? Colors.green
                    : Colors.grey[600],
              ),
              const Text('Suelta aquí para eliminar'),
            ],
          ),
        );
      },
      // Se ejecuta al soltar el nombre sobre el recuadro
      onAcceptWithDetails: (details) {
        setState(() {
          objetos.remove(details.data); // Borrar el nombre soltado
        });
        // Mensaje de aviso como que se ha eliminado.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${details.data} eliminado en la papelera.')),
        );
      },
    );
  }
}
