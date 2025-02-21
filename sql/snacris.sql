\echo 'Delete and recreate snacris db?'
\prompt 'Return for yes or control-C to cancel > ' foo

DROP DATABASE IF EXISTS snacris;
CREATE DATABASE snacris;
\connect snacris

\i snacris-users-schema.sql
\i schema/snacris-acris-real-property-schema.sql
\i schema/snacris-acris-personal-property-schema.sql
\i schema/snacris-acris-code-mappings-schema.sql
\i seed/snacris-seed-users.sql
\i seed/snacris-seed-acris-document-control-codes.sql
\i seed/snacris-seed-acris-ucc-collateral-type-codes.sql
\i seed/snacris-seed-acris-property-type-codes.sql
\i seed/snacris-seed-acris-usa-state-codes.sql
\i seed/snacris-seed-acris-country-codes.sql

\echo 'Delete and recreate snacris_test db?'
\prompt 'Return for yes or control-C to cancel > ' foo

DROP DATABASE IF EXISTS snacris_test;
CREATE DATABASE snacris_test;
\connect snacris_test

\i snacris-users-schema.sql
\i schema/snacris-acris-real-property-schema.sql
\i schema/snacris-acris-personal-property-schema.sql
\i schema/snacris-acris-code-mappings-schema.sql
\i seed/snacris-seed-users.sql
\i seed/snacris-seed-acris-document-control-codes.sql
\i seed/snacris-seed-acris-ucc-collateral-type-codes.sql
\i seed/snacris-seed-acris-property-type-codes.sql
\i seed/snacris-seed-acris-usa-state-codes.sql
\i seed/snacris-seed-acris-country-codes.sql