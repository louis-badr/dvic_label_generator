import 'package:dvic_label_generator/components/authors_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

Transform generateLabelLayout1(
  String urlImg,
  String urlQR,
  String title, {
  String? group,
  String? subtitle,
  String? abstract,
  List<String>? authors,
  //List<String>? contributors,
  List<String>? supervisors,
  double labelCornerRadius = 60,
  double labelMargin = 50,
  double titleFontSize = 24,
}) {
  double sizeQR = 280;
  String? filename;
  if (group != null && group != "None") {
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
                      borderRadius: BorderRadius.circular(
                          labelCornerRadius - labelMargin),
                      child: Image(
                        image: NetworkImage(urlImg),
                      )),
                  SizedBox(width: labelMargin / 2),
                  SizedBox(
                    height: sizeQR,
                    width: sizeQR,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        QrImage(
                          data: urlQR,
                          padding: EdgeInsets.zero,
                          version: QrVersions.auto,
                          errorCorrectionLevel: 2,
                          foregroundColor: Colors.grey.shade900,
                        ),
                        Container(
                          height: sizeQR * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ),
                        Image(
                          height: sizeQR * 0.28,
                          //color: Colors.grey.shade900,
                          image: const AssetImage('favicon.png'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: labelMargin / 2),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (filename != null)
                        Padding(
                          padding: EdgeInsets.only(right: labelMargin / 2),
                          child: Image(
                            height: 40,
                            image: AssetImage('${filename}_no_text.png'),
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
                            if (subtitle != null && subtitle != '')
                              TextSpan(
                                text: '\n$subtitle',
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: titleFontSize - 2,
                                    fontWeight: FontWeight.normal),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (abstract != null)
                Padding(
                  padding: EdgeInsets.only(top: labelMargin / 2),
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      abstract,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: titleFontSize - 4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              authorsWidget(authors, supervisors, labelMargin, titleFontSize),
            ],
          ),
        ),
      ),
    ),
  );
  ;
}
