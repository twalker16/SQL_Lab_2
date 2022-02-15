CREATE TABLE "users" (
  "user_id" SERIAL PRIMARY KEY,
  "user_name" VARCHAR(40) NOT NULL,
  "user_email" VARCHAR(50) NOT NULL,
  "user_password" VARCHAR(500) NOT NULL
);

CREATE TABLE "recipes" (
  "recipe_id" SERIAL PRIMARY KEY,
  "is_public" BOOLEAN DEFAULT true,
  "recipe_name" VARCHAR(100) NOT NULL,
  "recipe_type" VARCHAR(25) NOT NULL,
  "diet_tag" VARCHAR(50),
  "author_id" INTEGER NOT NULL,
  "instructions" VARCHAR(25000) NOT NULL
);

CREATE TABLE "recipeingredients" (
  "recipeingredient_id" SERIAL PRIMARY KEY,
  "recipe_id" INTEGER NOT NULL,
  "ingredient_id" INTEGER NOT NULL,
  "quantity" INTEGER NOT NULL,
  "price" FLOAT DEFAULT (ingredients(price_per_unit)*recipeingredients(quantity))
);

CREATE TABLE "ingredients" (
  "ingredient_id" SERIAL PRIMARY KEY,
  "ingredient_name" VARCHAR(50) NOT NULL,
  "unit_of_measurement" VARCHAR(20) DEFAULT 'Whole',
  "price_per_unit" FLOAT NOT NULL
);

CREATE TABLE "groceries" (
  "trip_id" SERIAL PRIMARY KEY,
  "user_id" INTEGER NOT NULL,
  "recipe_id" INTEGER NOT NULL,
  "price" FLOAT DEFAULT (SELECT SUM(price) FROM recipeingredients WHERE groceries(recipe_id)=recipeingredients(recipe_id))
);

CREATE TABLE "occasions" (
  "occasion_id" SERIAL PRIMARY KEY,
  "occasion_name" VARCHAR(50) NOT NULL,
  "occasion_date" DATE NOT NULL,
  "user_id" INTEGER NOT NULL
);

CREATE TABLE "occasionrecipes" (
  "occasionrecipes_id" SERIAL PRIMARY KEY,
  "occasion_id" INTEGER NOT NULL,
  "recipe_id" INTEGER NOT NULL
);

ALTER TABLE "recipes" ADD FOREIGN KEY ("author_id") REFERENCES "users" ("user_id");

ALTER TABLE "recipeingredients" ADD FOREIGN KEY ("recipe_id") REFERENCES "recipes" ("recipe_id");

ALTER TABLE "recipeingredients" ADD FOREIGN KEY ("ingredient_id") REFERENCES "ingredients" ("ingredient_id");

ALTER TABLE "groceries" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "groceries" ADD FOREIGN KEY ("recipe_id") REFERENCES "recipes" ("recipe_id");

ALTER TABLE "occasions" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "occasionrecipes" ADD FOREIGN KEY ("occasion_id") REFERENCES "occasions" ("occasion_id");

ALTER TABLE "occasionrecipes" ADD FOREIGN KEY ("recipe_id") REFERENCES "recipes" ("recipe_id");

ALTER TABLE "occasionrecipes" ADD FOREIGN KEY ("recipe_id") REFERENCES "recipes" ("author_id");




-- REATE TABLE users(
--   user_id SERIAL PRIMARY KEY,
--   user_name VARCHAR(40) NOT NULL,
--   user_email VARCHAR(50) NOT NULL,
--   user_password VARCHAR(500) NOT NULL
-- );

-- CREATE TABLE recipes(
--   recipe_id SERIAL PRIMARY KEY,
--   is_public BOOLEAN DEFAULT true,
--   recipe_name VARCHAR(100) NOT NULL,
--   recipe_type VARCHAR(25) NOT NULL,
--   diet_tag VARCHAR(50),
--   author_id INTEGER NOT NULL REFERENCES users(user_id),
--   instructions VARCHAR(25000) NOT NULL,
--   ingredients VARCHAR(10000) DEFAULT (SELECT ingredient_name FROM ingredients 
--   WHERE recipeingredients(ingredient_id)=ingredients(ingredient_id) AND recipeingredients(recipe_id)=recipes(recipe_id))
-- );

