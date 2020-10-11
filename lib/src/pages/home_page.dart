import 'package:flutter/material.dart';
import 'package:parcelacion/src/pages/nueva_materia.dart';
import 'package:parcelacion/src/providers/materiaProvider.dart';
import 'package:parcelacion/src/providers/parcelacion_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Parcelación'),
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
          return GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: snapshot.data.map((e) {
                return InkWell(
                  child: Card(
                    child: Column(
                      children: [
                        Image(image: AssetImage('assets/images/background-2.jpg')),
                        Container(
                          child: Text(e.nombre,style: TextStyle(fontWeight:FontWeight.bold),),
                        ),
                        Center(
                          child: FutureBuilder(
                            future: ParcelacionProvider().getDefinitiva(e.id),
                            builder: (context, AsyncSnapshot<double> snapshot) {
                              return Text(snapshot.hasData ? snapshot.data.toStringAsFixed(1) : '0.0');
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).pushNamed('materia',arguments: e.id);
                  },
                );
              }).toList(),
          );
        }
      )
    );
  }


}
