import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupee_day/Network/index.dart';
import 'package:rupee_day/common/common_image.dart';
import 'package:rupee_day/common/common_snackbar.dart';
import 'package:rupee_day/util/colors_util.dart';

class ImageGridView extends StatefulWidget {
  final bool isUpload;
  final List<String>? images;
  final ValueChanged<List<String>>? onChanged;
  const ImageGridView({super.key, this.isUpload = true, this.images, this.onChanged});

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  List<File> files = [];
  List<String> uploadedImages = [];

  @override
  Widget build(BuildContext context) {
    var itemWidth = (MediaQuery.of(context).size.width - 2 * 12 - 2 * 10) / 3;
    var itemHeight = itemWidth * (90.0 / 100);
    Widget addBtn = InkWell(
      onTap: _pickImage,
      child: SizedBox(
        width: itemWidth,
        height: itemHeight,
        child: const CommonImage(
          src: 'asset/icons/add_img_icon.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );

    Widget wrapper(File file) {
      return Container(
        width: itemWidth,
        height: itemHeight,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Image.file(file, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 26,
                decoration: BoxDecoration(color: ColorsUtil.hexColor(0xffffff, alpha: 0.4), borderRadius: BorderRadius.circular(13)),
                child: IconButton(onPressed: () => _deleteFile(file), icon: const CommonImage(src: 'asset/icons/img_del_icon.png')),
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> getList() {
      if (widget.isUpload) {
        List<Widget> widgets = files.map((file) => wrapper(file)).toList();

        if (widgets.length < 9) {
          widgets = widgets..add(addBtn);
        }
        return widgets;
      } else {
        return widget.images
                ?.map(
                  (imgUrl) => Container(
                    width: itemWidth,
                    height: itemHeight,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: CommonImage(src: imgUrl, fit: BoxFit.cover),
                  ),
                )
                .toList() ??
            [];
      }
    }

    return Wrap(spacing: 12, runSpacing: 10, children: getList());
  }

  void _deleteFile(File currentImg) {
    int index = files.indexOf(currentImg);
    setState(() {
      files.removeAt(index);
      uploadedImages.removeAt(index);
      if (widget.onChanged != null) widget.onChanged!(uploadedImages);
    });
  }

  void _pickImage() async {
    PermissionStatus status = await Permission.photos.request();
    if (status != PermissionStatus.granted) {
      return CommonSnackbar.showSnackbar(
        'You did not allow us to access the Photo Library, which will help you obtain a loan. Would you like to set up authorization.',
        type: SnackType.info,
      );
    }

    ImagePicker picker = ImagePicker();
    var imgFile = await picker.pickImage(source: ImageSource.gallery);
    if (imgFile == null) return;
    var imgUrl = await NetworkApi.uploadFeedbackImage(imgFile.path);
    uploadedImages.add(imgUrl);
    if (widget.onChanged != null) {
      widget.onChanged!(uploadedImages);
    }

    setState(() {
      files.add(File(imgFile.path));
    });
  }
}
