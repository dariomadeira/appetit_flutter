import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:supabase/supabase.dart';

class DataProvider with ChangeNotifier {

  final Logger _logger = Logger();

  Future<bool> saveUserData({
    required String email,
    required String userId,
    required String fullName,
    required String urlPhoto,
    required SupabaseClient client,
  }) async {
    bool result = false;
    try {
      final insertResponse = await client.from('appUsers').insert([
        // {'email': email},
        // {'user_id': userId},
        // {'full_name': fullName},
        // {'url_photo': urlPhoto},
        // {'create_at': ""},
        {'email': "dariomadeira@gmail.com"},
        // {'user_id': "tarado"},
        // {'full_name': "Darío Madeira"},
        // {'url_photo': "photo"},
      ]).execute();


      if (insertResponse.error == null) {
        print('insertResponse.data: ${insertResponse.data}');
        result = true;
      } else {
        _logger.i(insertResponse.error);
        result = false;
      }
    } catch(e) {
      print(e);
      result = false;
    }
    return result;
  }

}
