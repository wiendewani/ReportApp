import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/component/AppBar/Indicator/IndicatorLoad.dart';
import 'package:reportapp/config/globalKeySharedPref.dart';
import 'package:reportapp/provider/ReportProvider.dart';
import 'package:reportapp/provider/UserProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reportapp/theme/TypographyStyle.dart';
import 'package:reportapp/utils/FieldReport.dart';
import 'package:reportapp/views/NewReport/UploadFotoTile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewReportPage extends StatefulWidget {
  @override
  _NewReportPageState createState() => _NewReportPageState();
}

class _NewReportPageState extends State<NewReportPage> {
  final TextEditingController _tiketController = new TextEditingController();
  final TextEditingController _tanggalController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _pelaporController = new TextEditingController();
  final TextEditingController _alamatController = new TextEditingController();
  final TextEditingController _kejadianController = new TextEditingController();
  final TextEditingController _tindakLanjutController =
      new TextEditingController();

  List _listGender = [
    "Kominfo Kota Malang",
    "Irfak Wahyudi",
    "A. Yahya Hudan",
    "Muhammad Andy",
    "Abdullah Winasis",
    "Hendra Danang"
  ];
  String _valGender;
  String urlPhoto;
  bool isPhotoNull;
  bool isChange;
  final picker = ImagePicker();
  bool _load = false;
  final DateFormat dateFormat = DateFormat('EEEE, dd MMMM yyyy',"id_ID");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  loadOn() => setState(() => _load = true);

  loadOff() => setState(() => _load = false);
  UsersProvider userProvider;




  void sendPengajuanMasjid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString(GlobalKeySharedPref.idUser);
    loadOn();
    Map<String, String> data = new Map();
    data[FieldPengajuan.kejadian] = _kejadianController.text;
    data[FieldPengajuan.lokasi_kejadian] = _alamatController.text;
    data[FieldPengajuan.tanggal] = selectedDate.toString();
    data[FieldPengajuan.petugas] = _valGender;
    data[FieldPengajuan.nama_pelapor] = _pelaporController.text;
    data[FieldPengajuan.tindak_lanjut] = _tindakLanjutController.text;
    data[FieldPengajuan.id_user] = idUser;

