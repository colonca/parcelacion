import 'package:flutter/material.dart';
import 'package:parcelacion/src/models/materia.dart';
import 'package:parcelacion/src/pages/home_page.dart';
import 'package:parcelacion/src/pages/materia_page.dart';
import 'package:parcelacion/src/providers/materiaProvider.dart';

class NuevaMateriaForm  extends StatefulWidget {
  @override
  _NuevaMateriaFormState createState() => _NuevaMateriaFormState();
}

class _NuevaMateriaFormState extends State<NuevaMateriaForm> {

  String _nombre;
  int _codigo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('nueva materia'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
        children: [
          TextField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              hintText: 'codigo de la asignatura',
              icon: Icon(Icons.account_balance_wallet_rounded)
            ),
            onChanged: (value){
              setState(() {
                _codigo = int.parse(value) ;
              });
            },
          ),
          SizedBox(height: 20.0),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'Nombre de la asignatura',
                icon: Icon(Icons.account_balance_wallet_rounded)
            ),
            onChanged: (value){
              setState(() {
                _nombre = value;
              });
            },
          ),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () async{
             final res = await MateriaProvider().newMateria(Materia(id:_codigo,nombre:_nombre));
             Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
            },
            child: Text(
              "Guardar Materia",
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
