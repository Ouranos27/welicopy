import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weli/config/colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    required this.size,
    Key? key,
    this.firstName,
    this.pictureUrl,
    this.isOnline = false,
    this.fontSize = 20,
    this.margin,
  }) : super(key: key);
  final double size;
  final String? pictureUrl;
  final String? firstName;
  final double? fontSize;
  final bool isOnline;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: margin,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: pictureUrl != null ? Colors.white : AppColor.accentColor,
          border: isOnline ? Border.all(color: const Color(0xFF0FD607), width: 2) : null),
      child: pictureUrl == null
          ? Align(
              alignment: Alignment.center,
              child: Text(
                "$firstName"[0].toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: fontSize, color: Colors.white),
                maxLines: 1,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(180),
              child: CachedNetworkImage(
                imageUrl: pictureUrl!,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
