// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PurchaseRecordAdapter extends TypeAdapter<PurchaseRecord> {
  @override
  final int typeId = 1;

  @override
  PurchaseRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PurchaseRecord(
      id: fields[0] as String,
      sum: fields[2] as double,
      date: fields[1] as DateTime,
      category: fields[3] as PurchaseCategory,
      description: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PurchaseRecord obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.sum)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PurchaseRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
