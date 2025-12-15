// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

enum GameResult {
  @JsonValue('victory')
  victory,

  @JsonValue('draw')
  draw,

  @JsonValue('defeat')
  defeat,
}
