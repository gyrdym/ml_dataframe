import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'dart:math' as math;

class _SeriesDisplayData {
  _SeriesDisplayData(this.colIndex, this.colTitle) : maxChars = colTitle.length;
  int colIndex = 0;
  int maxChars;
  String colTitle;
  List<String> data = [];
}

const kPadding = 3;
const kSkippingSymbol = '...';

String dataFrameToString(
  DataFrame dataFrame, {
  int maxRows = 10,
  int maxCols = 7,
}) {
  maxCols = math.min(dataFrame.header.length, maxCols);
  maxRows = math.min(dataFrame.rows.length, maxRows);

  final nRows = dataFrame.shape[0];
  final nCols = dataFrame.shape[1];
  final basicString = 'DataFrame ($nRows x $nCols)';

  if (maxRows == 0 || maxCols == 0) {
    return basicString;
  }

  final seriesDisplayData = <_SeriesDisplayData>[];
  final rowCountStartEnd =
      maxRows > 1 ? [maxRows ~/ 2, maxRows - maxRows ~/ 2] : [1, 0];
  final colCountStartEnd = maxCols > 1 ? [maxCols - 1, 1] : [1, 0];

  var j = 0;
  for (var colTitle in dataFrame.header) {
    if (j < colCountStartEnd[0] || j >= nCols - colCountStartEnd[1]) {
      seriesDisplayData.add(_SeriesDisplayData(j, colTitle));
    } else if (j == colCountStartEnd[0] && colCountStartEnd[1] != 0) {
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
          displayData.maxChars =
              math.max(displayData.maxChars, valueString.length);
          seriesCounter++;
        } else if (j == colCountStartEnd[0] && colCountStartEnd[1] != 0) {
          seriesDisplayData[seriesCounter].data.add(kSkippingSymbol);
          seriesDisplayData[seriesCounter].maxChars = kSkippingSymbol.length;
          seriesCounter++;
        }
        j++;
      }
    } else if (i == rowCountStartEnd[0] && rowCountStartEnd[1] != 0) {
      for (var d in seriesDisplayData) {
        d.maxChars = math.max(kSkippingSymbol.length, d.maxChars);
        d.data.add(kSkippingSymbol);
      }
    }
    i++;
  }

  var finalLines = <String>[];
  // construct header line:
  finalLines.add(basicString);
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
