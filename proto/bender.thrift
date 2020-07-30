namespace java com.rbkmoney.bender
namespace erlang bender

include "proto/msgpack.thrift"

typedef string ExternalID
typedef string InternalID

typedef i64 NumericExternalID
typedef i64 NumericInternalID

exception InternalIDNotFound {}

struct GenerationResult {
    1: required InternalID internal_id
    2: optional msgpack.Value context
}

struct GetInternalIDResult {
    1: required InternalID internal_id
    2: required msgpack.Value context
}

union GenerationSchema {
    1: SnowflakeSchema snowflake
    2: ConstantSchema constant
    3: SequenceSchema sequence
}

struct SnowflakeSchema {
}

struct ConstantSchema {
    1: required InternalID internal_id
}

struct SequenceSchema {
    1: required string sequence_id
    2: optional i64 minimum
}

union NumericGenerationSchema {
    1: NumericSnowflakeSchema snowflake
    2: NumericConstantSchema constant
    3: NumericSequenceSchema sequence
}

struct NumericSnowflakeSchema {
}

struct NumericConstantSchema {
    1: required NumericInternalID internal_id
}

struct NumericSequenceSchema {
    1: required i64 sequence_id
    2: optional i64 minimum
}

struct NumericGenerationResult {
    1: required NumericInternalID internal_id
    2: optional msgpack.Value context
}

struct GetNumericInternalIDResult {
    1: required NumericInternalID internal_id
    2: required msgpack.Value context
}

service Bender {

    GenerationResult GenerateID (
        1: ExternalID external_id,
        2: GenerationSchema schema,
        3: msgpack.Value context
    )

    GetInternalIDResult GetInternalID (
        1: ExternalID external_id
    )
        throws (1: InternalIDNotFound ex1)

    NumericGenerationResult GenerateNumericID (
        1: NumericExternalID external_id,
        2: NumericGenerationSchema schema,
        3: msgpack.Value context
    )

    GetNumericInternalIDResult GetNumericInternalID (
        1: NumericExternalID external_id
    )
        throws (1: InternalIDNotFound ex1)

}
