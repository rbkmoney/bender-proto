namespace java com.rbkmoney.transbender
namespace erlang transbender

include "proto/msgpack.thrift"

typedef string ExternalID

exception InternalIDNotFound { }

struct Binding {
    1: required string internal_id
    2: optional msgpack.Value context
}

struct IntegerBinding {
    1: required i64 internal_id
    2: optional msgpack.Value context
}

union Schema {
    1: SnowflakeSchema snowflake
    2: ConstantSchema  constant
    3: SequenceSchema  sequence
}

union IntegerSchema {
    1: SnowflakeSchema snowflake
    2: SequenceSchema  sequence
}

struct SnowflakeSchema { }

struct ConstantSchema {
    1: required string internal_id
}

struct SequenceSchema {
    1: required string sequence_id
    2: optional i64    minimum
}

service Transbender {
    Binding BindID (
        1: ExternalID external_id,
        2: Schema schema,
        3: msgpack.Value context
    )

    Binding GetBinding (
        1: ExternalID external_id
    ) throws (1: InternalIDNotFound ex1)

    IntegerBinding BindIntegerID (
        1: ExternalID external_id,
        2: IntegerSchema schema,
        3: msgpack.Value context
    )

    IntegerBinding GetIntegerBinding (
        1: ExternalID external_id
    ) throws (1: InternalIDNotFound ex1)
}
