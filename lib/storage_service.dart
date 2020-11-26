import 'dart:async';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

class StorageService {
  final imageUrlsController = StreamController<List<String>>();

  void getImages() async {
    try {
      final listOptions =
          S3ListOptions(accessLevel: StorageAccessLevel.private);
      final result = await Amplify.Storage.list(options: listOptions);

      final getUrlOptions =
          GetUrlOptions(accessLevel: StorageAccessLevel.private);
      final List<String> imagesUrls =
          await Future.wait(result.items.map((item) async {
        final urlResult =
            await Amplify.Storage.getUrl(key: item.key, options: getUrlOptions);
        return urlResult.url;
      }));

      imageUrlsController.add(imagesUrls);
    } catch (e) {
      print('Storage List error = $e');
    }
  }
}
