class TodoModel {
  final int? code;
  final bool? success;
  final int? timestamp;
  final String? message;
  List<Item>? items;
  final Meta? meta;

  TodoModel({
    this.code,
    this.success,
    this.timestamp,
    this.message,
    this.items,
    this.meta,
  });

  factory TodoModel.fromMap(Map<String, dynamic> json) => TodoModel(
        code: json["code"],
        success: json["success"],
        timestamp: json["timestamp"],
        message: json["message"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromMap(x))),
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "success": success,
        "timestamp": timestamp,
        "message": message,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toMap())),
        "meta": meta?.toMap(),
      };
}

class Item {
  final String? id;
  final String? title;
  final String? description;
  final bool? isCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Item({
    this.id,
    this.title,
    this.description,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        isCompleted: json["is_completed"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "description": description,
        "is_completed": isCompleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Meta {
  final int? totalItems;
  final int? totalPages;
  final int? perPageItem;
  final int? currentPage;
  final int? pageSize;
  final bool? hasMorePage;

  Meta({
    this.totalItems,
    this.totalPages,
    this.perPageItem,
    this.currentPage,
    this.pageSize,
    this.hasMorePage,
  });

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        totalItems: json["total_items"],
        totalPages: json["total_pages"],
        perPageItem: json["per_page_item"],
        currentPage: json["current_page"],
        pageSize: json["page_size"],
        hasMorePage: json["has_more_page"],
      );

  Map<String, dynamic> toMap() => {
        "total_items": totalItems,
        "total_pages": totalPages,
        "per_page_item": perPageItem,
        "current_page": currentPage,
        "page_size": pageSize,
        "has_more_page": hasMorePage,
      };
}
