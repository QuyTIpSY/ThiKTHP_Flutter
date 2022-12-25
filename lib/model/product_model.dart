class Products{
  num? id;
  String? title;
  String? description;
  num? price;
  num? discountPercentage;
  num? rating;
  num? stock;
  String? thumbnail;
  String? brand;
  String? category;

  Products(
      {
        this.id,
        this.title,
        this.description,
        this.price,
        this.discountPercentage,
        this.rating,
        this.stock,
        this.brand,
        this.category,
        this.thumbnail
      });
}

class ProductModel{
  Products? products;
  num? total;
  num? skip;
  num? limit;
  ProductModel(
      {
        this.products,
        this.total,
        this.skip,
        this.limit,
      });
}