-- CREATE TABLE recipeingredients(
--   recipeingredient_id SERIAL PRIMARY KEY,
--   recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
--   ingredient_id INTEGER NOT NULL REFERENCES ingredients(ingredient_id),
--   quantity INTEGER NOT NULL,
--   price FLOAT DEFAULT (ingredients(price_per_unit)*recipeingredients(quantity))
-- );

-- CREATE TABLE ingredients(
--   ingredient_id SERIAL PRIMARY KEY,
--   ingredient_name VARCHAR(50) NOT NULL,
--   unit_of_measurement VARCHAR(20) DEFAULT 'Whole',
--   price_per_unit FLOAT NOT NULL
-- );

-- CREATE TABLE groceries(
--   trip_id SERIAL PRIMARY KEY,
--   user_id INTEGER NOT NULL REFERENCES users(user_id),
--   recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
--   price FLOAT DEFAULT (SELECT SUM(price) FROM recipeingredients WHERE groceries(recipe_id)=recipeingredients(recipe_id))
-- );

-- CREATE TABLE occasions(
--   occasion_id SERIAL PRIMARY KEY,
--   occasion_name VARCHAR(50) NOT NULL,
--   occasion_date DATE NOT NULL,
--   user_id INTEGER NOT NULL REFERENCES users(user_id)
-- );

-- CREATE TABLE occasionrecipes(
--   occasionrecipes_id SERIAL PRIMARY KEY,
--   occasion_id INTEGER NOT NULL REFERENCES occasions(occasion_id),
--   recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id)
-- );






-----------------------------------------------------------------------------------------debugged until tables created

CREATE TABLE users(
  user_id SERIAL PRIMARY KEY,
  user_name VARCHAR(40) NOT NULL,
  user_email VARCHAR(50) NOT NULL,
  user_password VARCHAR(500) NOT NULL
);

CREATE TABLE recipes(
  recipe_id SERIAL PRIMARY KEY,
  is_public BOOLEAN DEFAULT true,
  recipe_name VARCHAR(100) NOT NULL,
  recipe_type VARCHAR(25) NOT NULL,
  diet_tag VARCHAR(50),
  author_id INTEGER NOT NULL REFERENCES users(user_id),
  instructions VARCHAR(25000) NOT NULL,
  ingredients VARCHAR(10000)
--   DEFAULT (SELECT ingredient_name FROM ingredients 
--   WHERE recipeingredients(ingredient_id)=ingredients(ingredient_id) AND recipeingredients(recipe_id)=recipes(recipe_id))
);


CREATE TABLE ingredients(
  ingredient_id SERIAL PRIMARY KEY,
  ingredient_name VARCHAR(50) NOT NULL,
  unit_of_measurement VARCHAR(20) DEFAULT 'Whole',
  price_per_unit FLOAT NOT NULL
);

CREATE TABLE recipeingredients(
  recipeingredient_id SERIAL PRIMARY KEY,
  recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
  ingredient_id INTEGER NOT NULL REFERENCES ingredients(ingredient_id),
  quantity INTEGER NOT NULL,
  price FLOAT 
--   DEFAULT (ingredients(price_per_unit)*recipeingredients(quantity))
);

CREATE TABLE groceries(
  trip_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(user_id),
  recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id),
  price FLOAT
--   DEFAULT (SELECT SUM(price) FROM recipeingredients WHERE groceries(recipe_id)=recipeingredients(recipe_id))
);

CREATE TABLE occasions(
  occasion_id SERIAL PRIMARY KEY,
  occasion_name VARCHAR(50) NOT NULL,
  occasion_date DATE NOT NULL,
  user_id INTEGER NOT NULL REFERENCES users(user_id)
);

CREATE TABLE occasionrecipes(
  occasionrecipes_id SERIAL PRIMARY KEY,
  occasion_id INTEGER NOT NULL REFERENCES occasions(occasion_id),
  recipe_id INTEGER NOT NULL REFERENCES recipes(recipe_id)
);