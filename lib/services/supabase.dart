import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initializeSupabase() async {
  await dotenv.load(fileName: '.env');
  // ---- PRODUCTION
  // await Supabase.initialize(
  //   url: dotenv.env['SUPABASE_URL']!,
  //   anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  // );
  // Create an instance of the Client

  // ---- STAGING

  // ---- lOCAL
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL_LOCAL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY_LOCAL']!,
  );
}

final supabase = Supabase.instance.client;

// problem : try connect locally with flutter
