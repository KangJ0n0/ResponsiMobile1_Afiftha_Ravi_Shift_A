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
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
// Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
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
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
//tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            UlasanBloc.deleteUlasan(id:(widget.ulasan!.id!))
                .then(
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
        ),

//tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
