import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initializeSupabase() async {
  await dotenv.load();
  // ---- PRODUCTION
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  //

  // ---- STAGING

  // ---- lOCAL
  // await Supabase.initialize(
  //   url: dotenv.env['SUPABASE_URL_LOCAL']!,
  //   anonKey: dotenv.env['SUPABASE_ANON_KEY_LOCAL']!,
  // );
}

final supabase = Supabase.instance.client;

// problem : try connect locally with flutter
