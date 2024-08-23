import 'package:flutter/material.dart';

class PackageBooking extends StatefulWidget {
  const PackageBooking({super.key});

  @override
  _PackageBookingState createState() => _PackageBookingState();
}

class _PackageBookingState extends State<PackageBooking> {
  int _adultCount = 0;
  int _childCount = 0;
  final int _maxAdults = 20;
  final int _maxChildren = 2;
  final List<Map<String, dynamic>> _travellers = [];

  void _addTraveller(String type) {
    setState(() {
      if (type == 'Adult' && _adultCount < _maxAdults) {
        _travellers.add({'type': 'Adult', 'name': '', 'age': '', 'gender': ''});
        _adultCount++;
      } else if (type == 'Child' && _childCount < _maxChildren) {
        _travellers.add({'type': 'Child', 'name': '', 'age': '', 'gender': ''});
        _childCount++;
      }
    });
  }

  void _removeTraveller(int index) {
    setState(() {
      if (_travellers[index]['type'] == 'Adult') {
        _adultCount--;
      } else if (_travellers[index]['type'] == 'Child') {
        _childCount--;
      }
      _travellers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Package Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Travel Date: 17-07-2024'),
                Text('Price: AED 240000.0'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text('Adult'),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _adultCount > 0
                              ? () => _removeTraveller(_travellers.indexWhere((t) => t['type'] == 'Adult'))
                              : null,
                        ),
                        Text('$_adultCount'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _adultCount < _maxAdults ? () => _addTraveller('Adult') : null,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: <Widget>[
                    const Text('Child'),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _childCount > 0
                              ? () => _removeTraveller(_travellers.indexWhere((t) => t['type'] == 'Child'))
                              : null,
                        ),
                        Text('$_childCount'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _childCount < _maxChildren ? () => _addTraveller('Child') : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _travellers.length,
                itemBuilder: (context, index) {
                  return TravellerForm(
                    index: index,
                    traveller: _travellers[index],
                    onRemove: () => _removeTraveller(index),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle confirm action
              },
              child: const Text('CONFIRM'),
            ),
          ],
        ),
      ),
    );
  }
}

class TravellerForm extends StatelessWidget {
  final int index;
  final Map<String, dynamic> traveller;
  final VoidCallback onRemove;

  const TravellerForm({super.key, required this.index, required this.traveller, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Traveller ${index + 1} (${traveller['type']})'),
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => traveller['name'] = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              onChanged: (value) => traveller['age'] = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Gender'),
              onChanged: (value) => traveller['gender'] = value,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}