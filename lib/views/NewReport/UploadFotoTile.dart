import 'dart:io';

import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reportapp/provider/ReportProvider.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class UploadFotoTile extends StatefulWidget {
  final bool isEnableUpload;

  const UploadFotoTile({this.isEnableUpload});

  @override
  _UploadFotoTileState createState() => _UploadFotoTileState();
}

class _UploadFotoTileState extends State<UploadFotoTile> {
  final picker = ImagePicker();
  ReportProvider provider;

  @override
  void initState() {
    provider = Provider.of<ReportProvider>(context, listen: false);
    provider.images.clear();
    super.initState();
  }

  removeList(index) {
    setState(() {
      provider.images.removeAt(index);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _imgFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        provider.images.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      if (pickedFile != null) {
        provider.images.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Widget showThumbnail({thumbnail, index}) {
    return Padding(
      padding: const EdgeInsets.all(SpacingDimens.spacing8),
      child: Stack(
        // fit: StackFit.expand,
        // overflow: Overflow.clip,
        children: [
          Container(
            width: SpacingDimens.spacing88,
            height: SpacingDimens.spacing88,
          ),
          Positioned(
            top: 5,
            right: 6,
            child: Container(
              width: 87,
              height: 87,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SpacingDimens.spacing8),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: FileImage(
                    thumbnail,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: widget.isEnableUpload ? () => removeList(index) : (){},
              child: Icon(
                Icons.cancel,
                color: PaletteColor.grey60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        color: PaletteColor.primarybg,
        height: MediaQuery.of(context).size.height * 0.15,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SpacingDimens.spacing8,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: provider.images.length,
                  itemBuilder: (context, index) {
                    return showThumbnail(
                      thumbnail: provider.images[0],
                      index: index,
                    );
                  },
                ),
                GestureDetector(
                  onTap: widget.isEnableUpload ? () => _showPicker(context) : (){},
                  child: provider.images.length <1
                      ? Padding(
                          padding: const EdgeInsets.all(
                            SpacingDimens.spacing8,
                          ),
                          child: FDottedLine(
                            color: Colors.lightBlue[600],
                            strokeWidth: 2.0,
                            dottedLength: 10.0,
                            space: 2.0,
                            child: Container(
                              padding: EdgeInsets.all(
                                SpacingDimens.spacing8,
                              ),
                              height: SpacingDimens.spacing88,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: PaletteColor.primary,
                                    size: 14,
                                  ),
                                  Text(
                                    'Tambah Foto',
                                    style: TypographyStyle.mini.merge(
                                      TextStyle(color: PaletteColor.primary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
