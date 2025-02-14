import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCYW6gFdwzsh5wBQY_deTQVmj-Wf4KXwK8",
            authDomain: "desafio-v4rbkl.firebaseapp.com",
            projectId: "desafio-v4rbkl",
            storageBucket: "desafio-v4rbkl.firebasestorage.app",
            messagingSenderId: "766515453015",
            appId: "1:766515453015:web:132d4b032370aaa92f9712"));
  } else {
    await Firebase.initializeApp();
  }
}
