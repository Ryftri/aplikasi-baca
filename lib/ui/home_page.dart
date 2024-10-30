import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'home_page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pengguna"),
      ),
      body: Expanded(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users') // Ganti 'messages' dengan 'users'
              .orderBy('created_at', descending: true) // Mengurutkan berdasarkan 'created_at'
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("Tidak ada data pengguna ditemukan"));
            } else {
              final userList = snapshot.data!.docs;
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final userData = userList[index].data(); // Ambil data pengguna
                  return ListTile(
                    title: Text(userData['username'] ?? 'Username tidak tersedia'), // Tampilkan username
                    subtitle: Text(userData['email'] ?? 'Email tidak tersedia'), // Tampilkan email
                    trailing: Text(userData['created_at']?.toDate().toString() ?? 'Tanggal tidak tersedia'), // Tampilkan tanggal
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
