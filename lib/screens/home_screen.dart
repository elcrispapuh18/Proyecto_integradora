import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<String>> _events = {};
  TextEditingController _eventController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario de inseminaciones'),
        elevation: 0,
        backgroundColor: Color.fromRGBO(44, 5, 5, 0.956),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(191, 101, 57, 1),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                eventLoader: _getEventsForDay,
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Color.fromRGBO(44, 5, 5, 0.878),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    shape: BoxShape.circle,
                  ),
                  markersMaxCount: 1,
                  markerDecoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  leftChevronIcon:
                      Icon(Icons.chevron_left, color: Colors.white),
                  rightChevronIcon:
                      Icon(Icons.chevron_right, color: Colors.white),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(44, 5, 5, 0.878),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        backgroundColor: Color.fromRGBO(44, 5, 5, 0.878),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay);
    return events.isEmpty
        ? Center(
            child: Text(
              'No hay eventos para este día.',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          )
        : ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  title: Text(
                    events[index],
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Color.fromRGBO(191, 101, 57, 1),),
                        onPressed: () => _showEditEventDialog(events[index]),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red.shade600),
                        onPressed: () => _deleteEvent(events[index]),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Añadir evento"),
        content: TextField(
          controller: _eventController,
          decoration: InputDecoration(
            hintText: "Escribir evento",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
              _eventController.clear();
            },
          ),
          ElevatedButton(
            child: Text("Guardar"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(191, 101, 57, 1),
            ),
            onPressed: _addEvent,
          ),
        ],
      ),
    );
  }

  void _addEvent() {
    if (_eventController.text.isEmpty) return;
    setState(() {
      if (_events[_selectedDay] != null) {
        _events[_selectedDay]!.add(_eventController.text);
      } else {
        _events[_selectedDay] = [_eventController.text];
      }
    });
    Navigator.of(context).pop();
    _eventController.clear();
  }

  void _showEditEventDialog(String oldEvent) {
    _eventController.text = oldEvent;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Editar evento"),
        content: TextField(
          controller: _eventController,
          decoration: InputDecoration(
            hintText: "Modificar evento",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
              _eventController.clear();
            },
          ),
          ElevatedButton(
            child: Text("Guardar"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(191, 101, 57, 1),
            ),
            onPressed: () => _editEvent(oldEvent),
          ),
        ],
      ),
    );
  }

  void _editEvent(String oldEvent) {
    setState(() {
      _events[_selectedDay]!.remove(oldEvent);
      _events[_selectedDay]!.add(_eventController.text);
    });
    Navigator.of(context).pop();
    _eventController.clear();
  }

  void _deleteEvent(String event) {
    setState(() {
      _events[_selectedDay]!.remove(event);
    });
  }
}
