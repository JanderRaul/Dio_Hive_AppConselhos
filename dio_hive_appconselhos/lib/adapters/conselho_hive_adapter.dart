import 'package:dio_hive_appconselhos/models/conselhos_model.dart';
import 'package:hive/hive.dart';

class ConselhoHiveAdapter extends TypeAdapter<Conselhos> {
  @override
  final typeId = 0;

  @override
  Conselhos read(BinaryReader reader) {
    return Conselhos(
        slip: Slip(
      advice: reader.readString(),
      id: reader.readInt(),
    ));
  }

  @override
  void write(BinaryWriter writer, Conselhos conselho) {
    writer.writeString(conselho.slip!.advice!);
    writer.writeInt(conselho.slip!.id!);
  }
}
