import 'package:flutter/material.dart';
import 'package:flutter_pokemon/Pokemon.dart';

class Details extends StatelessWidget {

  final Pokemon pokemon;

  //this means we will get a pokemon object from main class through constructor

  Details({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,

        title: Text(pokemon.name),
        elevation: 0.0,
      ),

      body: bodyWidget(context), //Here passing context for screen sizes


    );
  }

  bodyWidget(BuildContext context) =>
      Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery
                .of(context)
                .size
                .height / 1.7,
            left: 10.0,
            width: MediaQuery
                .of(context)
                .size
                .width - 20,
            top: MediaQuery
                .of(context)
                .size
                .height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 100.0,
                  ),

                  Text(pokemon.name, style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),),
                  Text('Height : ${pokemon.height}'),
                  //string interpolation in dart
                  Text('Weight :${pokemon.weight}'),
                  Text('Types'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pokemon.type.map((t) =>
                        FilterChip(label: Text(t),
                            backgroundColor: Colors.amber,
                            onSelected: (b) {})).toList(),
                  ),
                  Text('Weakness'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses.map((f) =>
                        FilterChip(label: Text(
                          f, style: TextStyle(color: Colors.white),),
                            backgroundColor: Colors.red,
                            onSelected: (b) {})).toList(),
                  )
                ],

              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(pokemon.img),
                        fit: BoxFit.cover)
                ),
              ),
            ),
          )
        ],
      );
}
