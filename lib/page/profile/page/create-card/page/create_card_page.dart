import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/data.dart';
import 'package:weli/config/style/styles.dart';
import 'package:weli/fragments/format_currency_text.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/profile/page/create-card/bloc/create_card_cubit.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/utils.dart';

class CreateCardPage extends StatefulWidget {
  final CardData? cardData;

  const CreateCardPage({Key? key, this.cardData}) : super(key: key);

  @override
  State<CreateCardPage> createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  final ValueNotifier<double> _counter = ValueNotifier<double>(0);
  final TextEditingController controller = TextEditingController();

  List<String> get moreDetailsText => [
        'Balcon',
        'Ascenseur',
        'Bonne exposition',
        'Sans vis à vis',
        'Piscine',
        'Suite parentale',
        'Cuisine équipée',
        'Coup de coeur',
        'Parking',
        'Neuf'
      ];
  final moreDetailsImg = [
    'balcony',
    'elevator',
    'sun',
    'building',
    'swim',
    'bed',
    'fridge',
    'house',
    'car',
    'new',
  ];
  List<bool> moreDetails = [];

  bool get isEditable {
    final String? uId = getIt<AuthService>().token?.uid;
    return widget.cardData != null && widget.cardData!.userId == uId || widget.cardData == null;
  }

  var isValidated = false;

