import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'dart:developer';

class DataProvider with ChangeNotifier {

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
        print("**** INSERT OK ****");
        inspect(insertResponse.data);
        result = true;
      } else {
        print("**** INSERT ERROR ****");
        inspect(insertResponse.error);
        result = false;
      }
    } catch(e) {
      print("**** ERROR - ${e}");
      result = false;
    }
    return result;
  }

}
