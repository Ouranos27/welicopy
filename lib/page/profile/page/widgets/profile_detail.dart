import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/fragments/chip.dart';
import 'package:weli/fragments/widgets/profile_avatar.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/service/model/entities/index.dart';

class ProfileDetail extends StatelessWidget {
  final Profile data;
  final Widget? actionButton;

  const ProfileDetail({
    required this.data,
    this.actionButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(1.5.h),
            child: ProfileAvatar(
              size: 30.w,
              fontSize: 15.w,
              margin: EdgeInsets.all(2.h),
              pictureUrl: data.pictureUrl,
              firstName: data.firstName,
            ),
          ),
          Text(
            "${data.firstName ?? ""} ${data.lastName ?? ""}",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 1.h),
          Text(
            "${data.job ?? S.of(context).no_data} ${data.entreprise != null ? "•" : ""} ${data.entreprise ?? ""}",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            data.city != null ? '${data.city} (${'${data.department} '.substring(0, 2)})' : S.of(context).no_data,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 1.h),
          if (actionButton != null) actionButton!,
          SizedBox(height: 1.h),
          if (data.investment != null)
            Wrap(
              children: data.investment!
                  .map(
                    (e) => ChipElement(
                      onPressed: () {},
                      color: const Color(0xFFFEB42B).withOpacity(0.5),
                      child: Text(
                        e,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppColor.chipTextColor,
                            ),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
