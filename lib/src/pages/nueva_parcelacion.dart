import 'package:flutter/material.dart';
import 'package:parcelacion/src/pages/materia_page.dart';
import 'package:parcelacion/src/pages/parcelacion.dart';
import 'package:parcelacion/src/providers/parcelacion_provider.dart';

class NuevaParcelacion extends StatefulWidget {

  final int corte;
  final int materia;


  NuevaParcelacion({Key key,@required this.corte, @required this.materia}) : super(key:key);

  @override
  _NuevaParcelacionState createState() => _NuevaParcelacionState();
}

class _NuevaParcelacionState extends State<NuevaParcelacion> {

  String nombre;
  double nota;
  double porcentaje;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Parcelacion'),
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
                hintText: 'Nombre de la Parcelación',
                icon: Icon(Icons.account_balance_wallet_rounded)
            ),
            onChanged: (value){
              setState(() {
                this.nombre = value;
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
                hintText: 'Porcentaje',
                icon: Icon(Icons.account_balance_wallet_rounded)
            ),
            onChanged: (value){
              setState(() {
                this.porcentaje = int.parse(value)/100;
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
                hintText: 'Nota',
                icon: Icon(Icons.account_balance_wallet_rounded)
            ),
            onChanged: (value){
              setState(() {
               this.nota = double.parse(value)/1;
              });
            },
          ),
          SizedBox(height: 20.0),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () async{
                print(this.nota);
                final res = await ParcelacionProvider().newParcelacion(nombre,porcentaje,nota,widget.corte,widget.materia);
               if(res != -1){
                 Navigator.of(context).push(
                     MaterialPageRoute(builder: (_) => ParcelacionPage(corte:widget.corte,materia: widget.materia))
                 );
               }else{
                 showDialog(context: context,barrierDismissible: true,
                   builder: (context){
                     return AlertDialog(
                       title: Text('Warning'),
                       content: Text('El porcentaje de notas no puede superar el 100%'),
                     );
                 });
               }
            },
            child: Text(
              "Guardar Parcelacion",
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
