import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/page/salons/bloc/salons_cubit.dart';
import 'package:weli/service/model/entities/index.dart';

class ContactList extends StatefulWidget {
  final List<Profile> contactList;
  final SalonsCubit bloc;

  const ContactList({Key? key, required this.contactList, required this.bloc}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [SizedBox(height: 1.h), ...widget.contactList.asMap().entries.map((e) => contactElement(e.value)).toList()],
      ),
    );
  }

  Widget contactElement(Profile profile) {
    return GestureDetector(
      onTap: () {
        widget.bloc.updateUserIdSelected(profile.id!);
        setState(() {});
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 1.h),
        child: Row(
          children: [
            ProfileAvatar(size: 13.w, pictureUrl: profile.pictureUrl, isOnline: false, firstName: profile.firstName),
            SizedBox(width: 2.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.w),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: const Color(0xFFB0B0B0).withOpacity(0.4)),
              child: Row(
                children: [
                  SizedBox(
                    width: 35.w,
                    child: Text(
                      '${profile.firstName} ${profile.lastName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColor.textColor, fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ),
                  widget.bloc.userIdSelected.contains(profile.id)
                      ? Icon(Icons.check_box_outlined, color: Colors.black, size: 6.w)
                      : SizedBox(width: 6.w)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
