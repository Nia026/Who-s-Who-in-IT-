import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: Text('Our Team', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color(0xFFD4D4F8),
      ),
      backgroundColor: Color(0xFFD4D4F8),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildTeamCard('Nia Rizqika Febria Rahma', '23091397051', '2023B', 'assets/images/unesa_logo.png'),
            buildTeamCard('Rachmah Fia Putri Dewi', '23091397057', '2023B', 'assets/images/unesa_logo.png'),
            buildTeamCard('Arum Sekar Wijayanti', '23091397064', '2023B', 'assets/images/unesa_logo.png'),
          ],
        ),
      ),
    );
  }

  Widget buildTeamCard(String name, String nim, String kelas, String imagePath) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              imagePath,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Nama: $name\nNIM: $nim\nKelas: $kelas',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}