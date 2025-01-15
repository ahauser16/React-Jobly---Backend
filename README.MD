# react jobly (backend)

**TABLE OF CONTENTS**
- [react jobly (backend)](#react-jobly-backend)
  - [Refactor Notes](#refactor-notes)
    - [To Do List](#to-do-list)
      - [Supabase Integration / NOTES](#supabase-integration--notes)
      - [data table todos](#data-table-todos)
      - [models todos](#models-todos)
      - [schemas todos](#schemas-todos)
      - [routes todos](#routes-todos)
    - [Refactor Plan](#refactor-plan)
      - [Planning the Database Structure for ACRIS Datasets](#planning-the-database-structure-for-acris-datasets)
    - [Cross Referencing Datasets: RealPropertyMaster and RealPropertyParties with DocumentControls](#cross-referencing-datasets-realpropertymaster-and-realpropertyparties-with-documentcontrols)
  - [codebase architecture notes](#codebase-architecture-notes)
    - [Data Flow - User Perspective](#data-flow---user-perspective)
    - [Code Overview](#code-overview)
      - [`server.js` overview](#serverjs-overview)
      - [`app.js` overview](#appjs-overview)
      - [`config.js` overview](#configjs-overview)
      - [`db.js` overview](#dbjs-overview)
      - [models overview](#models-overview)
        - [`user.js` model overview](#userjs-model-overview)
        - [`company.js` model overview](#companyjs-model-overview)
        - [`job.js` model overview](#jobjs-model-overview)
      - [routes overview](#routes-overview)
        - [`auth.js` route overview](#authjs-route-overview)
        - [`users.js` route overview](#usersjs-route-overview)
        - [`companies.js` route overview](#companiesjs-route-overview)
        - [`jobs.js` route overview](#jobsjs-route-overview)
      - [schemas overview](#schemas-overview)
        - [`companyNew.json` schema overview](#companynewjson-schema-overview)
        - [`companySearch.json` schema overview](#companysearchjson-schema-overview)
        - [`companyUpdate.json` schema overview](#companyupdatejson-schema-overview)
        - [`jobNew.json` schema overview](#jobnewjson-schema-overview)
        - [`jobSearch.json` schema overview](#jobsearchjson-schema-overview)
        - [`jobUpdate.json` schema overview](#jobupdatejson-schema-overview)
        - [`userAuth.json` schema overview](#userauthjson-schema-overview)
        - [`userNew.json` schema overview](#usernewjson-schema-overview)
        - [`userRegister.json` schema overview](#userregisterjson-schema-overview)
        - [`userUpdate.json` schema overview](#userupdatejson-schema-overview)
      - [Data Tables Overview](#data-tables-overview)
      - [Model, Route \& Schema Integration](#model-route--schema-integration)

## Refactor Notes

These notes are for how to use this template for my own backend.

### To Do List

#### Supabase Integration / NOTES

- see `supabase_notes.md`


#### data table todos
- [ ] refactor `jobly.sql` to `snacris.sql` by changing "jobly" references to "snacris" references.  The file should still prompt the user to confirm the deletion and recreation of the `snacris` database, drop the existing `snacris` database if it exists, create a new `snacris` database, execute the `snacris-schema.sql` (f/k/a `jobly-schema.sql`) file to create the database schema, execute the `snacris-seed.sql` file (f/k/a `jobly-seed.sql`) to populate the database with initial data and repeat the process for the `snacris_test` database which is used for testing purposes.

- [ ] refactor `jobly-schema.sql` to `snacris-schema.sql` by keeping the `users` table and removing all the table references.  Add a table for each of the 15 ACRIS datasets listed below.  See [Planning the Database Structure for ACRIS Datasets](#planning-the-database-structure-for-acris-datasets) for a more detailed plan.
  - [ ] ACRIS_REAL_PROPERTY_MASTER 
  - [ ] ACRIS_REAL_PROPERTY_LEGALS 
  - [ ] ACRIS_REAL_PROPERTY_PARTIES 
  - [ ] ACRIS_REAL_PROPERTY_REFERENCES 
  - [ ] ACRIS_REAL_PROPERTY_REMARKS 
  - [ ] ACRIS_PERSONAL_PROPERTY_MASTER 
  - [ ] ACRIS_PERSONAL_PROPERTY_LEGALS 
  - [ ] ACRIS_PERSONAL_PROPERTY_PARTIES 
  - [ ] ACRIS_PERSONAL_PROPERTY_REFERENCES 
  - [ ] DOCUMENT_CONTROL 
  - [ ] UCC_COLLATERAL 
  - [ ] PROPERTY_TYPE_RECORD 
  - [ ] STATE_CODES 
  - [ ] COUNTRY_TYPE_RECORD 

- [ ] refactor `jobly-seed.sql` to `snacris-seed.sql` by keeping the `INSERT INTO users (username, password, first_name, last_name, email, is_admin)` reference and removing the `INSERT INTO companies ... ` and `INSERT INTO jobs ... ` data.  Instead I want to include the data from the `DOCUMENT_CONTROL`, `UCC_COLLATERAL`, `PROPERTY_TYPE_RECORD`, `STATE_CODES` and `COUNTRY_TYPE_RECORD` datasets into their respective table.  This will reduce the number of API calls when data is needed, however, you should have a way to check that these datasets do not change or are replaced.
  

#### models todos
- [ ] keep the `user.js` model as is but create a model for each of the 15 datasets and keep in mind this is where structures and methods are defined that will interact with the database.
  
#### schemas todos

- [ ] Keep the `userAuth.json`, `userNew.json`, `userRegister.json` and `userUpdate.json` files as they are and create a schema for each dataset to be used to validate the API calls in your routes.

#### routes todos

Define routes to handle API requests, construct the query URLs, send GET requests, receive the API response data, and store it in the database.  Below are examples of what that code could look like.

`realProperty.js`
```js
// routes/realProperty.js
"use strict";

const express = require("express");
const axios = require("axios");
const AcrisRealPropertyMaster = require("../models/acrisRealPropertyMaster");
const { BadRequestError } = require("../expressError");

const router = new express.Router();

router.get("/master", async function (req, res, next) {
  try {
    const { document_id } = req.query;
    if (!document_id) {
      throw new BadRequestError("document_id is required");
    }

    const url = `https://api.example.com/acris_real_property_master?document_id=${document_id}`;
    const response = await axios.get(url);
    const data = response.data;

    // Save data to the database
    const savedData = await AcrisRealPropertyMaster.create(data);

    // Organize and manipulate data as needed
    return res.json({ savedData });
  } catch (err) {
    return next(err);
  }
});

// Add other routes as needed

module.exports = router;
```

`personalProperty.js`
```js
// routes/personalProperty.js
"use strict";

const express = require("express");
const axios = require("axios");
const AcrisPersonalPropertyMaster = require("../models/acrisPersonalPropertyMaster");
const { BadRequestError } = require("../expressError");

const router = new express.Router();

router.get("/master", async function (req, res, next) {
  try {
    const { document_id } = req.query;
    if (!document_id) {
      throw new BadRequestError("document_id is required");
    }

    const url = `https://api.example.com/acris_personal_property_master?document_id=${document_id}`;
    const response = await axios.get(url);
    const data = response.data;

    // Save data to the database
    const savedData = await AcrisPersonalPropertyMaster.create(data);

    // Organize and manipulate data as needed
    return res.json({ savedData });
  } catch (err) {
    return next(err);
  }
});

// Add other routes as needed

module.exports = router;
```

### Refactor Plan

#### Planning the Database Structure for ACRIS Datasets

To structure your PostgreSQL database for the ACRIS datasets, you should follow best practices for database design, including normalization, indexing, and ensuring data integrity. 

Keep in mind that the `DOCUMENT_CONTROL`, `PROPERTY_TYPE_RECORD`, `STATE_CODES` and `COUNTRY_TYPE_RECORD` can be cross referenced with the Real Property datasets.  I've made the following notes about these relationships here and will try to construct the `sql` tables to reflect them further below.

1. The `doc__type` (notice the double `_`) field associated with the `DOCUMENT_CONTROL` dataset contains values that are used to query the `doc_type` (notice the single `_`) field associated with the `ACRIS_REAL_PROPERTY_MASTER` dataset.
2. The `party1_type`, `party2_type` and `party3_type` fields associated with the `DOCUMENT_CONTROL` dataset contain text type data values (e.g. "GRANTOR/SELLER", "GRANTEE/BUYER" or no reference) that vary based on the value of `doc__type` (e.g. "DEED"). The `party_type` field associated with the `ACRIS_REAL_PROPERTY_PARTIES` dataset contains a single character of either "1", "2" or "3" which indicates that the name associated with a specific record from the `ACRIS_REAL_PROPERTY_PARTIES` dataset is the value represented by one of the `party1_type`, `party2_type` and `party3_type` fields cross referenced with value of `doc_type` field associated with the `ACRIS_REAL_PROPERTY_MASTER` dataset. 
   - For example, if I cross reference the `ACRIS_REAL_PROPERTY_MASTER` and `ACRIS_REAL_PROPERTY_PARTIES` datasets with a `document_id` and the `doc_type` value is "DEED" and the `party_type` value is "1" then I can cross-reference those values with the `DOCUMENT_CONTROL_CODES` dataset to find out that the party is a "GRANTOR/SELLER".
   - To handle the cross-reference with the `DOCUMENT_CONTROL` dataset based on the workflow you described, you can create a function in the model associated with the `ACRIS_REAL_PROPERTY_PARTIES` table. This function will use the `document_id` to retrieve the `doc_type` from the `ACRIS_REAL_PROPERTY_MASTER` table and then use the `party_type` to get the appropriate party type description from the `DOCUMENT_CONTROL` table.  A more detailed solution can be found [here](#cross-referencing-datasets-realpropertymaster-and-realpropertyparties-with-documentcontrols)

3. The `property_type` value associated with the `PROPERTY_TYPE_RECORD` can be used to query the `property_type` field associated with the `ACRIS_REAL_PROPERTY_LEGALS` dataset.
4. The `state_code` field associated with the `STATE_CODES` dataset can be used to query the state field associated with the `ACRIS_REAL_PROPERTY_PARTIES` dataset.
5. The `country_code` field associated with the `COUNTRY_TYPE_RECORD` dataset can be used to query the country field associated with the `ACRIS_REAL_PROPERTY_PARTIES` dataset.

Here is a step-by-step approach to plan and implement the database structure:

[BACK TO TOC](#react-jobly-backend)

**1. Define the Database Schema**

Create tables for each dataset, ensuring that the `document_id` field is used as a foreign key to establish relationships between the tables. Here is an example of how you can define the schema for the Real Property datasets:

**Real Property Datasets**

```sql
CREATE TABLE acris_real_property_master (
    document_id VARCHAR(16) PRIMARY KEY,
    record_type CHAR(1) NOT NULL,
    crfn VARCHAR(13),
    recorded_borough INTEGER,
    doc_type VARCHAR(8) REFERENCES document_control(doc_type),
    document_date DATE,
    document_amt NUMERIC(16, 2),
    recorded_datetime TIMESTAMP,
    modified_date DATE,
    reel_yr INTEGER,
    reel_nbr INTEGER,
    reel_pg INTEGER,
    percent_trans NUMERIC(9, 6),
    good_through_date DATE
);

CREATE TABLE acris_real_property_legals (
    id SERIAL PRIMARY KEY,
    document_id VARCHAR(16) REFERENCES acris_real_property_master(document_id),
    record_type CHAR(1) NOT NULL,
    borough INTEGER,
    block INTEGER,
    lot INTEGER,
    easement CHAR(1),
    partial_lot CHAR(1),
    air_rights CHAR(1),
    subterranean_rights CHAR(1),
    property_type CHAR(2) REFERENCES property_type_record(property_type),
    street_number VARCHAR(12),
    street_name VARCHAR(32),
    unit_address VARCHAR(7),
    good_through_date DATE
);

CREATE TABLE acris_real_property_parties (
    id SERIAL PRIMARY KEY,
    document_id VARCHAR(16) REFERENCES acris_real_property_master(document_id),
    record_type CHAR(1) NOT NULL,
    party_type CHAR(1),
    name VARCHAR(70),
    address_1 VARCHAR(60),
    address_2 VARCHAR(60),
    country CHAR(2) REFERENCES country_type_record(country_code),
    city VARCHAR(30),
    state CHAR(2) REFERENCES state_codes(state_code),
    zip VARCHAR(9),
    good_through_date DATE
);

CREATE TABLE acris_real_property_references (
    id SERIAL PRIMARY KEY,
    document_id VARCHAR(16) REFERENCES acris_real_property_master(document_id),
    record_type CHAR(1) NOT NULL,
    reference_by_crfn VARCHAR(13),
    reference_by_doc_id VARCHAR(16),
    reference_by_reel_year INTEGER,
    reference_by_reel_borough INTEGER,
    reference_by_reel_nbr INTEGER,
    reference_by_reel_page INTEGER,
    good_through_date DATE
);

CREATE TABLE acris_real_property_remarks (
    id SERIAL PRIMARY KEY,
    document_id VARCHAR(16) REFERENCES acris_real_property_master(document_id),
    record_type CHAR(1) NOT NULL,
    sequence_number INTEGER,
    remark_text VARCHAR(232),
    good_through_date DATE
);

CREATE INDEX idx_acris_real_property_legals_document_id ON acris_real_property_legals(document_id);
CREATE INDEX idx_acris_real_property_parties_document_id ON acris_real_property_parties(document_id);
CREATE INDEX idx_acris_real_property_references_document_id ON acris_real_property_references(document_id);
CREATE INDEX idx_acris_real_property_remarks_document_id ON acris_real_property_remarks(document_id);
```

**Personal Property Datasets**

```sql
CREATE TABLE acris_personal_property_master (
    document_id VARCHAR(16) PRIMARY KEY,
    record_type CHAR(1) NOT NULL,
    crfn VARCHAR(13),
    recorded_borough INTEGER,
    doc_type VARCHAR(8) REFERENCES document_control(doc_type),
    document_amt NUMERIC(16, 2),
    recorded_datetime TIMESTAMP,
    ucc_collateral VARCHAR(50),
    fedtax_serial_nbr VARCHAR(50),
    fedtax_assessment_date DATE,
    rpttl_nbr INTEGER,
    modified_date DATE,
    reel_yr INTEGER,
    reel_nbr INTEGER,
    reel_pg INTEGER,
    file_nbr VARCHAR(50),
    good_through_date TIMESTAMP
);

CREATE TABLE acris_personal_property_legals (
    id SERIAL PRIMARY KEY,
    document_id VARCHAR(16) REFERENCES acris_personal_property_master(document_id),
    record_type CHAR(1) NOT NULL,
    borough INTEGER,
    block INTEGER,
    lot INTEGER,
    easement CHAR(1),
    partial_lot CHAR(1),
    air_rights CHAR(1),
    subterranean_rights CHAR(1),
    property_type CHAR(2) REFERENCES property_type_record(property_type),
    street_number VARCHAR(12),
    street_name VARCHAR(32),
    addr_unit VARCHAR(7),
    good_through_date TIMESTAMP
);

CREATE TABLE acris_personal_property_parties (
    id SERIAL PRIMARY KEY,
    document_id VARCHAR(16) REFERENCES acris_personal_property_master(document_id),
    record_type CHAR(1) NOT NULL,
    party_type CHAR(1),
    name VARCHAR(70),
    address_1 VARCHAR(60),
    address_2 VARCHAR(60),
    country CHAR(2) REFERENCES country_type_record(country_code),
    city VARCHAR(30),
    state CHAR(2) REFERENCES state_codes(state_code),
    zip VARCHAR(9),
    good_through_date TIMESTAMP
);

CREATE TABLE acris_personal_property_references (
    id SERIAL PRIMARY KEY,
    document_id VARCHAR(16) REFERENCES acris_personal_property_master(document_id),
    record_type CHAR(1) NOT NULL,
    crfn VARCHAR(13),
    doc_id_ref VARCHAR(16),
    file_nbr VARCHAR(50),
    good_through_date TIMESTAMP
);

CREATE TABLE acris_personal_property_remarks (
    id SERIAL PRIMARY KEY,
    document_id VARCHAR(16) REFERENCES acris_personal_property_master(document_id),
    record_type CHAR(1) NOT NULL,
    sequence_number INTEGER,
    remark_text VARCHAR(232),
    good_through_date TIMESTAMP
);

CREATE INDEX idx_acris_personal_property_legals_document_id ON acris_personal_property_legals(document_id);
CREATE INDEX idx_acris_personal_property_parties_document_id ON acris_personal_property_parties(document_id);
CREATE INDEX idx_acris_personal_property_references_document_id ON acris_personal_property_references(document_id);
CREATE INDEX idx_acris_personal_property_remarks_document_id ON acris_personal_property_remarks(document_id);
```

**CODE MAPPINGS DATASETS**

Create tables for each dataset, ensuring that the `CODE MAPPINGS` datasets (which are smaller) have reference tables that can be used to query the `REAL PROPERTY` and `PERSONAL PROPERTY` datasets (which are larger).

```sql
CREATE TABLE document_control (
    id SERIAL PRIMARY KEY,
    record_type CHAR(1) NOT NULL,
    doc_type VARCHAR(8) UNIQUE NOT NULL,
    doc_type_description VARCHAR(30),
    class_code_description VARCHAR(30),
    party1_type VARCHAR(20),
    party2_type VARCHAR(20),
    party3_type VARCHAR(20)
);

CREATE TABLE ucc_collateral (
    id SERIAL PRIMARY KEY,
    record_type CHAR(1) NOT NULL,
    ucc_collateral_code CHAR(1) UNIQUE NOT NULL,
    description VARCHAR(50)
);

CREATE TABLE property_type_record (
    id SERIAL PRIMARY KEY,
    record_type CHAR(1) NOT NULL,
    property_type CHAR(2) UNIQUE NOT NULL,
    description VARCHAR(40)
);

CREATE TABLE state_codes (
    id SERIAL PRIMARY KEY,
    record_type CHAR(1) NOT NULL,
    state_code CHAR(2) UNIQUE NOT NULL,
    description VARCHAR(20)
);

CREATE TABLE country_type_record (
    id SERIAL PRIMARY KEY,
    record_type CHAR(1) NOT NULL,
    country_code CHAR(2) UNIQUE NOT NULL,
    description VARCHAR(20)
);
```

[BACK TO TOC](#react-jobly-backend)

**snacris.sql**

```sql

```


---
---
---

1. Models

Define models for each table in your application. These models will interact with the database and perform CRUD operations.

**Real Property Datasets**

Example for `acris_real_property_master`:

```js
// models/acrisRealPropertyMaster.js
"use strict";

const db = require("../db");

class AcrisRealPropertyMaster {
  static async create(data) {
    const result = await db.query(
      `INSERT INTO acris_real_property_master
       (document_id, record_type, crfn, recorded_borough, doc_type, document_date, document_amt, recorded_datetime, modified_date, reel_yr, reel_nbr, reel_pg, percent_trans, good_through_date)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)
       RETURNING *`,
      [
        data.document_id,
        data.record_type,
        data.crfn,
        data.recorded_borough,
        data.doc_type,
        data.document_date,
        data.document_amt,
        data.recorded_datetime,
        data.modified_date,
        data.reel_yr,
        data.reel_nbr,
        data.reel_pg,
        data.percent_trans,
        data.good_through_date,
      ]
    );
    return result.rows[0];
  }

  // Add other CRUD methods as needed
}

module.exports = AcrisRealPropertyMaster;
```

Example of `acris_real_property_parties`:

```js
// models/acrisRealPropertyParties.js
"use strict";

const db = require("../db");

class AcrisRealPropertyParties {
  static async create(data) {
    const result = await db.query(
      `INSERT INTO acris_real_property_parties
       (document_id, record_type, party_type, name, address_1, address_2, country, city, state, zip, good_through_date)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
       RETURNING *`,
      [
        data.document_id,
        data.record_type,
        data.party_type,
        data.name,
        data.address_1,
        data.address_2,
        data.country,
        data.city,
        data.state,
        data.zip,
        data.good_through_date,
      ]
    );
    return result.rows[0];
  }

  static async getPartyTypeDescription(documentId, partyType) {
    const result = await db.query(
      `SELECT dc.party${partyType}_type AS party_type_description
       FROM acris_real_property_master rpm
       JOIN document_control dc ON rpm.doc_type = dc.doc_type
       WHERE rpm.document_id = $1`,
      [documentId]
    );

    if (result.rows.length === 0) {
      throw new Error(`No party type description found for document ID: ${documentId} and party type: ${partyType}`);
    }

    return result.rows[0].party_type_description;
  }

  // Add other CRUD methods as needed
}

module.exports = AcrisRealPropertyParties;
```

**Personal Property Datasets**

Example for `acris_personal_property_master`:

```js
// models/acrisPersonalPropertyMaster.js
"use strict";

const db = require("../db");

class AcrisPersonalPropertyMaster {
  static async create(data) {
    const result = await db.query(
      `INSERT INTO acris_personal_property_master
       (document_id, record_type, crfn, recorded_borough, doc_type, document_amt, recorded_datetime, ucc_collateral, fedtax_serial_nbr, fedtax_assessment_date, rpttl_nbr, modified_date, reel_yr, reel_nbr, reel_pg, file_nbr, good_through_date)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17)
       RETURNING *`,
      [
        data.document_id,
        data.record_type,
        data.crfn,
        data.recorded_borough,
        data.doc_type,
        data.document_amt,
        data.recorded_datetime,
        data.ucc_collateral,
        data.fedtax_serial_nbr,
        data.fedtax_assessment_date,
        data.rpttl_nbr,
        data.modified_date,
        data.reel_yr,
        data.reel_nbr,
        data.reel_pg,
        data.file_nbr,
        data.good_through_date,
      ]
    );
    return result.rows[0];
  }

  // Add other CRUD methods as needed
}

module.exports = AcrisPersonalPropertyMaster;
```

[BACK TO TOC](#react-jobly-backend)

4. Routes

Define routes to handle API requests for each dataset. Use JSON schemas to validate the input data.

**Real Property Datasets**

Example for `acris_real_property_master`:
```js
// routes/acrisRealPropertyMaster.js
"use strict";

const express = require("express");
const jsonschema = require("jsonschema");
const AcrisRealPropertyMaster = require("../models/acrisRealPropertyMaster");
const acrisRealPropertyMasterSchema = require("../schemas/acrisRealPropertyMaster.json");
const { BadRequestError } = require("../expressError");

const router = new express.Router();

router.post("/", async function (req, res, next) {
  try {
    const validator = jsonschema.validate(req.body, acrisRealPropertyMasterSchema);
    if (!validator.valid) {
      const errs = validator.errors.map(e => e.stack);
      throw new BadRequestError(errs);
    }

    const acrisRecord = await AcrisRealPropertyMaster.create(req.body);
    return res.status(201).json({ acrisRecord });
  } catch (err) {
    return next(err);
  }
});

// Add other routes as needed

module.exports = router;
```

**Personal Property Datasets**

Example for `acris_personal_property_master`:

```js
// routes/acrisPersonalPropertyMaster.js
"use strict";

const express = require("express");
const jsonschema = require("jsonschema");
const AcrisPersonalPropertyMaster = require("../models/acrisPersonalPropertyMaster");
const acrisPersonalPropertyMasterSchema = require("../schemas/acrisPersonalPropertyMaster.json");
const { BadRequestError } = require("../expressError");

const router = new express.Router();

router.post("/", async function (req, res, next) {
  try {
    const validator = jsonschema.validate(req.body, acrisPersonalPropertyMasterSchema);
    if (!validator.valid) {
      const errs = validator.errors.map(e => e.stack);
      throw new BadRequestError(errs);
    }

    const acrisRecord = await AcrisPersonalPropertyMaster.create(req.body);
    return res.status(201).json({ acrisRecord });
  } catch (err) {
    return next(err);
  }
});

// Add other routes as needed

module.exports = router;
```

[BACK TO TOC](#react-jobly-backend)

5. Schemas

Define JSON schemas for validating input data for each dataset.

**Real Property Datasets**

Example for `acris_real_property_master`:

```json
// schemas/acrisRealPropertyMaster.json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "document_id": { "type": "string", "minLength": 16, "maxLength": 16 },
    "record_type": { "type": "string", "minLength": 1, "maxLength": 1 },
    "crfn": { "type": "string", "minLength": 13, "maxLength": 13 },
    "recorded_borough": { "type": "integer" },
    "doc_type": { "type": "string", "minLength": 1, "maxLength": 8 },
    "document_date": { "type": "string", "format": "date" },
    "document_amt": { "type": "number" },
    "recorded_datetime": { "type": "string", "format": "date-time" },
    "modified_date": { "type": "string", "format": "date" },
    "reel_yr": { "type": "integer" },
    "reel_nbr": { "type": "integer" },
    "reel_pg": { "type": "integer" },
    "percent_trans": { "type": "number" },
    "good_through_date": { "type": "string", "format": "date" }
  },
  "required": ["document_id", "record_type"]
}
```

**Personal Property Datasets**

Example for `acris_personal_property_master`:

```json
// schemas/acrisPersonalPropertyMaster.json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "document_id": { "type": "string", "minLength": 16, "maxLength": 16 },
    "record_type": { "type": "string", "minLength": 1, "maxLength": 1 },
    "crfn": { "type": "string", "minLength": 13, "maxLength": 13 },
    "recorded_borough": { "type": "integer" },
    "doc_type": { "type": "string", "minLength": 1, "maxLength": 8 },
    "document_amt": { "type": "number" },
    "recorded_datetime": { "type": "string", "format": "date-time" },
    "ucc_collateral": { "type": "string" },
    "fedtax_serial_nbr": { "type": "string" },
    "fedtax_assessment_date": { "type": "string", "format": "date" },
    "rpttl_nbr": { "type": "integer" },
    "modified_date": { "type": "string", "format": "date" },
    "reel_yr": { "type": "integer" },
    "reel_nbr": { "type": "integer" },
    "reel_pg": { "type": "integer" },
    "file_nbr": { "type": "string" },
    "good_through_date": { "type": "string", "format": "date-time" }
  },
  "required": ["document_id", "record_type"]
}
```

[BACK TO TOC](#react-jobly-backend)

### Cross Referencing Datasets: RealPropertyMaster and RealPropertyParties with DocumentControls

**Update the Database Schema**

Ensure that the `party_type` field in the `ACRIS_REAL_PROPERTY_PARTIES` table is properly defined:
```sql
CREATE TABLE acris_real_property_parties (
    id SERIAL PRIMARY KEY,
    document_id VARCHAR(16) REFERENCES acris_real_property_master(document_id),
    record_type CHAR(1) NOT NULL,
    party_type CHAR(1),
    name VARCHAR(70),
    address_1 VARCHAR(60),
    address_2 VARCHAR(60),
    country CHAR(2) REFERENCES country_type_record(country_code),
    city VARCHAR(30),
    state CHAR(2) REFERENCES state_codes(state_code),
    zip VARCHAR(9),
    good_through_date DATE
);
```

**Define the Model for `ACRIS_REAL_PROPERTY_PARTIES`**
Create a model for the `ACRIS_REAL_PROPERTY_PARTIES` table and add a function to perform the cross-reference with the `DOCUMENT_CONTROL` table:

```js
// models/acrisRealPropertyParties.js
"use strict";

const db = require("../db");

class AcrisRealPropertyParties {
  static async create(data) {
    const result = await db.query(
      `INSERT INTO acris_real_property_parties
       (document_id, record_type, party_type, name, address_1, address_2, country, city, state, zip, good_through_date)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
       RETURNING *`,
      [
        data.document_id,
        data.record_type,
        data.party_type,
        data.name,
        data.address_1,
        data.address_2,
        data.country,
        data.city,
        data.state,
        data.zip,
        data.good_through_date,
      ]
    );
    return result.rows[0];
  }

  static async getPartyTypeDescription(documentId, partyType) {
    const result = await db.query(
      `SELECT dc.party${partyType}_type AS party_type_description
       FROM acris_real_property_master rpm
       JOIN document_control dc ON rpm.doc_type = dc.doc_type
       WHERE rpm.document_id = $1`,
      [documentId]
    );

    if (result.rows.length === 0) {
      throw new Error(`No party type description found for document ID: ${documentId} and party type: ${partyType}`);
    }

    return result.rows[0].party_type_description;
  }

  // Add other CRUD methods as needed
}

module.exports = AcrisRealPropertyParties;
```

**Define the Route for `ACRIS_REAL_PROPERTY_PARTIES`**
Create a route to handle API requests for the `ACRIS_REAL_PROPERTY_PARTIES` table and use the function to get the party type description:

```js
// routes/acrisRealPropertyParties.js
"use strict";

const express = require("express");
const jsonschema = require("jsonschema");
const AcrisRealPropertyParties = require("../models/acrisRealPropertyParties");
const acrisRealPropertyPartiesSchema = require("../schemas/acrisRealPropertyParties.json");
const { BadRequestError } = require("../expressError");

const router = new express.Router();

router.post("/", async function (req, res, next) {
  try {
    const validator = jsonschema.validate(req.body, acrisRealPropertyPartiesSchema);
    if (!validator.valid) {
      const errs = validator.errors.map(e => e.stack);
      throw new BadRequestError(errs);
    }

    const acrisRecord = await AcrisRealPropertyParties.create(req.body);
    return res.status(201).json({ acrisRecord });
  } catch (err) {
    return next(err);
  }
});

router.get("/:documentId/:partyType", async function (req, res, next) {
  try {
    const { documentId, partyType } = req.params;
    const partyTypeDescription = await AcrisRealPropertyParties.getPartyTypeDescription(documentId, partyType);
    return res.json({ partyTypeDescription });
  } catch (err) {
    return next(err);
  }
});

// Add other routes as needed

module.exports = router;
```

**Define the JSON Schema for `ACRIS_REAL_PROPERTY_PARTIES`**

Create a JSON schema for validating input data for the `ACRIS_REAL_PROPERTY_PARTIES` table

```json
// schemas/acrisRealPropertyParties.json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "document_id": { "type": "string", "minLength": 16, "maxLength": 16 },
    "record_type": { "type": "string", "minLength": 1, "maxLength": 1 },
    "party_type": { "type": "string", "minLength": 1, "maxLength": 1 },
    "name": { "type": "string", "maxLength": 70 },
    "address_1": { "type": "string", "maxLength": 60 },
    "address_2": { "type": "string", "maxLength": 60 },
    "country": { "type": "string", "minLength": 2, "maxLength": 2 },
    "city": { "type": "string", "maxLength": 30 },
    "state": { "type": "string", "minLength": 2, "maxLength": 2 },
    "zip": { "type": "string", "maxLength": 9 },
    "good_through_date": { "type": "string", "format": "date" }
  },
  "required": ["document_id", "record_type", "party_type"]
}
```

**Conclusion**
By following this approach, you can handle the relationship between the `party_type` field in the `ACRIS_REAL_PROPERTY_PARTIES` table and the `DOCUMENT_CONTROL` table. The function in the model will perform the cross-reference to retrieve the appropriate party type description, ensuring that your application can efficiently query and display the relevant data. This setup allows you to maintain data integrity and optimize query performance by leveraging the relationships between the datasets.



## codebase architecture notes

The following are my own notes to understand how the backend server of the `React-jobly` assignment can be used for my own backend server to be used with my Google Chrome Extension called "SNACRIS".

### Data Flow - User Perspective

When a user interacts with the front end of the Jobly application, the data flow involves several key files: `app.js`, `config.js`, `db.js`, and `server.js`. These files work together with the route files, schema files, and model files to handle user registration, authentication, and other interactions.

When a user registers, they submit a registration form on the front end. This form data is sent as a POST request to the `/auth/register` endpoint. The `authRoutes` in `app.js` handles this request. The `app.js` file sets up the Express application and configures middleware for handling CORS, JSON parsing, logging, and JWT authentication. It defines routes for authentication, companies, users, and jobs. The `authRoutes` validate the input data using the `userRegisterSchema` from the `schemas` folder. This validation ensures that the data conforms to the expected format before it is processed.

If the data is valid, the `User.register` method from the `user.js` model is called to create a new user in the database. The `user.js` model contains methods for interacting with the `users` table in the database. It handles hashing passwords and validating user data. The model inserts the user data into the database, and a JWT token is generated and returned to the front end.

For user authentication, the user submits a login form on the front end. This form data is sent as a POST request to the `/auth/token` endpoint. The `authRoutes` in `app.js` handle this request, validating the input data using the `userAuthSchema` from the `schemas` folder. If the data is valid, the `User.authenticate` method from the `user.js` model is called to verify the user's credentials. If the credentials are correct, a JWT token is generated and returned to the front end.

When the user interacts with various features on the front end, such as viewing companies, jobs, or updating their profile, the front end sends requests to the corresponding endpoints (`/companies`, `/jobs`, `/users`). The routes in `app.js` handle these requests, validating the input data using the appropriate schemas from the `schemas` folder. The routes call the corresponding methods from the `company.js`, `job.js`, or `user.js` models to interact with the database. The models perform the necessary database operations and return the results to the routes. The routes then send the results back to the front end as responses.

The `config.js` file contains configuration settings for the application. It loads environment variables using `dotenv`, sets up constants like `SECRET_KEY` and `PORT`, and defines a function to get the database URI based on the environment. It also configures the bcrypt work factor for password hashing. This configuration is essential for setting up the environment and ensuring secure operations.

The `db.js` file sets up the connection to the PostgreSQL database using the `pg` library. It determines the database URI based on the environment and configures SSL for production. It exports the connected database client for use in other parts of the application. This database connection is crucial for storing and retrieving data.

Finally, the `server.js` file is the entry point for the backend server. It imports the Express application from `app.js` and starts the server on the specified port. The port number is retrieved from the configuration file. This file ensures that the server is running and listening for incoming requests.

In summary, the backend server application for Jobly handles user registration, authentication, and interactions with the front end through a well-structured flow of data. The `app.js`, `config.js`, `db.js`, and `server.js` files work together with the route files, schema files, and model files to ensure that data is validated, processed, and stored correctly, providing a seamless experience for the user.

[BACK TO TOC](#react-jobly-backend)

### Code Overview

#### `server.js` overview

This file is the entry point for the backend server. It imports the Express application from `app.js` and starts the server on the specified port. The port number is retrieved from the configuration file.

#### `app.js` overview

This file sets up the Express application. It configures middleware for handling CORS, JSON parsing, logging, and JWT authentication. It also defines routes for authentication, companies, users, and jobs. Additionally, it includes error handling for 404 errors and other generic errors.

#### `config.js` overview

This file contains configuration settings for the application. It loads environment variables using `dotenv`, sets up constants like `SECRET_KEY` and `PORT`, and defines a function to get the database URI based on the environment. It also configures the bcrypt work factor for password hashing.

#### `db.js` overview

This file sets up the connection to the PostgreSQL database using the `pg` library. It determines the database URI based on the environment and configures SSL for production. It exports the connected database client for use in other parts of the application.

[BACK TO TOC](#react-jobly-backend)

#### models overview

The models folder contains files like `company.js`, `job.js`, and `user.js`, which define the structure and methods for interacting with the database. These models encapsulate the logic for creating, reading, updating, and deleting records in the database. For example, the `Job` model includes methods for creating a job, finding jobs with optional filters, retrieving a job by ID, updating job data, and deleting a job.

##### `user.js` model overview

This file defines the `User` model, which contains methods for interacting with the `users` table in the database. It includes methods for user authentication, registration, retrieval, updating, and deletion. It also includes a method for applying to jobs. The model handles hashing passwords and validating user data.

##### `company.js` model overview

This file defines the `Company` model, which contains methods for interacting with the `companies` table in the database. It includes methods for creating, retrieving, updating, and deleting companies. It also supports filtering companies based on search criteria and retrieving associated jobs for a company.

##### `job.js` model overview

This file defines the `Job` model, which contains methods for interacting with the `jobs` table in the database. It includes methods for creating, retrieving, updating, and deleting jobs. It also supports filtering job listings based on specific criteria. The model handles the association between jobs and companies, ensuring that job data includes relevant company details.

[BACK TO TOC](#react-jobly-backend)

#### routes overview

The `routes` folder contains files like `auth.js`, `companies.js`, `jobs.js`, and `users.js`, which define the API endpoints for the application. These routes handle HTTP requests, invoke the appropriate model methods, and return responses to the client. For instance, the `jobs.js` route file includes endpoints for creating a new job, retrieving all jobs, retrieving a specific job, updating a job, and deleting a job. The routes also include middleware functions for tasks like authentication and authorization.

##### `auth.js` route overview
This file defines the authentication-related routes. It includes routes for logging in (`POST /auth/token`) and registering (`POST /auth/register`). These routes validate the input data using JSON schemas and handle user authentication and registration, returning a JWT token upon successful login or registration.

##### `users.js` route overview
This file defines the user-related routes. It includes routes for adding new users (`POST /`), retrieving all users (`GET /`), retrieving a specific user (`GET /:username`), updating a user (`PATCH /:username`), deleting a user (`DELETE /:username`), and applying to a job (`POST /:username/jobs/:id`). These routes validate the input data using JSON schemas and ensure proper authorization using middleware functions.

##### `companies.js` route overview
This file defines the company-related routes. It includes routes for creating a new company (`POST /`), retrieving all companies (`GET /`), retrieving a specific company (`GET /:handle`), updating a company (`PATCH /:handle`), and deleting a company (`DELETE /:handle`). These routes validate the input data using JSON schemas and ensure proper authorization using middleware functions.

##### `jobs.js` route overview
This file defines the job-related routes. It includes routes for creating a new job (`POST /`), retrieving all jobs (`GET /`), retrieving a specific job (`GET /:id`), updating a job (`PATCH /:id`), and deleting a job (`DELETE /:id`). These routes validate the input data using JSON schemas and ensure proper authorization using middleware functions.

[BACK TO TOC](#react-jobly-backend)

#### schemas overview

The `schemas` folder contains JSON schema files like `companyNew.json`, `companySearch.json`, `companyUpdate.json`, `jobNew.json`, `jobSearch.json`, `jobUpdate.json`, `userAuth.json`, `userNew.json`, `userRegister.json`, and `userUpdate.json`. These schemas define the structure and validation rules for the data used in the application. They ensure that the data conforms to the expected format before it is processed by the routes and models. For example, the `jobNew.json` schema validates the data for creating a new job, ensuring that required fields like `title` and `companyHandle` are present and correctly formatted.

##### `companyNew.json` schema overview

This file defines the schema for creating a new company. It ensures that the company data includes `name`, `handle`, and `description`, with optional fields for `numEmployees` and `logoUrl`. The schema validates the data types and constraints, such as string lengths and integer minimums.

##### `companySearch.json` schema overview

This file defines the schema for searching companies. It allows optional search filters like `minEmployees`, `maxEmployees`, and `name`. The schema ensures that these filters are of the correct data types and within valid ranges.

##### `companyUpdate.json` schema overview

This file defines the schema for updating company data. It allows partial updates with fields like `name`, `description`, `numEmployees`, and `logoUrl`. The schema validates the data types and constraints for these fields.

##### `jobNew.json` schema overview

This file defines the schema for creating a new job. It ensures that the job data includes `title` and `companyHandle`, with optional fields for `salary` and `equity`. The schema validates the data types and constraints, such as string lengths and integer minimums.

##### `jobSearch.json` schema overview

This file defines the schema for searching jobs. It allows optional search filters like `minSalary`, `hasEquity`, and `title`. The schema ensures that these filters are of the correct data types and within valid ranges.

##### `jobUpdate.json` schema overview

This file defines the schema for updating job data. It allows partial updates with fields like `title`, `salary`, and `equity`. The schema validates the data types and constraints for these fields.

##### `userAuth.json` schema overview

This file defines the schema for user authentication. It ensures that the authentication data includes `username` and `password`. The schema validates that these fields are strings and are required.

##### `userNew.json` schema overview

This file defines the schema for creating a new user. It ensures that the user data includes `username`, `password`, `firstName`, `lastName`, and `email`, with an optional field for `isAdmin`. The schema validates the data types and constraints, such as string lengths and email format.

##### `userRegister.json` schema overview

This file defines the schema for user registration. It ensures that the registration data includes `username`, `password`, `firstName`, `lastName`, and `email`. The schema validates the data types and constraints, such as string lengths and email format.

##### `userUpdate.json` schema overview

This file defines the schema for updating user data. It allows partial updates with fields like `password`, `firstName`, `lastName`, and `email`. The schema validates the data types and constraints for these fields.

#### Data Tables Overview

**Explanation of SQL Files in the Context of the Server Application**

The SQL files `jobly.sql`, `jobly-schema.sql`, and `jobly-seed.sql` are used to set up and populate the PostgreSQL database for the Jobly application. Here's how each file is used within the context of the server application:

`jobly.sql`

This file is a script that automates the process of setting up the database. It performs the following tasks:

1. Prompts the user to confirm the deletion and recreation of the `jobly` database.
2. Drops the existing `jobly` database if it exists.
3. Creates a new `jobly` database.
4. Connects to the newly created `jobly` database.
5. Executes the `jobly-schema.sql` file to create the database schema.
6. Executes the `jobly-seed.sql` file to populate the database with initial data.
7. Repeats the process for the `jobly_test` database, which is used for testing purposes.
   
`jobly-schema.sql`

This file defines the schema for the `jobly` database. It includes SQL commands to create the necessary tables and their relationships. The tables defined in this file are:

1. `companies`: Stores information about companies, including their handle, name, number of employees, description, and logo URL.
2. `users`: Stores information about users, including their username, password, first name, last name, email, and admin status.
3. `jobs`: Stores information about jobs, including their ID, title, salary, equity, and the company handle they are associated with.
4. `applications`: Stores information about job applications, linking users to jobs they have applied for.

`jobly-seed.sql`

This file populates the `jobly` database with initial data. It includes SQL commands to insert sample data into the `users`, `companies`, and `jobs` tables. This data is used to provide a working dataset for development and testing purposes. The file includes:

1. User Data: Inserts sample users with hashed passwords.
2. Company Data: Inserts sample companies with various attributes.
3. Job Data: Inserts sample jobs associated with the companies.

**How These Files Are Used in the Project**

1. Database Setup:
   - When setting up the project, the `jobly.sql` script is executed to create and populate the `jobly` and `jobly_test` databases. This ensures that the database schema is correctly defined and that there is initial data available for development and testing.
2. Development and Testing:
   - The `jobly_test` database is used for running automated tests. The schema and data in this database are identical to the `jobly` database, ensuring that tests run in an environment that closely mirrors the production environment.
3. Database Operations:
   - The server application interacts with the database using models defined in the `models` folder (e.g., `company.js`, `job.js`, `user.js`). These models use SQL queries to perform CRUD operations on the database tables defined in the `jobly-schema.sql` file.
   - For example, when a user registers, the `User.register` method inserts a new user into the users table. When a job is created, the `Job.create` method inserts a new job into the jobs table.

#### Model, Route & Schema Integration

When a client makes a request to the server, the following sequence occurs:
1. **Request Handling**: The request is received by an appropriate route defined in the `routes` folder.
2. **Data Validation**: The route uses a JSON schema from the `schemas` folder to validate the request data. If the data is invalid, an error is returned.
3. **Model Interaction**: If the data is valid, the route invokes a method from the corresponding model in the `models` folder to perform the desired operation (e.g., creating a new job, retrieving user information).
4. **Response**: The route sends the result of the model operation back to the client as a response.

[BACK TO TOC](#react-jobly-backend)