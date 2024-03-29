# Changelog

## 1.6.0
- `getHousingDataFrame` function added

## 1.5.1
- Corrected typos and examples in README.md

## 1.5.0
- `getWineQualityDataFrame` function added
- `loadIrisDataset`, `loadPimaIndiansDiabetesDataset` deprecated, `getIrisDataFrame`, `getPimaIndiansDiabetesDataFrame` added instead

## 1.4.2
- `loadIrisDataset`, `loadPimaIndiansDiabetesDataset`: 
    - raw CSV data used instead of files

## 1.4.1
- `loadPimaIndiansDiabetesDataset` function exported

## 1.4.0
- Added `Pima Indians diabetes` dataset

## 1.3.0
- Added `Iris` dataset

## 1.2.2
- Fixed markup in `fromCsv` documentation
- Added documentation for `Series`

## 1.2.1
- Added documentation for `fromCsv`, `fromJson`

## 1.2.0
- `DataFrame`:
    - Added `mapSeries` function

## 1.1.0
- `DataFrame`:
    - Added `map` function

## 1.0.0

- Stable release
- `Dataframe`:
    - `dropSeries`:
        - `seriesIndices` renamed to `indices` 
        - `seriesNames` renamed to `names` 

## 0.6.0

- `DataFrame`: `toString` gets nicely formatted printing of the data to get a quick overview

## 0.5.1

- `pubspec.yaml`: `json_serializable` package moved to dev_dependencies section

## 0.5.0

- Null-safety supported (stable)

## 0.5.0-nullsafety.0

- Null-safety supported (beta)

## 0.4.1

- `DataFrame`: series-to-rows and rows-to-series converters issues fixed

## 0.4.0

- `DataFrame`: `fromRawCsv` constructor added

## 0.3.0

- `DataFrame`: `sampleFromRows` method added
- `CI`: github actions set up

## 0.2.0

- `DataFrame`: `shuffle` method added

## 0.1.1

- `DataFrame`: addSeries method added

## 0.1.0

- `DataFrame`, `Series`: Serialization/deserialization supported

## 0.0.11

- `dtype` parameter removed from the DataFrame's constructor
- `dtype` parameter added to `toMatrix` method

## 0.0.10

- `DataFrame.sampleFromSeries` method's signature changed

## 0.0.9

- `dtype` field added to `DataFrame` interface

## 0.0.8

- `xrange` dependency removed
- `ml_linalg 12.0.*` supported
- dart sdk constraint changed to `>=2.2.0 <3.0.0`

## 0.0.7

- `xrange` version locked

## 0.0.6

- `DataFrame`: `sampleFromSeries` method added

## 0.0.5

- `DataFrame`: `dropSeries` method added

## 0.0.4

- `DataFrame`: `fromMatrix` constructor added

## 0.0.3

- DataFrame helpers: series data is not `cold` iterable while series creating
- DataFrame unit tests: redundant constructor parameters removed for some test cases

## 0.0.2

- Redundant dependencies removed from `dev_dependencies` section

## 0.0.1

- `DataFrame`: `DataFrame` entity with basic functionality added
- `Series`: `Series` class added - the entity that is representing a column with its header
