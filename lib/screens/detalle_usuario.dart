import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmaj_test_app/providers/usuario_provider.dart';
import 'package:provider/provider.dart';
import 'package:gmaj_test_app/models/user.dart';

class DetalleUsuario extends StatelessWidget {
  final User usuario;
  const DetalleUsuario(this.usuario, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profesores'),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: Container(),
        ),
        drawer: Drawer(),
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Stack(
                children: [
                  Image.network(
                    usuario.avatar,
                    fit: BoxFit.fitWidth,
                    height: 275,
                    width: double.infinity,
                  ),
                  Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                          color: Colors.black45,
                          child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '${usuario.firstName} ${usuario.lastName}',
                                style: TextStyle(
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w300),
                                textScaleFactor: 2,
                              )))),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Contacto',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic),
                            textScaleFactor: 1.5,
                          )),
                    ]),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: Text('${usuario.email}'),
                      icon: Icon(CupertinoIcons.mail_solid),
                    ),
                    IconButton(
                        onPressed: () => context
                            .read<UsuarioProvider>()
                            .agregarRemoverUsuarioAFavoritos(usuario.id),
                        icon: Consumer<UsuarioProvider>(
                            builder: (context, data, _) {
                          bool esFavorito =
                              data.listadoFavoritos.contains(usuario.id);
                          return Icon(
                            esFavorito
                                ? CupertinoIcons.heart_solid
                                : CupertinoIcons.heart_circle_fill,
                            size: 40,
                            color:
                                esFavorito ? Colors.red[400] : Colors.white60,
                          );
                        })),
                  ],
                ),
              )
            ])));
  }
}
