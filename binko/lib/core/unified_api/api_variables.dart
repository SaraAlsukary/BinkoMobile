class ApiVariables {
  /////////////
  ///General///
  /////////////
  final _scheme = 'http';
  final _host = '10.0.2.2';
  final _port = 8000;

  String _imageUrl({
    required String path,
  }) {
    final url = Uri(
      scheme: _scheme,
      host: _host,
      path: path,
      port: _port,
    );
    return url.toString();
  }

  Uri _mainUri({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      path: '/api/$path',
      port: _port,
      queryParameters: queryParameters,
    );
    return uri;
  }

  String imageUrl(String path) => _imageUrl(path: path).toString();

  Uri login() => _mainUri(path: 'login/');

  Uri createUser() => _mainUri(path: 'create-user/');

  Uri logout() => _mainUri(path: 'logout');

  Uri updateProfile(int id) => _mainUri(path: 'update-user/$id/');

  Uri getAllCategories() => _mainUri(path: 'getallcat');

  Uri getAllBooks() => _mainUri(path: 'allbooks');

  Uri getMyBooks(int id) => _mainUri(path: 'mybook/$id/');

  Uri addLike(int id, int userId) => _mainUri(path: 'books/like/$userId/$id/');

  Uri addComment(int id, int userId) =>
      _mainUri(path: 'books/$id/users/$userId/comments/');

  Uri deleteFavored(int id, int userId) =>
      _mainUri(path: 'book-favs/$userId/$id/');

  Uri getLikes(int id) => _mainUri(path: 'books/$id/likes/');

  Uri getAllComments() => _mainUri(path: 'getallcomment/');

  Uri getBookComments(int bookId) => _mainUri(path: 'book/$bookId/comments/');

  Uri getBookChapters(int id) => _mainUri(path: 'books/$id/chapters');

  Uri getFavoredBooks(int id) => _mainUri(path: 'favorite-books/$id/');

  Uri getCommentReplies(int commentId) =>
      _mainUri(path: 'getreplys/$commentId/');

  Uri addToFavored() => _mainUri(path: 'add-favorite/');

  Uri addCategory() => _mainUri(path: 'add-category/');

  Uri addBook(int userId) => _mainUri(path: 'books/add/$userId/');

  Uri addReplyToComment(int commentId, int userId) =>
      _mainUri(path: 'addreply/$commentId/$userId/');

  Uri addChapter(int bookId) => _mainUri(path: 'books/$bookId/add-chapter/');
}
