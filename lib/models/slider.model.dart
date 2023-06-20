import 'package:freezed_annotation/freezed_annotation.dart';
import '/config.dart';

part 'slider.model.freezed.dart';
part 'slider.model.g.dart';

List<SliderModel> slidersFromJson(dynamic json) =>
    List<SliderModel>.from((json).map((e) => SliderModel.fromJson(e)));

@freezed
abstract class SliderModel with _$SliderModel {
  factory SliderModel({
    required String sliderId,
    required String sliderName,
   
    required String sliderImage,
  }) = _Slider;

  factory SliderModel.fromJson(Map<String, dynamic> json) =>
      _$SliderModelFromJson(json);
}

extension SliderModelExt on SliderModel {
  String get fullImagePath => Config.imageURL + sliderImage;
}