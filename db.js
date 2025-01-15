"use strict";
/** Database setup for jobly. */
const { Client } = require("pg");
const { getDatabaseUri } = require("./config");
const supabase = require("./supabaseClient");

let db;

if (process.env.NODE_ENV === "production") {
  db = new Client({
    connectionString: getDatabaseUri(),
    ssl: {
      rejectUnauthorized: false
    }
  });
} else if (process.env.NODE_ENV === "development" || process.env.NODE_ENV === "test") {
  db = new Client({
    connectionString: getDatabaseUri()
  });
} else {
  throw new Error("NODE_ENV is not set to a valid value");
}

db.connect();

module.exports = { db, supabase };