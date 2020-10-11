import 'package:flutter/material.dart';
import 'package:parcelacion/src/pages/parcelacion.dart';
import 'package:parcelacion/src/providers/cortes_provider.dart';
import 'package:parcelacion/src/providers/materiaProvider.dart';
import 'package:parcelacion/src/providers/parcelacion_provider.dart';

class MateriaPage extends StatelessWidget {
  final int id;

  MateriaPage({Key key,@required this.id}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    final size  = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: MateriaProvider().getMateria(this.id),
          builder: (context, snapshot) {
            return Text(snapshot.hasData ? snapshot.data.nombre : '');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: CorteProvider().getCortes(),
          initialData: [],
          builder: (context, AsyncSnapshot<List> snapshot) {
            final data = snapshot.hasData ? snapshot.data : [];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: data.map((e){
                    return InkWell(
                      child: Container(
                        width: size.width*0.3,
                        height: size.height*0.3,
                        color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text(e.nombre),),
                            SizedBox(height: 20,),
                            Center(child: FutureBuilder(
                              future: ParcelacionProvider().getNotaPorCorte(e.id, this.id),
                              builder: (context, AsyncSnapshot<double> snapshot) {
                                 return Text(snapshot.data.toStringAsFixed(2));
                              },
                            ),),
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ParcelacionPage(corte: e.id,materia: this.id))
                        );
                      },
                    );
                }).toList(),
              );
          },
        )
      ),
    );
  }
}
