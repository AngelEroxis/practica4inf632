import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Manejo de Eventos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventManager(),
    );
  }
}

class EventManager extends StatefulWidget {
  @override
  _EventManagerState createState() => _EventManagerState();
}

class _EventManagerState extends State<EventManager> {
  List<Event> events = [];
  TextEditingController _dateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  void _addEvent() {
    String date = _dateController.text;
    String description = _descriptionController.text;

    if (date.isNotEmpty && description.isNotEmpty) {
      setState(() {
        events.add(Event(date, description));
      });

      // Limpiar los campos de texto
      _dateController.clear();
      _descriptionController.clear();
    }
  }

  void _removeEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manejo de Eventos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Fecha del Evento',
                hintText: 'Ej. 2024-11-10',
              ),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción del Evento',
                hintText: 'Ej. Reunión con equipo',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addEvent,
              child: Text('Registrar Evento'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${events[index].date} - ${events[index].description}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeEvent(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  String date;
  String description;

  Event(this.date, this.description);
}
