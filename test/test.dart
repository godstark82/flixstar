import 'package:html/parser.dart';

import 'package:dio/dio.dart';

void main() async {
  await getMovieSource(653346).then((value) {
    print(value);
  });
}

Future<String> getMovieSource(int id) async {
  final Dio dio = Dio();
  try {
    String movieUrl = 'https://vidsrc.to/embed/movie/$id';
    print('getting Movie Source from url $movieUrl');

    final response = await dio.get(movieUrl);
    final html = parse(response.data);
    final noAdScript = html.outerHtml.replaceAll('''<script>
(function () {
  var numb = parseInt(Storage.get('adi'));
  numb = isNaN(numb) ? 0 : numb;
  var success = Storage.set('adi', numb + 1);
  if (!success) numb = Math.floor(Math.random() * 100);

  if (numb % 2) {
    document.write("<script type='text/javascript' src='lm1/com/precedelaxative/6e/93/66/6e936646bd24f8b9bd12af76368155da.js'><\\/script>");
  } else {
    document.write("<script type='text/javascript' src='lm1/com/precedelaxative/88/1d/c4/881dc4c310ba96ddca859431babfc89b.js'><\\/script>");
  }
}());
</script>''', '');

    return noAdScript;
  } catch (e) {
    print('Error Occurs While Fetching VidSrc Data');
    print(e.toString());
    rethrow;
  }
}