  @override
  void initState() {
    moreDetails = widget.cardData != null && widget.cardData!.moreDetails != null
        ? moreDetailsText.map(widget.cardData!.moreDetails!.contains).toList()
        : moreDetailsText.map((e) => false).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocProvider(
        create: (context) => CreateCardCubit(),
        child: BlocConsumer<CreateCardCubit, CreateCardState>(
          listener: (_, state) {
            if (state is CreateCardSuccess) {
              EasyLoading.dismiss();
              Navigator.pop(context);
            }
            if (state is CreateCardLoading) {
              EasyLoading.show();
            }
            if (state is CreateCardFailed) {
              EasyLoading.dismiss();
              Utils.showErrorSnackBar(context, state.message);
            }
          },
          builder: (context, state) => AppScaffold(
            title: S.of(context).myAnnouncement,
            isBack: true,
            body: AbsorbPointer(
              absorbing: !isEditable,
              child: buildBody(context),
            ),
            bottomWidget: widget.cardData == null ? Padding(padding: EdgeInsets.symmetric(horizontal: 10.w), child: progressBar()) : null,
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 3.h),
          SizedBox(
            width: 80.w,
            child: FormBuilder(
              key: context.read<CreateCardCubit>().fbKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormElement(
                    title: S.of(context).title,
                    name: 'title',
                    isRequired: isEditable,
                    validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                    type: FieldType.textField,
                    hintText: 'Maison ancienne',
                    initialValue: widget.cardData?.title,
                    onChanged: (value) => calculateProgress(context),
                  ),
                  title(title: S.of(context).investmentType, isRequired: true),
                  FormElement<List<String>?>(
                    name: 'investment',
                    isRequired: isEditable,
                    type: FieldType.multipleChoice,
                    onChanged: (value) => calculateProgress(context),
                    initialValue: widget.cardData?.investment,
                    itemsMultiChoice: AppData.typeInvestment,
                    backgroundItemsMultiChoiceColor: const Color.fromRGBO(148, 218, 223, 1),
                  ),
                  title(title: S.of(context).goods, isRequired: true),
                  FormElement(
                    name: 'goods',
                    type: FieldType.multipleChoice,
                    isRequired: true,
                    initialValue: widget.cardData?.goods,
                    onChanged: (value) => calculateProgress(context),
                    itemsMultiChoice: AppData.goods,
                  ),
                  FormElement(
                    title: S.of(context).location,
                    name: 'location',
                    type: FieldType.textField,
                    isRequired: isEditable,
                    validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                    initialValue: widget.cardData?.location,
                    hintText: 'Bordeaux',
                    onChanged: (value) => calculateProgress(context),
                  ),
                  SizedBox(
                    width: 55.w,
                    child: Column(
                      children: [
                        FormElement(
                          title: '${S.of(context).price} (€)',
                          name: 'price',
                          type: FieldType.number,
                          hintText: '200 000',
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly, FormatCurrencyText()],
                          isRequired: isEditable,
                          validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                          initialValue: widget.cardData?.price,
                          onChanged: (value) {
                            calculateProgress(context);
                          },
                        ),
                        FormElement(
                          title: '${S.of(context).price}/m\u00B2 (€)',
                          name: 'pricePerSquareMeters',
                          type: FieldType.number,
                          hintText: '4 000',
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly, FormatCurrencyText()],
                          isRequired: isEditable,
                          initialValue: widget.cardData?.pricePerSquareMeters,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                          ]),
                          onChanged: (value) => calculateProgress(context),
                        ),
                        FormElement<int>(
                          title: '${S.of(context).livingSpace} (m\u00B2)',
                          initialValue:
                              widget.cardData != null && widget.cardData!.livingSpace != null ? int.parse(widget.cardData!.livingSpace!) : 200,
                          isRequired: isEditable,
                          name: 'livingSpace',
                          type: FieldType.numberInput,
                        ),
                        FormElement<int>(
                          title: '${S.of(context).landArea} (m\u00B2)',
                          initialValue: widget.cardData != null && widget.cardData!.landArea != null ? int.parse(widget.cardData!.landArea!) : 2000,
                          isRequired: isEditable,
                          name: 'landArea',
                          type: FieldType.numberInput,
                        ),
                        FormElement<int>(
                          title: S.of(context).numberOfBatches,
                          isRequired: isEditable,
                          initialValue:
                              widget.cardData != null && widget.cardData!.numberOfBatches != null ? int.parse(widget.cardData!.numberOfBatches!) : 2,
                          name: 'numberOfBatches',
                          type: FieldType.numberInput,
                        ),
                      ],
                    ),
                  ),
                  title(title: S.of(context).stateOfGoods, isRequired: true),
                  FormElement(
                    name: 'stateOfGoods',
                    type: FieldType.select,
                    initialValue: widget.cardData?.stateOfGoods,
                    isRequired: true,
                    onChanged: (value) => calculateProgress(context),
                    itemsMultiChoice: AppData.goodTypes,
                  ),
                  title(title: S.of(context).labels),
                  FormElement(
                    name: 'labels',
                    type: FieldType.multipleChoice,
                    initialValue: widget.cardData?.labels,
                    backgroundItemsMultiChoiceColor: const Color(0xFFACE4BF),
                    onChanged: (value) => calculateProgress(context),
                    itemsMultiChoice: AppData.labels,
                  ),
                  title(title: S.of(context).photos, isRequired: true),
                  SizedBox(height: 1.h),
                  addImageButton(context, context.read<CreateCardCubit>()),
                  SizedBox(height: 2.h),
                  title(title: S.of(context).moreDetails),
                  moreDetailsButton(),
                  SizedBox(height: 2.h),
                  if (isEditable)
                    Align(
                      alignment: Alignment.centerRight,
                      child: CommonButton(
                        onPressed: () async {
                          isValidated = true;
                          setState(() {});
                          var cubit = context.read<CreateCardCubit>();
                          final validateForm = cubit.fbKey.currentState?.saveAndValidate();
                          var listMoreDetails =
                              moreDetailsText.asMap().entries.where((element) => moreDetails[element.key]).map((e) => e.value).toList();

                          var formValue = {
                            ...cubit.fbKey.currentState!.value,
                            'moreDetails': listMoreDetails,
                            'pictureUrl': widget.cardData?.pictureUrl
                          };
                          if (validateForm != null && validateForm) {
                            if (widget.cardData == null) {
                              if (cubit.imageFile.path != '') {
                                await cubit.createCard(formValue);
                              }
                            } else {
                              await cubit.editCard(formValue, widget.cardData!.id!);
                            }
                          }
                        },
                        backgroundColor: AppColor.accentColor,
                        width: 20.w,
                        height: 3.5.h,
                        radius: 13,
                        child: Text(
                          widget.cardData != null ? S.of(context).modify : S.of(context).create,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: const Color(0xFF072B53),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  SizedBox(height: 2.h)
                ],
              ),
            ),
          ),
        ],
      );

  Widget title({required String title, bool isRequired = false}) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Text.rich(
        TextSpan(
          text: "$title ",
          children: [
            if (isRequired && isEditable)
              TextSpan(
                text: "*",
                style: AppTextStyle.bodyTextStyle.copyWith(
                  color: AppColor.redColor,
                  fontWeight: FontWeight.w600,
                ),
              )
          ],
        ),
        style: AppTextStyle.bodyTextStyle.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget addImageButton(BuildContext context, CreateCardCubit cubit) {
    return SizedBox(
      child: cubit.imageFile.path != ''
          ? (isEditable)
              ? GestureDetector(
                  onTap: () async {
                    await cubit.onImageButtonPressed(ImageSource.gallery, context: context).then((value) {
                      calculateProgress(context);
                    });
                  },
                  child: SizedBox(
                    height: 40.w,
                    width: 80.w,
                    child: ClipRRect(borderRadius: BorderRadius.circular(10.sp), child: Image.file(File(cubit.imageFile.path), fit: BoxFit.cover)),
                  ),
                )
              : const SizedBox()
          : widget.cardData != null && widget.cardData!.pictureUrl != null
              ? (isEditable)
                  ? GestureDetector(
                      onTap: () async {
                        await cubit.onImageButtonPressed(ImageSource.gallery, context: context).then((value) {
                          calculateProgress(context);
                        });
                      },
                      child: SizedBox(
                        height: 40.w,
                        width: 80.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.sp),
                          child: Image.network(widget.cardData!.pictureUrl!, fit: BoxFit.cover),
                        ),
                      ),
                    )
                  : const SizedBox()
              : (isEditable)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25.w,
                          width: 80.w,
                          child: OutlinedButton(
                            onPressed: () async {
                              await cubit.onImageButtonPressed(ImageSource.gallery, context: context).then((value) {
                                calculateProgress(context);
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.sp)),
                              side: const BorderSide(color: AppColor.accentColor, width: 2),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Icon(Icons.add, size: 36),
                          ),
                        ),
                        if (cubit.pictureUrl == null && isValidated)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 8),
                            child: Text(
                              S.of(context).empty_field_error,
                              style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.red),
                            ),
                          ),
                      ],
                    )
                  : const SizedBox(),
    );
  }

  Widget moreDetailsButton() {
    return Wrap(
      children: moreDetailsText.asMap().entries.map(detailsButton).toList(),
    );
  }

  Widget detailsButton(MapEntry<int, String> data) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: GestureDetector(
        onTap: () {
          setState(() {
            moreDetails[data.key] = !moreDetails[data.key];
          });
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 25.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Checkbox(
                  checkColor: Colors.white,
                  value: moreDetails[data.key],
                  onChanged: (value) {
                    setState(() {
                      moreDetails[data.key] = !moreDetails[data.key];
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.5.h),
                child: Image.asset('assets/graphics/card/${moreDetailsImg[data.key]}.png'),
              ),
              Text(
                '${data.value}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget progressBar() {
    return Container(
      width: 80.w,
      height: 2.5.h,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: const Color(0xFFE4F7FF),
        borderRadius: BorderRadius.circular(10.sp),
        border: Border.all(color: AppColor.accentColor),
      ),
      child: ValueListenableBuilder<double>(
        builder: (BuildContext context, double value, Widget? child) {
          return AnimatedContainer(
            decoration: BoxDecoration(
              color: AppColor.accentColor,
              borderRadius: BorderRadius.circular(10.sp),
              gradient: const LinearGradient(colors: [Color(0xFF1792EA), Color(0xFF21C8D1)]),
            ),
            width: _counter.value,
            duration: const Duration(milliseconds: 500),
          );
        },
        valueListenable: _counter,
      ),
    );
  }

  void calculateProgress(BuildContext context) {
    var bloc = context.read<CreateCardCubit>();
    var fbKey = bloc.fbKey;
    var title = fbKey.currentState?.fields['title']?.value;
    var investment = (fbKey.currentState?.fields['investment']!.value as List?)?.cast<String>();
    var goods = (fbKey.currentState?.fields['goods']?.value as List?)?.cast<String>();
    var location = fbKey.currentState?.fields['location']?.value;
    var price = fbKey.currentState?.fields['price']?.value;
    var pricePerSquareMeters = fbKey.currentState?.fields['pricePerSquareMeters']?.value;
    var stateOfGoods = fbKey.currentState?.fields['stateOfGoods']?.value;
    var labels = fbKey.currentState?.fields['labels']?.value;

    double progress = 0;
    // total 80.w
    // check if each field is filled
    if (title != null && title != '') {
      progress += 8.w;
    }
    if (goods != null && goods.isNotEmpty) {
      progress += 8.w;
    }
    if (investment != null && investment.isNotEmpty) {
      progress += 8.w;
    }
    if (location != null && location != '') {
      progress += 8.w;
    }
    if (price != null && price != '') {
      progress += 8.w;
    }
    if (pricePerSquareMeters != null && pricePerSquareMeters != '') {
      progress += 8.w;
    }
    if (stateOfGoods != null && stateOfGoods.isNotEmpty) {
      progress += 8.w;
    }
    if (labels != null && labels.isNotEmpty) {
      progress += 8.w;
    }
    if (bloc.imageFile.path != '') {
      progress += 8.w;
    }
    if (moreDetails.isNotEmpty) {
      progress += 8.w;
    }
    _counter.value = progress;
  }
}