    Provider.of<ReportProvider>(context, listen: false)
        .postReport(
        data: data).then((value) {
      if (value == 200) {
        loadOff();
        Navigator.pop(context);
      } else {
        loadOff();
        showSnackbar('Gagal Mengirim Data');
      }
    });


  }


  void showSnackbar(String content) {
    final snackBar = SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _tanggalController.text = DateFormat.yMd().format(selectedDate);
      });
  }



  @override
  void initState() {
    userProvider = Provider.of<UsersProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _tiketController.dispose();
    _tanggalController.dispose();
    _emailController.dispose();
    _pelaporController.dispose();
    _tindakLanjutController.dispose();
    _kejadianController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  Widget _editField(
      {String title,
      String hint,
      TextInputType type,
      TextEditingController controller,
      bool isEnable,
      bool isMandatory}) {
    return Column(
      children: [
        SizedBox(
          height: SpacingDimens.spacing36,
        ),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: TypographyStyle.mini.merge(
              TextStyle(
                color: PaletteColor.grey60,
              ),
            ),
          ),
        ),
        Container(
          color: isEnable ? Colors.transparent : PaletteColor.grey40,
          child: TextFormField(
            validator: isMandatory
                ? (value) {
                    if (value.isEmpty) {
                      return 'Input tidak Boleh Kosong';
                    }
                    return null;
                  }
                : (value) => null,
            enabled: isEnable,
            controller: controller,
            cursorColor: PaletteColor.primary,
            keyboardType: type,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: SpacingDimens.spacing16,
                top: SpacingDimens.spacing8,
                bottom: SpacingDimens.spacing8,
              ),
              hintText: hint,
              hintStyle: TypographyStyle.paragraph.merge(
                TextStyle(
                  color: PaletteColor.grey60,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: PaletteColor.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _load
        ? Container(
            color: Colors.black26,
            width: double.infinity,
            height: double.infinity,
            child: new Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Center(
                child: indicatorLoad(),
              ),
            ),
          )
        : Container();

    return Stack(
      children: [
        Scaffold(

          appBar: AppBar(
            backgroundColor: PaletteColor.primary,
            title: Text(
              'Report Page',
              style: TypographyStyle.subtitle0.merge(
                TextStyle(color: PaletteColor.primarybg),
              ),
            ),
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: SpacingDimens.spacing16,
              horizontal: SpacingDimens.spacing24,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tambah Gambar",
                      style: TypographyStyle.caption.merge(
                        TextStyle(
                          color: PaletteColor.grey60,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SpacingDimens.spacing8,
                    ),
                    UploadFotoTile(
                      isEnableUpload: true,
                    ),

                    SizedBox(
                      height: SpacingDimens.spacing36,
                    ),

                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Tanggal",
                        style: TypographyStyle.mini.merge(
                          TextStyle(
                            color: PaletteColor.grey60,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SpacingDimens.spacing16,
                    ),

                    Row(
                     children: [

                       Container(
                         padding: EdgeInsets.only(right: SpacingDimens.spacing16),
                         child: Text(
                           dateFormat.format(selectedDate),
                         ),
                       ),

                       InkWell(
                           onTap: () {
                             _selectDate(context);
                           },
                           child: Icon(Icons.calendar_today_outlined, color: PaletteColor.primary,)
                       ),
                     ],
                    ),


                    _editField(
                      title: "Kejadian",
                      hint: "Masukkan Kejadian",
                      type: TextInputType.text,
                      controller: _kejadianController,
                      isEnable: true,
                      isMandatory: true,
                    ),
                    SizedBox(
                      height: SpacingDimens.spacing36,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Nama Petugas",
                        style: TypographyStyle.mini.merge(
                          TextStyle(
                            color: PaletteColor.grey60,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text("Pilih Petugas", style: TypographyStyle.paragraph,),
                        value: _valGender,
                        items: _listGender.map(
                              (e) {
                            return DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            _valGender = value;
                          });
                        },
                      ),
                    ),
                    _editField(
                      title: "Nama Pelapor",
                      hint: "Masukkan Nama Pelapor",
                      type: TextInputType.name,
                      controller: _pelaporController,
                      isEnable: true,
                      isMandatory: true,
                    ),
                    _editField(
                      title: "Tindak Lanjut",
                      hint: "Masukkan Tindak Lanjut",
                      type: TextInputType.text,
                      controller: _tindakLanjutController,
                      isEnable: true,
                      isMandatory: true,
                    ),
                    _editField(
                      title: "Lokasi Kejadian",
                      hint: "Masukkan Alamat",
                      type: TextInputType.streetAddress,
                      controller: _alamatController,
                      isEnable: true,
                      isMandatory: true,
                    ),
                    SizedBox(
                      height: SpacingDimens.spacing40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: PaletteColor.primary,
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
//                          uploadProfile();
                          sendPengajuanMasjid();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: SpacingDimens.spacing48,
                        child: Text(
                          'Tambah Report',
                          style: TypographyStyle.subtitle1.merge(
                            TextStyle(color: PaletteColor.primarybg),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          child: loadingIndicator,
          alignment: FractionalOffset.center,
        )
      ],
    );
  }

//  uploadProfile() {
//    loadOn();
//    print("isPhoto null? $isPhotoNull");
//    if (isChange) {
//      Provider.of<UpdateUserProvider>(context, listen: false)
//          .uploadImage(
//        token: Provider.of<UsersProvider>(context, listen: false).token,
//        nama: _tiketController.text,
//        alamat: _pelaporController.text,
//        idUser: Provider.of<UsersProvider>(context, listen: false)
//            .user
//            .data
//            .id
//            .toString(),
//        jenisKelamin: _valGender,
//        noTelp: _tanggalController.text,
//        photo: _image,
//      )
//          .then(
//            (value) {
//          if (value == 200) {
//            var user = Provider.of<UsersProvider>(context, listen: false);
//            user.getUsers(user.user.data.id, user.token);
//            navigatePopUp();
//          }
//          loadOff();
//        },
//      );
//    } else {
//      Provider.of<UpdateUserProvider>(context, listen: false)
//          .updateProfile(
//        token: Provider.of<UsersProvider>(context, listen: false).token,
//        nama: _tiketController.text,
//        alamat: _pelaporController.text,
//        idUser: Provider.of<UsersProvider>(context, listen: false)
//            .user
//            .data
//            .id
//            .toString(),
//        jenisKelamin: _valGender,
//        noTelp: _tanggalController.text,
//      )
//          .then(
//            (value) {
//          if (value == 200) {
//            var user = Provider.of<UsersProvider>(context, listen: false);
//            user.getUsers(user.user.data.id, user.token);
//            navigatePopUp();
//          }
//          print("berhasil");
//          loadOff();
//        },
//      );
//    }
//  }

  void navigatePopUp() {
    Navigator.pop(context);
  }
}
