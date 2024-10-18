import 'package:flutter/material.dart';
import 'package:manajemenpariwisata/bloc/ulasan_bloc.dart';
import 'package:manajemenpariwisata/models/ulasan.dart';
import 'package:manajemenpariwisata/ui/ulasan_form.dart'; // Form to create/update ulasan
import 'package:manajemenpariwisata/ui/ulasan_detail.dart'; // Ulasan detail page

class UlasanPage extends StatefulWidget {
  const UlasanPage({Key? key}) : super(key: key);

  @override
  _UlasanPageState createState() => _UlasanPageState();
}

class _UlasanPageState extends State<UlasanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Ulasan'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UlasanForm()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                // Implement your logout logic here
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: UlasanBloc.getUlasans(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListUlasan(list: snapshot.data)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListUlasan extends StatelessWidget {
  final List? list;
  const ListUlasan({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemUlasan(
          ulasan: list![i],
        );
      },
    );
  }
}

class ItemUlasan extends StatelessWidget {
  final Ulasan ulasan;
  const ItemUlasan({Key? key, required this.ulasan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UlasanDetail(
              ulasan: ulasan,
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(ulasan.reviewer!),
          subtitle: Text('Rating: ${ulasan.rating} \nComments: ${ulasan.comments}'),
        ),
      ),
    );
  }
}
