import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:suppliers_products_finder_app/core/app/my_app.dart';
import 'package:suppliers_products_finder_app/core/services/location_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const supabaseUrl = 'https://uxntaagjcuoyzsbxcjkf.supabase.co';
  const supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV4bnRhYWdqY3VveXpzYnhjamtmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMjU1MDk3MCwiZXhwIjoyMDM4MTI2OTcwfQ.-HpMhBpeDrTKeTEZDM5k0PM_-2HF5XzlzeqsVjgaIbE';
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  Get.put(LocationService());
  runApp(const MyApp());
}
