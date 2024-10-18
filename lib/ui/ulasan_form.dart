import 'package:flutter/material.dart';
import 'package:manajemenpariwisata/bloc/ulasan_bloc.dart';
import 'package:manajemenpariwisata/models/ulasan.dart';
import 'package:manajemenpariwisata/ui/ulasan_page.dart';
import 'package:manajemenpariwisata/widget/warning_dialog.dart';

// ignore: must_be_immutable
class UlasanForm extends StatefulWidget {
  Ulasan? ulasan;
  UlasanForm({Key? key, this.ulasan}) : super(key: key);

  @override
  _UlasanFormState createState() => _UlasanFormState();
}

class _UlasanFormState extends State<UlasanForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH ULASAN";
  String tombolSubmit = "SIMPAN";
  final _reviewerTextboxController = TextEditingController();
  final _ratingTextboxController = TextEditingController();
  final _commentsTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.ulasan != null) {
      setState(() {
        judul = "UBAH ULASAN";
        tombolSubmit = "UBAH";
        _reviewerTextboxController.text = widget.ulasan!.reviewer!;
        _ratingTextboxController.text = widget.ulasan!.rating.toString();
        _commentsTextboxController.text = widget.ulasan!.comments!;
      });
    } else {
      judul = "TAMBAH ULASAN";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _reviewerTextField(),
                _ratingTextField(),
                _commentsTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reviewer TextField
  Widget _reviewerTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Reviewer"),
      keyboardType: TextInputType.text,
      controller: _reviewerTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Reviewer harus diisi";
        }
        return null;
      },
    );
  }

  // Rating TextField
  Widget _ratingTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Rating (1-5)"),
      keyboardType: TextInputType.number,
      controller: _ratingTextboxController,
      validator: (value) {
        if (value!.isEmpty || int.tryParse(value) == null || int.parse(value) < 1 || int.parse(value) > 5) {
          return "Rating harus diisi dan bernilai antara 1-5";
        }
        return null;
      },
    );
  }

  // Comments TextField
  Widget _commentsTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Comments"),
      keyboardType: TextInputType.text,
      controller: _commentsTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Comments harus diisi";
        }
        return null;
      },
    );
  }

  // Submit/Update Button
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.ulasan != null) {
              // Update review
              ubah();
            } else {
              // Create new review
              simpan();
            }
          }
        }
      },
    );
  }

  // Save a new review
  simpan() {
    setState(() {
      _isLoading = true;
    });

    Ulasan newUlasan = Ulasan(id: null);
    newUlasan.reviewer = _reviewerTextboxController.text;
    newUlasan.rating = int.parse(_ratingTextboxController.text);
    newUlasan.comments = _commentsTextboxController.text;

    UlasanBloc.addUlasan(ulasan: newUlasan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const UlasanPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ));
    });

    setState(() {
      _isLoading = false;
    });
  }

  // Update an existing review
  ubah() {
    setState(() {
      _isLoading = true;
    });

    Ulasan updatedUlasan = Ulasan(id: widget.ulasan!.id);
    updatedUlasan.reviewer = _reviewerTextboxController.text;
    updatedUlasan.rating = int.parse(_ratingTextboxController.text);
    updatedUlasan.comments = _commentsTextboxController.text;

    UlasanBloc.updateUlasan(ulasan: updatedUlasan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const UlasanPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ));
    });

    setState(() {
      _isLoading = false;
    });
  }
}
