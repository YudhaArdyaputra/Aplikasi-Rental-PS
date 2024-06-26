import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rental_ps/dto/create_pesanan.dart';
import 'package:rental_ps/dto/data_login.dart';
import 'package:rental_ps/dto/pelanggan.dart';
import 'package:rental_ps/dto/pesanan.dart';
import 'package:rental_ps/dto/profile.dart';
import 'package:rental_ps/dto/user.dart';
import 'dart:convert';
import 'package:rental_ps/endpoints/endpoints.dart';
import 'package:rental_ps/utils/constants.dart';
import 'package:rental_ps/utils/secure_storage_util.dart';

class DataService {
  // auth
  static Future<String> registerUser(UserDTO user) async {
    final response = await http.post(
      Uri.parse(Endpoints.register),
      body: user.toJson(),
    );

    final responseJson = json.decode(response.body);

    if (response.statusCode == 201) {
      return 'Registration successful!';
    } else {
      return 'Registration failed: ${responseJson['message']}';
    }
  }

  static Future<http.Response> sendLoginData(String username, String password) async {
    final url = Uri.parse(Endpoints.dataLogin);
    final data = {'username': username, 'password': password};

    try {
      final response = await http.post(
        url,
        body: data,
      );
      return response;
    } catch (e) {
      debugPrint("Error during http.post: $e");
      return http.Response('Error', 500);
    }
  }

  static Future<http.Response> logoutData() async {
    final url = Uri.parse(Endpoints.logout);
    final String? accessToken = await SecureStorageUtil.storage.read(key: tokenStoreName);
    debugPrint("Logout with $accessToken");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    return response;
  }

  static Future<DataLogin> fetchProfile(String? accessToken) async {
    accessToken ??= await SecureStorageUtil.storage.read(key: tokenStoreName);

    final response = await http.get(
      Uri.parse(Endpoints.login),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    debugPrint('Profile response: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse;
      try {
        jsonResponse = jsonDecode(response.body);
      } catch (e) {
        throw Exception('Failed to parse JSON: $e');
      }

      try {
        return DataLogin.fromJson(jsonResponse);
      } catch (e) {
        throw Exception('Failed to parse Profile: $e');
      }
    } else {
      throw Exception(
          'Failed to load Profile with status code: ${response.statusCode}');
    }
  }

  // pesanan
  Future<bool> createPesanan(CreatePesananDto dto) async {
    var response = await http.post(
      Uri.parse(Endpoints.createPesanan),
      body: dto.toJson(),
    );

    return response.statusCode == 200;
  }

  Future<List<Pesanan>> fetchPesanan({String orderBy = 'ASC'}) async {
    final response = await http.get(Uri.parse('${Endpoints.readPesanan}?order_by=$orderBy'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['datas'];
      return body.map((dynamic item) => Pesanan.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load pesanan');
    }
  }

  Future<List<Pesanan>> fetchPesananByUser(int idUser, {String orderBy = 'ASC'}) async {
    final response = await http.get(Uri.parse('${Endpoints.readPesananByUser}?id_user=$idUser&order_by=$orderBy'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['datas'];
      return body.map((dynamic item) => Pesanan.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load pesanan');
    }
  }

  Future<void> deletePesanan(int idPesanan) async {
    final response = await http.delete(Uri.parse('${Endpoints.deletePesanan}/$idPesanan'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete pesanan');
    }
  }

  Future<void> updatePesanan(Pesanan pesanan) async {
    final response = await http.put(
      Uri.parse(Endpoints.updatePesanan),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'id_pesanan': pesanan.idPesanan,
        'id_user': pesanan.idUser,
        'tanggal_sewa': pesanan.tanggalSewa,
        'tanggal_kembali': pesanan.tanggalKembali,
        'jenis_ps': pesanan.jenisPs,
        'jumlah_stik': pesanan.jumlahStik,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update pesanan');
    }
  }

  // pelanggan
  static Future<List<Pelanggan>> getPelanggan() async {
    final response = await http.get(Uri.parse(Endpoints.readPelanggan));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['datas'];
      return data.map((e) => Pelanggan.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load pelanggan');
    }
  }

  static Future<void> addPelanggan(String idUser, String nama, String alamat, String noHp) async {
    final response = await http.post(
      Uri.parse(Endpoints.createPelanggan),
      body: {
        'id_user': idUser,
        'nama': nama,
        'alamat': alamat,
        'nohp': noHp,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add pelanggan');
    }
  }

  static Future<void> editPelanggan(String idPelanggan, String idUser, String nama, String alamat, String noHp) async {
    final response = await http.put(
      Uri.parse(Endpoints.updatePelanggan),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id_pelanggan': idPelanggan,
        'id_user': idUser,
        'nama': nama,
        'alamat': alamat,
        'nohp': noHp,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to edit pelanggan');
    }
  }

  static Future<void> deletePelanggan(String idPelanggan) async {
    final response = await http.delete(
      Uri.parse('${Endpoints.deletePelanggan}/$idPelanggan'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete pelanggan');
    }
  }

  // user
  static Future<Profile?> fetchUserData(int idUser) async {
    try {
      final response = await http.get(
        Uri.parse('${Endpoints.readUserById}?id_user=$idUser'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Profile.fromJson(data['datas'][0]);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Failed to load user data: $e');
    }
  }

  static Future<void> updateUserData(int idUser, String namaLengkap, String alamat, String noHp) async {
    try {
      final response = await http.put(
        Uri.parse('${Endpoints.updateUser}/$idUser'),
        body: {
          'nama_lengkap': namaLengkap,
          'alamat': alamat,
          'nohp': noHp,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update user data');
      }
    } catch (e) {
      throw Exception('Failed to update user data: $e');
    }
  }

  static Future<void> uploadImage(int idUser, File imageFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(Endpoints.uploadUserPhoto),
      );
      request.fields['id_user'] = idUser.toString();
      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      if (response.statusCode != 200) {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
