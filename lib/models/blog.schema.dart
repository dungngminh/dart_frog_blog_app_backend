// ignore_for_file: annotate_overrides

part of 'blog.dart';

extension BlogRepositories on Database {
  BlogRepository get blogs => BlogRepository._(this);
}

abstract class BlogRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<BlogInsertRequest>,
        ModelRepositoryUpdate<BlogUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory BlogRepository._(Database db) = _BlogRepository;

  Future<BlogView?> queryBlog(String id);
  Future<List<BlogView>> queryBlogs([QueryParams? params]);
}

class _BlogRepository extends BaseRepository
    with
        RepositoryInsertMixin<BlogInsertRequest>,
        RepositoryUpdateMixin<BlogUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements BlogRepository {
  _BlogRepository(super.db) : super(tableName: 'blogs', keyName: 'id');

  @override
  Future<BlogView?> queryBlog(String id) {
    return queryOne(id, BlogViewQueryable());
  }

  @override
  Future<List<BlogView>> queryBlogs([QueryParams? params]) {
    return queryMany(BlogViewQueryable(), params);
  }

  @override
  Future<void> insert(List<BlogInsertRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'INSERT INTO "blogs" ( "id", "title", "description", "category", "created_at", "updated_at", "creator_id" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.id)}:text, ${values.add(r.title)}:text, ${values.add(r.description)}:text, ${values.add(EnumTypeConverter<BlogCategory>([
                BlogCategory.business,
                BlogCategory.technology,
                BlogCategory.fashion,
                BlogCategory.travel,
                BlogCategory.food,
                BlogCategory.education
              ]).tryEncode(r.category))}:text, ${values.add(r.createdAt)}:timestamp, ${values.add(r.updatedAt)}:timestamp, ${values.add(r.creatorId)}:text )').join(', ')}\n',
      values.values,
    );
  }

  @override
  Future<void> update(List<BlogUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "blogs"\n'
      'SET "title" = COALESCE(UPDATED."title", "blogs"."title"), "description" = COALESCE(UPDATED."description", "blogs"."description"), "category" = COALESCE(UPDATED."category", "blogs"."category"), "created_at" = COALESCE(UPDATED."created_at", "blogs"."created_at"), "updated_at" = COALESCE(UPDATED."updated_at", "blogs"."updated_at"), "creator_id" = COALESCE(UPDATED."creator_id", "blogs"."creator_id")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:text::text, ${values.add(r.title)}:text::text, ${values.add(r.description)}:text::text, ${values.add(EnumTypeConverter<BlogCategory>([
                BlogCategory.business,
                BlogCategory.technology,
                BlogCategory.fashion,
                BlogCategory.travel,
                BlogCategory.food,
                BlogCategory.education
              ]).tryEncode(r.category))}:text::text, ${values.add(r.createdAt)}:timestamp::timestamp, ${values.add(r.updatedAt)}:timestamp::timestamp, ${values.add(r.creatorId)}:text::text )').join(', ')} )\n'
      'AS UPDATED("id", "title", "description", "category", "created_at", "updated_at", "creator_id")\n'
      'WHERE "blogs"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class BlogInsertRequest {
  BlogInsertRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.creatorId,
  });

  final String id;
  final String title;
  final String description;
  final BlogCategory category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String creatorId;
}

class BlogUpdateRequest {
  BlogUpdateRequest({
    required this.id,
    this.title,
    this.description,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.creatorId,
  });

  final String id;
  final String? title;
  final String? description;
  final BlogCategory? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? creatorId;
}

class BlogViewQueryable extends KeyedViewQueryable<BlogView, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "blogs".*, row_to_json("creator".*) as "creator"'
      'FROM "blogs"'
      'LEFT JOIN (${UserViewQueryable().query}) "creator"'
      'ON "blogs"."creator_id" = "creator"."id"';

  @override
  String get tableAlias => 'blogs';

  @override
  BlogView decode(TypedMap map) => BlogView(
      id: map.get('id'),
      title: map.get('title'),
      description: map.get('description'),
      category: map.get(
          'category',
          EnumTypeConverter<BlogCategory>([
            BlogCategory.business,
            BlogCategory.technology,
            BlogCategory.fashion,
            BlogCategory.travel,
            BlogCategory.food,
            BlogCategory.education
          ]).decode),
      createdAt: map.get('created_at'),
      updatedAt: map.get('updated_at'),
      creator: map.get('creator', UserViewQueryable().decoder));
}

class BlogView {
  BlogView({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.creator,
  });

  final String id;
  final String title;
  final String description;
  final BlogCategory category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserView creator;
}