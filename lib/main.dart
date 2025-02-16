import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(AutoServiceApp());
}

class AutoServiceApp extends StatelessWidget {
  const AutoServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Service',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> pages = [HomePage(), CalendarPage(), StatisticsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('STM-Garage')),
      body: pages[selectedIndex],

      ///page
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Acasa'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Statistici',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppoimentCard extends StatelessWidget {
  final String carName;
  final String date;

  const AppoimentCard({super.key, required this.carName, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              carName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              date,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(Object context) {
    // TODO: implement build

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bun venit!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  final Map<DateTime, List<String>> _events = {};
  CalendarFormat _calendarFormat = CalendarFormat.month;

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }

  void _addEvent() {
    setState(() {
      _events[_selectedDay] = _events[_selectedDay] ?? [];
      _events[_selectedDay]!.add("Programare la service");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          TableCalendar(
            rowHeight: 43,
            locale: "en_US",
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            availableGestures: AvailableGestures.all,
            focusedDay: _selectedDay,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            calendarFormat: _calendarFormat,
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
          ),
          ElevatedButton(
            onPressed: _addEvent,
            child: Text("Adaugă programare"),
          ),
          Expanded(
            child: ListView(
              children:
                  _events[_selectedDay]
                      ?.map((event) => ListTile(title: Text(event)))
                      .toList() ??
                  [],
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(Object context) {
    // TODO: implement build

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistici generale',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatCard(title: 'Programari', value: '12'),
                StatCard(title: 'incasari', value: '5000 RON'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// void main() {
//   runApp(AutoServiceApp());
// }

// class AutoServiceApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Auto Service',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MainScreen(),
//     );
//   }
// }

// class CalendarPage extends StatefulWidget {
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }

// class _CalendarPageState extends State<CalendarPage> {
//   DateTime _selectedDay = DateTime.now();
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   Map<DateTime, List<String>> _events = {};

//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     setState(() {
//       _selectedDay = selectedDay;
//     });
//   }

//   void _addEvent() {
//     setState(() {
//       _events[_selectedDay] = _events[_selectedDay] ?? [];
//       _events[_selectedDay]!.add("Programare la service");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Calendar'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Calendar',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             DropdownButton<CalendarFormat>(
//               value: _calendarFormat,
//               onChanged: (CalendarFormat? newFormat) {
//                 if (newFormat != null) {
//                   setState(() {
//                     _calendarFormat = newFormat;
//                   });
//                 }
//               },
//               items: [
//                 DropdownMenuItem(
//                   value: CalendarFormat.month,
//                   child: Text("Lunar"),
//                 ),
//                 DropdownMenuItem(
//                   value: CalendarFormat.twoWeeks,
//                   child: Text("Bi-săptămânal"),
//                 ),
//                 DropdownMenuItem(
//                   value: CalendarFormat.week,
//                   child: Text("Săptămânal"),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TableCalendar(
//                   firstDay: DateTime.utc(2020, 1, 1),
//                   lastDay: DateTime.utc(2030, 12, 31),
//                   focusedDay: _selectedDay,
//                   selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
//                   calendarFormat: _calendarFormat,
//                   onDaySelected: _onDaySelected,
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: _addEvent,
//               child: Text("Adaugă programare"),
//             ),
//             Expanded(
//               child: ListView(
//                 children: _events[_selectedDay]?.map((event) => ListTile(title: Text(event))).toList() ?? [],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
