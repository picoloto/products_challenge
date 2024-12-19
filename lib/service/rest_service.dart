abstract class RestService {
  Future<dynamic> findAll();

  Future<dynamic> findById(int id);

  // Implementar os outros métodos rest, como post, delete, update...
}
