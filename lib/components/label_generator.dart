import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dvic_label_generator/components/authors_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

Widget generateLabelLayout1(
  String urlImg,
  String urlQR,
  String title, {
  String? group,
  String? subtitle,
  String? abstract,
  List<String>? authors,
  //List<String>? contributors,
  List<String>? supervisors,
  //double labelCornerRadius = 60,
  double labelMargin = 50,
  double titleFontSize = 40,
  double subtitleFontSize = 20,
  double abstractFontSize = 20,
  double authorsFontSize = 20,
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

  return DottedBorder(
    color: Colors.grey.shade400,
    strokeWidth: 1,
    strokeCap: StrokeCap.round,
    dashPattern: const [16, 16],
    child: Container(
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
                      borderRadius: BorderRadius.circular(labelMargin / 4),
                      child: Image(
                        image: NetworkImage(urlImg),
                      )),
                  SizedBox(width: labelMargin / 2),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        BarcodeWidget(
                          color: Colors.grey.shade900,
                          barcode: Barcode.qrCode(
                            errorCorrectLevel: BarcodeQRCorrectionLevel.medium,
                          ),
                          data: urlQR,
                        ),
                        Container(
                          height: sizeQR * 0.35,
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
                          height: sizeQR * 0.25,
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
                                    fontSize: subtitleFontSize,
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
                        fontSize: abstractFontSize,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              authorsWidget(authors, supervisors, labelMargin, authorsFontSize),
            ],
          ),
        ),
      ),
    ),
  );
}
