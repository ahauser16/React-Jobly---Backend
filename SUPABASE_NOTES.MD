# Supabase Integration Notes

- command to install supabase npm package `npm install @supabase/supabase-js`

## Working Locally `npm run dev`

Running the command `npm run dev` and how `server.js`, `db.js`, `app.js` and `config.js` work together.

### `server.js`

This file is the entry point for the application which imports the Express app from `app.js` and starts the server on the specified port.

### `app.js`

This file sets up the Express application which configures middleware for handling CORS, JSON parsing, logging, and JWT authentication.  It defines routes for authentication, companies, users and jobs.  It also includes error handling for 404 errors and other generic errors.

### `db.js`

This file sets up the connection to the PostgreSQL database using the `pg` library.  It determines the database URI based on the environment and configures SSL for production.  It exports the connected database client for use in other parts of the application.

### `config.js`

This file contains configuration settings for the application.  It loads environment variables using `dotenv`, sets up constants like `SECRET_KEY` and `PORT`, and defines a function to get the database URI based on the environment.  It also configures the bcrypt work factor for password hashing.  

#### `getDatabaseUri` explained

The `getDatabaseUri` function in `config.js` determines the URI for connecting to the PostgreSQL database based on the environment in which the application is running. Here’s the function:

```js
function getDatabaseUri() {
  return (process.env.NODE_ENV === "test")
      ? "jobly_test"
      : process.env.DATABASE_URL || "jobly";
}
```

**Detailed Breakdown:**

1. **Environment Variable Check**:
- The function first checks the value of the `NODE_ENV` environment variable.
  - *QUESTION* my `.env` file does not contain an environment variable named `NODE_ENV`.  What does this mean for how my local workflow will behave when I run `npm run dev`?
  - *ANSWER* Since your `.env` file does not contain `NODE_ENV`, it will be `undefined` by default.
- `process.env.NODE_ENV` is a standard way to access environment variables in Node.js.

2. **Test Environment**:
- If `NODE_ENV` is set to `"test"`, the function returns the string `"jobly_test"`.
  - Because `NODE_ENV` is not set to `"test"`, the function will not return `"jobly_test"`.
- This is typically used to connect to a separate test database during automated testing.

3. **Production/Development Environment**:
- If `NODE_ENV` is not `"test"`, the function checks the `DATABASE_URL` environment variable.
- Since my `.env` file contains a variable named `DATABASE_URL` which is set to `postgresql://haus:Laylacharlie22!@localhost:5432/jobly`.
- Therefore the `getDatabaseUri` function will return the value of `DATABASE_URL` whereas if `DATABASE_URL` is not defined, it defaults to `"jobly"` which is the name of the local development database.

**Local Workflow (`npm run dev`)**

When you run `npm run dev`, the following happens:

1. **Start the Server**: `nodemon` starts and watches for changes in your files. It runs `server.js`.
2. **Initialize the App**: `server.js` imports the Express app from `app.js` and starts the server on the specified port from `config.js`.
3. **Configure the App**: `app.js` sets up middleware, routes, and error handling for the Express application.
4. **Database Connection**: `db.js` sets up the connection to the PostgreSQL database using the configuration from `config.js`.
- `db.js` calls `getDatabaseUri` to get the database URI.
- Since `NODE_ENV` is not set to "test", `getDatabaseUri` returns the value of `DATABASE_URL`, which is `postgresql://haus:Laylacharlie22!@localhost:5432/jobly`.
5. **Environment Configuration**: `config.js` loads environment variables and sets up configuration constants.

**Suggested `.env` File for Better Local Workflow**

- [x] [COMPLETE] To get the most out of your local workflow, you should explicitly set `NODE_ENV` to `development` in your `.env file`. This makes it clear that you are running in a development environment.

By adding `NODE_ENV=development` to your `.env` file, you have explicitly set the environment to "development". This change helps clarify the environment in which your application is running. Let's go through how the `getDatabaseUri` function will behave with this setup.




**Deployment Workflow with Supabase**
When deploying with Supabase, the workflow changes slightly to accommodate the hosted database service provided by Supabase.

**Supabase Setup**
- Supabase provides a PostgreSQL database with a unique connection string.
- You need to set the `DATABASE_URL` environment variable to this connection string.

### Local Workflow Explanation

1. **Start the Server**: When you run `npm run dev`, `nodemon` starts and watches for changes in your files. It runs `server.js`.
2. **Initialize the App**: `server.js` imports the Express app from `app.js` and starts the server on the specified port from `config.js`.
3. **Configure the App**: `app.js` sets up middleware, routes, and error handling for the Express application.
4. **Database Connection**: `db.js` sets up the connection to the PostgreSQL database using the configuration from `config.js`.
5. **Environment Configuration**: `config.js` loads environment variables and sets up configuration constants.
    - How does `getDatabaseUri` work as part of this workflow?

### Deployment Workflow with Supabase

1. **Supabase Setup**: Instead of a local PostgreSQL database, you will use Supabase as your database service. Supabase provides a hosted PostgreSQL database along with additional features like authentication, storage, and real-time capabilities.
2. **Environment Variables**: Ensure that your environment variables are correctly set up to point to the Supabase database. This includes updating the `DATABASE_URL` in your `.env` file to the connection string provided by Supabase.   
   1. How does the connection string work
3. **Database Connection**: `db.js` will connect to the Supabase PostgreSQL database using the updated `DATABASE_URL`.
4. **Supabase Client**: You may need to initialize and configure the Supabase client in your application to interact with Supabase services. This involves installing the Supabase client library and setting it up with your Supabase project URL and API key.
5. **Deployment**: Deploy your application to a hosting service (e.g., Vercel, Heroku) that supports Node.js applications. Ensure that the environment variables are correctly configured in the hosting service to match those used locally.
6. **Supabase Integration**: Utilize Supabase features such as authentication and storage by integrating the Supabase client into your application logic where needed.