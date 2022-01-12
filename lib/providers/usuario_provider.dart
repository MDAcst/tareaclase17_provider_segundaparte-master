import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gmaj_test_app/models/user.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioProvider extends ChangeNotifier {
  final List<User> _usuarios = [];
  List<User> get usuarios => _usuarios;

  List<int> _listadoFavoritos = [];
  List<int> get listadoFavoritos => _listadoFavoritos;

  bool get estaCargandoDatos => _estaCargandoDatos;
  bool _estaCargandoDatos = false;

  agregarRemoverUsuarioAFavoritos(int idUsuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_listadoFavoritos.contains(idUsuario)) {
      _listadoFavoritos.remove(idUsuario);
    } else {
      _listadoFavoritos.add(idUsuario);
    }
    final List<String> listado =
        List.from(_listadoFavoritos.map((id) => id.toString()).toList());
    prefs.setStringList('listadoFavoritos', listado);
    notifyListeners();
  }

  Future getUserData() async {
    _estaCargandoDatos = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String datosJson;
    notifyListeners();
    try {
      Client http = Client();
      Uri uri = Uri.parse('https://reqres.in/api/users');
      Response respuesta = await http.get(uri);
      prefs.setString('datosDeInternet', respuesta.body);
      datosJson = respuesta.body;
      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      datosJson = prefs.getString('datosDeInternet');
    }
    Map map = jsonDecode(datosJson);
    List<User> listaDeUsuarios =
        List<User>.from(map["data"].map((x) => User.fromJson(x)));
    _usuarios.clear();
    _usuarios.addAll(listaDeUsuarios);
    _estaCargandoDatos = false;
    notifyListeners();
  }
}
