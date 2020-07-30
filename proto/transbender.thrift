namespace java com.rbkmoney.transbender
namespace erlang transbender

include "proto/msgpack.thrift"

union ExternalID {
    1: string as_string
    2: i64    as_integer
}

exception InternalIDNotFound { }

union GenerationResult {
    1: GenerationResultString  as_string
    2: GenerationResultInteger as_integer
}
struct GenerationResultString {
    1: required string internal_id
    2: optional msgpack.Value context
}
struct GenerationResultInteger {
    1: required i64 internal_id
    2: optional msgpack.Value context
}

union GenerationSchema {
    1: SnowflakeSchema snowflake
    2: ConstantSchema  constant
    3: SequenceSchema  sequence
}

struct SnowflakeSchema { }

union ConstantSchema {
    1: ConstantSchemaString  as_string
    2: ConstantSchemaInteger as_integer
}
struct ConstantSchemaString {
    1: required string internal_id
}
struct ConstantSchemaInteger {
    1: required i64    internal_id
}

union SequenceSchema {
    1: SequenceSchemaString  as_string
    2: SequenceSchemaInteger as_integer
}
struct SequenceSchemaString {
    1: required string sequence_id
    2: optional i64    minimum
}
struct SequenceSchemaInteger {
    1: required i64 sequence_id
    2: optional i64 minimum
}

union GetInternalIDResult {
    1: GetInternalIDResultString  as_string
    2: GetInternalIDResultInteger as_integer
}
struct GetInternalIDResultString {
    1: required string internal_id
    2: required msgpack.Value context
}
struct GetInternalIDResultInteger {
    1: required string internal_id
    2: required msgpack.Value context
}

union ResultType {
    1: AsString  as_string
    2: AsInteger as_integer
}
struct AsInteger { }
struct AsString  { }

service Transbender {

    GenerationResult GenerateID (
        1: ExternalID external_id,
        2: GenerationSchema schema,
        3: msgpack.Value context,
        4: ResultType result_type
    )

    GetInternalIDResult GetInternalID (
        1: ExternalID external_id
        2: ResultType result_type
    )
        throws (1: InternalIDNotFound ex1)
}
