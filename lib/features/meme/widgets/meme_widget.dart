import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meminder/app/functions/images/image_functions.dart';
import 'package:meminder/features/meme/models/meme_model.dart';

class MemeWidget extends StatelessWidget {
  final MemeModel meme;
  const MemeWidget({
    super.key,
    required this.meme,
  });

  Widget memeText({
    required String text,
    required BuildContext context,
  }) {
    return Container(
      height: 0.1.sh,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        memeText(
          text: meme.upperText ?? "",
          context: context,
        ),
        Image.memory(
          getBytesFromBase64(
            meme.image!.split(",").last.toString(),
          ),
          height: 0.5.sh,
          gaplessPlayback: true,
          fit: BoxFit.cover,
        ),
        memeText(
          text: meme.lowerText ?? '',
          context: context,
        ),
      ],
    );
  }
}
