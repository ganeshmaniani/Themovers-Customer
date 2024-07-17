import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/config.dart';
import '../../../tumpang/tumpang.dart';

class TumpangAdditionalServiceScreen extends ConsumerStatefulWidget {
  const TumpangAdditionalServiceScreen({super.key});

  @override
  ConsumerState<TumpangAdditionalServiceScreen> createState() =>
      _TumpangAdditionalServiceScreenConsumerState();
}

class _TumpangAdditionalServiceScreenConsumerState
    extends ConsumerState<TumpangAdditionalServiceScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialManpower();
  }

  void initialManpower() async {
    String? description =
        ref.watch(tumpangNotifierProvider).tumpangDescription ?? ' ';
    controller = TextEditingController(text: description);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    File? pickedImage = ref.watch(tumpangNotifierProvider).pickedImage;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: Dimensions.kPaddingAllMedium,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tumpang Service',
                  style: textTheme.headlineMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                Dimensions.kVerticalSpaceSmall,
                Text(
                  'Remarks (optional)',
                  style: context.textTheme.titleLarge,
                ),
                Dimensions.kVerticalSpaceSmaller,
                TextFormField(
                  autofocus: true,
                  controller: controller,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  style: context.textTheme.bodySmall,
                  onChanged: (res) {
                    ref
                        .read(tumpangNotifierProvider)
                        .setTumpangDescription(res);
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0x80000000))),
                    border: const OutlineInputBorder(),
                    contentPadding: Dimensions.kPaddingAllSmall,
                    hintText: 'Description',
                    labelStyle: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: Dimensions.kPaddingAllMedium,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                    opacity: 0.70,
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: 'Upload Pictures',
                        style: context.textTheme.labelMedium!
                            .copyWith(color: const Color(0xFF1B293D)),
                      ),
                      TextSpan(
                        text: '(*Required)',
                        style: context.textTheme.labelMedium!
                            .copyWith(color: const Color(0xFFB40205)),
                      )
                    ]))),
                Dimensions.kVerticalSpaceSmall,
                Row(
                  children: [
                    pickedImage != null
                        ? Container(
                            width: 70,
                            height: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    Dimensions.kBorderRadiusAllSmaller,
                                border: Border.all(
                                  width: 0.50,
                                  color: const Color(0xFFB30205),
                                ),
                                image: DecorationImage(
                                  image: FileImage(pickedImage),
                                  fit: BoxFit.fill,
                                )),
                          )
                        : const SizedBox(),
                    pickedImage != null
                        ? Dimensions.kHorizontalSpaceSmall
                        : const SizedBox(),
                    InkWell(
                      onTap: () => _showSelectionDialog(context),
                      borderRadius: Dimensions.kBorderRadiusAllSmaller,
                      child: Container(
                        width: 70,
                        height: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F1F1),
                          borderRadius: Dimensions.kBorderRadiusAllSmaller,
                          border: Border.all(width: 0.50),
                        ),
                        child: Icon(
                          pickedImage == null
                              ? Icons.add
                              : Icons.add_photo_alternate,
                          size: Dimensions.iconSizeMedium,
                          color: context.colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
              height: 0, indent: 16, endIndent: 16, color: Color(0x1AB30205)),
        ],
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("From where do you want to take the photo?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      const Icon(Icons.image),
                      Dimensions.kHorizontalSpaceSmall,
                      const Text("Gallery"),
                    ],
                  ),
                  onTap: () {
                    _pickImage();
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Row(
                    children: [
                      const Icon(Icons.camera),
                      Dimensions.kHorizontalSpaceSmall,
                      const Text("Camera"),
                    ],
                  ),
                  onTap: () {
                    pickCameraImage();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pickCameraImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        File(pickedImage.path);
        ref
            .read(tumpangNotifierProvider)
            .setPickedImage(File(pickedImage.path));
        Navigator.pop(context);
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        File(pickedImage.path);
        ref
            .read(tumpangNotifierProvider)
            .setPickedImage(File(pickedImage.path));
        Navigator.pop(context);
      });
    }
  }
}
