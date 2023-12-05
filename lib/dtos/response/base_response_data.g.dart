// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseData _$BaseResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BaseResponseData',
      json,
      ($checkedConvert) {
        final val = BaseResponseData(
          success: $checkedConvert('success', (v) => v as bool),
          result: $checkedConvert('result', (v) => v),
          message: $checkedConvert(
              'message', (v) => v as String? ?? kSuccessResponseMessage),
        );
        return val;
      },
    );

Map<String, dynamic> _$BaseResponseDataToJson(BaseResponseData instance) {
  final val = <String, dynamic>{
    'success': instance.success,
    'message': instance.message,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('result', instance.result);
  return val;
}
