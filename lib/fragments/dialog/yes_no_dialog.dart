import 'package:flutter/material.dart';
import 'package:weli/generated/l10n.dart';

class YesNoDialog extends StatelessWidget {
  final String text;
  final VoidCallback? onYes;
  final VoidCallback? onNo;

  const YesNoDialog(this.text, {Key? key, this.onYes, this.onNo}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    contentPadding: const EdgeInsets.all(20),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                onYes?.call();
                Navigator.pop(context);
              },
              child: Text(S.of(context).yes),
            ),
            // SizedBox(),
            TextButton(
              onPressed: () {
                onNo?.call();
                Navigator.pop(context);
              },
              child: Text(S.of(context).no),
            ),
          ],
        )
      ],
    ),
  );
}
