import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseRepository<T> {
  final String tableName;

  BaseRepository(this.tableName);

  SupabaseClient get _client => Supabase.instance.client;

  SupabaseQueryBuilder get table => _client.from(tableName);

  Future<List<Map<String, dynamic>>> getAll() async {
    final response = await table.select();
    return response;
  }

  Future<Map<String, dynamic>?> getById(String id) async {
    final response = await table.select().eq('${tableName}_id', id).single();
    return response;
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    final response = await table.insert(data).select().single();
    return response;
  }

  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> data,
  ) async {
    final response =
        await table.update(data).eq('${tableName}_id', id).select().single();
    return response;
  }

  Future<void> delete(String id) async {
    await table.delete().eq('${tableName}_id', id);
  }

  Future<List<Map<String, dynamic>>> query(String column, dynamic value) async {
    final response = await table.select().eq(column, value);
    return response;
  }
}
