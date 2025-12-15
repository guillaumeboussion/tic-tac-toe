import 'package:flutter/material.dart';

abstract class ISettingsRepository {
  Future<Locale?> getLocale();
  Future<void> saveLocale(Locale locale);
}
