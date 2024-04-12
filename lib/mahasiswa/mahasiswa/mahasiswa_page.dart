import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rental_ps/dto/news.dart';
import 'package:rental_ps/mahasiswa/mahasiswa/data_mahasiswa.dart';
import 'package:rental_ps/mahasiswa/mahasiswa/tambah_mahasiswa.dart';

class MahasiswaScreen extends StatefulWidget {
  const MahasiswaScreen({Key? key}) : super(key: key);

  @override
  _MahasiswaScreenState createState() => _MahasiswaScreenState();
}

class _MahasiswaScreenState extends State<MahasiswaScreen> {
  //Method
  Future<List<News>> _getData() async {
    try {
      final response = await http.get(
          Uri.parse('https://66038e2c2393662c31cf2e7d.mockapi.io/api/v1/news'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<News> newsList =
            data.map((item) => News.fromJson(item)).toList();
        return newsList;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<void> _deleteData(String id) async {
    try {
      final response = await http.delete(
        Uri.parse(
            'https://66038e2c2393662c31cf2e7d.mockapi.io/api/v1/news/$id'),
      );

      if (response.statusCode == 200) {
        // Refresh data setelah penghapusan berhasil
        setState(() {});
      } else {
        throw Exception('Failed to delete news');
      }
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Mahasiswa')),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your navigation logic here, for example:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MahasiswaBaru()),
          );
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<News>>(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data![index];
                      return Card(
                        elevation: 3,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(post.title),
                                subtitle: Text(post.body),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailMahasiswa(
                                        id: post
                                            .id), // Mengirimkan ID mahasiswa
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Delete"),
                                      content: Text(
                                          "Anda yakin ingin menghapus data ini?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await _deleteData(post.id);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Delete"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Text('No data available');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
