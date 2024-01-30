import './dev.dart' as dev;
import './prod.dart' as prod;

const String kEnvironmentMode = "DEV";

Uri getBackendURL({required String path, Map<String, dynamic>? queryParameters}) {
  return kEnvironmentMode == "DEV"
    ? Uri.http(dev.kBackendEndpoint, path, queryParameters)
    : Uri.https(prod.kBackendEndpoint, path, queryParameters);
}

