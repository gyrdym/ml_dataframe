import 'package:ml_dataframe/ml_dataframe.dart';

class _SeriesDisplayData {
  _SeriesDisplayData(this.colIndex, this.colTitle) : maxChars = colTitle.length;
  int colIndex = 0;
  int maxChars;
  String colTitle;
  List<String> data = [];
}

const kPadding = 3;
const kSkippingSymbol = '...';

String dataFrameToString(DataFrame dataFrame, {maxRows = 10, maxCols = 7}) {
  final rowCountStartEnd = [
    (maxRows / 2).toInt(),
    maxRows - (maxRows / 2).toInt()
  ];
  maxCols =
      dataFrame.header.length < maxCols ? dataFrame.header.length : maxCols;
  maxRows = dataFrame.rows.length < maxRows ? dataFrame.rows.length : maxRows;
  final colCountStartEnd = [maxCols - 1, 1];
  final nRows = dataFrame.shape[0];
  final nCols = dataFrame.shape[1];

  final seriesDisplayData = <_SeriesDisplayData>[];

  var j = 0;
  for (var colTitle in dataFrame.header) {
    if (j < colCountStartEnd[0] || j >= nCols - colCountStartEnd[1]) {
      seriesDisplayData.add(_SeriesDisplayData(j, colTitle));
    } else if (j == colCountStartEnd[0]) {
      seriesDisplayData.add(_SeriesDisplayData(j, kSkippingSymbol));
    }
    j++;
  }

  var i = 0;
  for (var row in dataFrame.rows) {
    if (i < rowCountStartEnd[0] || i >= nRows - rowCountStartEnd[1]) {
      var j = 0;
      var seriesCounter = 0;
      for (var value in row) {
        if (j < colCountStartEnd[0] || j >= nCols - colCountStartEnd[1]) {
          var displayData = seriesDisplayData[seriesCounter];
          var valueString = value.toString();
          displayData.data.add(valueString);
          if (displayData.maxChars < valueString.length) {
            displayData.maxChars = valueString.length;
          }
          seriesCounter++;
        } else if (j == colCountStartEnd[0]) {
          seriesDisplayData[seriesCounter].data.add(kSkippingSymbol);
          seriesDisplayData[seriesCounter].maxChars = kSkippingSymbol.length;
          seriesCounter++;
        }
        j++;
      }
    } else if (i == rowCountStartEnd[0]) {
      for (var d in seriesDisplayData) {
        d.maxChars = d.maxChars < kSkippingSymbol.length
            ? kSkippingSymbol.length
            : d.maxChars;
        d.data.add(kSkippingSymbol);
      }
    }

    i++;
  }

  var finalLines = <String>[];
  // construct header line:
  finalLines.add('DataFrame ($nRows x $nCols)');
  finalLines.add(seriesDisplayData
      .map((d) => d.colTitle.padLeft(d.maxChars) + ' ' * kPadding)
      .join('')
      .trimRight());
  // construct other lines:
  for (var i = 0; i < seriesDisplayData[0].data.length; i++) {
    finalLines.add(seriesDisplayData
        .map((d) => d.data[i].padLeft(d.maxChars) + ' ' * kPadding)
        .join('')
        .trimRight());
  }

  return finalLines.join('\n');
}
