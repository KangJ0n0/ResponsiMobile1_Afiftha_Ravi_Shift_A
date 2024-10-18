import 'package:flutter/material.dart';
import 'package:manajemenpariwisata/bloc/ulasan_bloc.dart';
import 'package:manajemenpariwisata/models/ulasan.dart';
import 'package:manajemenpariwisata/ui/ulasan_form.dart';
import 'package:manajemenpariwisata/ui/ulasan_page.dart';
import 'package:manajemenpariwisata/widget/warning_dialog.dart';

// ignore: must_be_immutable
class UlasanDetail extends StatefulWidget {
  Ulasan? ulasan;
  UlasanDetail({Key? key, this.ulasan}) : super(key: key);

  @override
  _UlasanDetailState createState() => _UlasanDetailState();
}

class _UlasanDetailState extends State<UlasanDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Ulasan'),
        backgroundColor: Colors.grey[800],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Reviewer : ${widget.ulasan!.reviewer}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Rating : ${widget.ulasan!.rating}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Comments : ${widget.ulasan!.comments}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
// Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[600], // Dark gray button color
            foregroundColor: Colors.white, // White text color for button
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UlasanForm(
                  ulasan: widget.ulasan!,
                ),
              ),
            );
          },
        ),

// Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[600], // Dark gray button color
            foregroundColor: Colors.white, // White text color for button
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.grey[800],
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        // tombol hapus
        OutlinedButton(
          child: const Text(
            "Ya",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            UlasanBloc.deleteUlasan(id: (widget.ulasan!.id!)).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UlasanPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.red),
          ),
        ),
        OutlinedButton(
          child: const Text(
            "Batal",
            style: TextStyle(color: Color.fromARGB(255, 141, 81, 81)),
          ),
          onPressed: () => Navigator.pop(context),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey[300]!),
          ),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
