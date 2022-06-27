import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

Transform generateLabelLayout1(
  String urlImg,
  String urlQR,
  String title, {
  String? group,
  String? subtitle,
  String? abstract,
  double labelCornerRadius = 60,
  double labelMargin = 50,
  double titleFontSize = 24,
}) {
  String? filename;
  bool groupIsVisible = false;
  if (group != null && group != "None") {
    groupIsVisible = true;
    if (group == "Artificial Lives") {
      filename = "al";
    }
    if (group == "Human Learning") {
      filename = "hl";
    }
    if (group == "Resilient Futures") {
      filename = "rf";
    }
  }

  return Transform.scale(
    scale: 1,
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(labelCornerRadius),
          side: BorderSide(color: Colors.grey.shade500)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(labelMargin),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(labelCornerRadius - labelMargin),
                    child: Image.network(
                      urlImg,
                      height: 300,
                    ),
                  ),
                  SizedBox(width: labelMargin / 2),
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        QrImage(
                          data: urlQR,
                          version: QrVersions.auto,
                          errorCorrectionLevel: 2,
                        ),
                        Container(
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Image(
                          height: 80,
                          image: AssetImage('assets/favicon.png'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: labelMargin / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Visibility(
                      visible: groupIsVisible,
                      child: SizedBox(
                        height: 60,
                        child:
                            Image(image: AssetImage('${filename}_no_text.png')),
                      ),
                    ),
                    Visibility(
                      visible: groupIsVisible,
                      child: SizedBox(
                        width: labelMargin / 2,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: subtitle == null ? '' : '\n$subtitle',
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: titleFontSize - 3,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: abstract != null,
                child: SizedBox(
                  width: 200,
                  child: Text(
                    abstract!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: titleFontSize - 5,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  ;
}
