import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pokemon/Pokemon.dart';
import 'package:flutter_pokemon/pokedetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() =>
    runApp(MaterialApp(
      title: 'Pokemon App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal,

      ),
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  PokeHub pokeHub;
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List<Pokemon> pokemonList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //gives you structure
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pokemon Go', style: TextStyle(color: Colors.white),),

      ),
      body: FutureBuilder<PokeHub>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(crossAxisCount: 2,
                children: pokeHub.pokemon.map((Pokemon pokemon) =>
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>
                            Details(
                              pokemon: pokemon,
                            )));
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Hero(
                              tag: pokemon.img,
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(pokemon.img),

                                  ),
                                ),

                              ),
                            ),
                            Text(pokemon.name, style: TextStyle(
                              fontSize: 22.0,
                            ),)
                          ],
                        ),

                      ),
                    )).toList());
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return
            Center(
              child: CircularProgressIndicator(),
            );
        },
      ),


      drawer: Drawer(

      ),
      floatingActionButton:
      FloatingActionButton(onPressed: () {},
        child: Icon(Icons.refresh,
          color: Colors.white,
        ),
//        backgroundColor: Colors.teal,
//        foregroundColor: Colors.white,
      ),
    );
  }

  Future<PokeHub> fetchData() async
  {
    var res = await http.get(url);

    if (res.statusCode == 200) {
      pokeHub = PokeHub.fromJson(json.decode(res.body));
      return pokeHub;
    } else
      throw Exception('Failed to parse');


//    print(decodeJson);
//    pokeHub = PokeHub.fromJson(decodeJson);
//
//    pokemonList = pokeHub.pokemon;
//    print(pokemonList.length);
  }
}

