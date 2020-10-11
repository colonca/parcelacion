import 'package:flutter/material.dart';
import 'package:parcelacion/src/pages/materia_page.dart';
import 'package:parcelacion/src/pages/nueva_materia.dart';
import 'package:parcelacion/src/providers/materiaProvider.dart';
import 'package:parcelacion/src/providers/parcelacion_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('NotaApp'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context){
                  return NuevaMateriaForm();
                })
              );
            },)
        ]

      ),
      body: FutureBuilder(
        future: MateriaProvider().getMaterias(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          return ListView(
            children: snapshot.data.map((e){
              return FutureBuilder(
                future: ParcelacionProvider().getDefinitiva(e.id),
                builder: (context, AsyncSnapshot<double>snapshot) {
                  return ListTile(
                    title: Text('${e.nombre} Def: ${snapshot.data.toStringAsFixed(2)}'),
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MateriaPage(id: e.id,)
                        )
                      );
                    },
                  );
                },
              );
            }).toList(),
          );
        }
      )
    );
  }


}
