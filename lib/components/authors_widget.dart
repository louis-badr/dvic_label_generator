import 'package:flutter/material.dart';

Widget singleAuthor(
    String name, String role, double labelMargin, double authorsFontSize) {
  return Padding(
    padding: EdgeInsets.only(right: labelMargin / 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Text>[
        Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontSize: authorsFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          role,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: authorsFontSize - 2,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Widget authorsWidget(List<String>? authors, List<String>? supervisors,
    double labelMargin, double titleFontSize) {
  return Padding(
    padding: EdgeInsets.only(top: labelMargin / 2),
    child: Row(
      children: <Widget>[
        if (authors != null && authors[0] != '')
          for (String i in authors)
            singleAuthor(i, 'Author', labelMargin, titleFontSize),
        if (supervisors != null && supervisors[0] != '')
          for (String j in supervisors)
            singleAuthor(j, 'Supervisor', labelMargin, titleFontSize),
      ],
    ),
  );
}
