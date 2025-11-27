class DownloadUtils {

  static String cvDownloadPath(String langCode) {

    const String basePath = '/';

    // 2. Construct the path (ensure files are named cv_en.pdf and cv_fr.pdf)
    final String assetPath = 'assets/assets/cv/Pierre_Junior_cv_$langCode.pdf';

    final String fullAssetPath = '$basePath$assetPath';
    return fullAssetPath;
  }
}