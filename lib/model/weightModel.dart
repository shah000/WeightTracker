class WeightModel {
  String id;
  String weight;

  WeightModel({
    this.id,
    this.weight,
  });

  WeightModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        weight = snapshot['weight'] ?? '';

  toJson() {
    return {
      "weight": weight,
    };
  }
}
