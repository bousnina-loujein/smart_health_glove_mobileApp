import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../widgets/sensor_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Health Glove – Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            onPressed: () => AuthService.instance.signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${user?.email ?? 'User'}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            const Text('Live Sensor Readings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirestoreService.instance.liveReadingsStream(limit: 50),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final docs = snapshot.data?.docs ?? [];
                  if (docs.isEmpty) {
                    return const Center(child: Text('No data yet. Push sensor data from ESP32 or use the + button to simulate.'));
                  }
                  return ListView.separated(
                    itemCount: docs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final d = docs[index].data();
                      return SensorCard(
                        timestamp: (d['ts'] as Timestamp?)?.toDate(),
                        finger: (d['finger'] ?? 'F1').toString(),
                        angle: (d['angle'] ?? 0).toDouble(),
                        tremor: (d['tremor'] ?? 0.0).toDouble(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => FirestoreService.instance.simulateOneReading(),
        icon: const Icon(Icons.add),
        label: const Text('Simulate'),
      ),
    );
  }
}
