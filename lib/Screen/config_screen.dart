import 'package:flutter/material.dart';
import 'package:rental_ps/endpoints/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  ConfigScreenState createState() => ConfigScreenState();
}

class ConfigScreenState extends State<ConfigScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isURLValid = true;

  @override
  void initState() {
    super.initState();
    _loadURL();
  }

  _loadURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('baseURL');
    if (url != null) {
      _urlController.text = url;
    }
  }

  _saveURL() async {
    String url = _urlController.text;
    if (url.isEmpty) {
      setState(() {
        _isURLValid = false;
      });
      _showAlertDialog();
    } else {
      setState(() {
        _isURLValid = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('baseURL', url);
      Endpoints.updateBaseURL(url);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('URL saved successfully')),
      );
    }
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please enter a URL.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input URL'),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(40.0),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Silakan masukkan URL di bawah ini untuk mengonfigurasi pengaturan aplikasi. URL ini akan disimpan dengan aman dan digunakan untuk mengakses sumber daya yang diperlukan untuk aplikasi. Pastikan URL benar dan dapat diakses untuk fungsionalitas yang tepat.',
                style: TextStyle(fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'Enter URL',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isURLValid ? Colors.grey : Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isURLValid ? Colors.grey : Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isURLValid ? Colors.blue : Colors.red,
                  ),
                ),
                prefixIcon: const Icon(Icons.input),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveURL,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
