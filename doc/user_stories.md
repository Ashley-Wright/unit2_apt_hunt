## User Stories

<pre>
  As an apartment hunter
  I want to input information about apartment complexes
  In order to add apartments later.

  Usage: ./apt_hunter create complex --name "name" --zip "zip" --parking "parking" --website "website" --phone "phone"

  Acceptance Criteria:
  * I can input arguments for name, location, parking, website, and phone number.
  * A success message is printed if information is store in the database.
</pre>

<pre>
  As an apartment hunter
  I want to input data on available apartments
  In order to filter and sort it later.

  Usage: ./apt_hunter create apartment --rent "rent" --size "size" --bedrooms "bedrooms" --bathrooms "baths" --complex "complex"

  Acceptance Criteria:
  * I can input arguments for price, size, number of bedrooms and number of baths.
  * I can input argument for apartment complexes, if the information has already been entered.
  * A success message is printed if information is store in the database.
</pre>

<pre>
  As an apartment hunter
  I want to be able to display apartment entries.

  Usage: ./apt_hunter view apartments

  Acceptance Criteria:
  * Apartments must show up correctly including information about the associated apartment complex.
  * A field with the calculated price per square feet will be in the list.
</pre>

<pre>
  As an apartment hunter
  I want to be able to display apartment complex entries.

  Usage: ./apt_hunter view complexes

  Acceptance Criteria:
  * Apartment complexes must show up correctly.
  * Does not print out any information about the individual apartments.
</pre>

<pre>
  As an apartment hunter
  I want to update apartment entries.

  Usage: ./apt_hunter update apartment --id "apartment id" --rent "rent"

  Acceptance Criteria:
  * I can enter an apartment id and update any of the fields (single or multiple).
  * A success message confirms data for "apartment id" was updated.
</pre>

<pre>
  As an apartment hunter
  I want to update apartment complex entries.

  Usage: ./apt_hunter update complex --id "complex id" --parking "parking"

  Acceptance Criteria:
  * I can enter an apartment complex id and update any of the fields(single or multiple).
  * A success message confirms data for "complex id" was updated.
</pre>

<pre>
  As an apartment hunter
  I want to be able to delete apartment entries.

  Usage: ./apt_hunter delete apartment --id "apartment id"

  Acceptance Criteria:
  * I can enter an apartment id and delete any of the fields.
  * A success message confirms data for "apartment id" was deleted.
</pre>

<pre>
  As an apartment hunter
  I want to be able to delete apartment complex entries.

  Usage: ./apt_hunter delete complex --id "complex id"

  Acceptance Criteria:
  * I can enter an apartment complex id and delete any of the fields.
  * A success message confirms data for "complex id" was deleted.
</pre>

<pre>
  As an apartment hunter
  I want to filter by monthly rent
  In order to see the apartments in my price range.

  Usage: ./apt_hunter filter apartment --min "min" --max "max"

  Acceptance Criteria:
  * I can enter an upper and lower value for rent.
  * Only the apartment in that range will be displayed.
</pre>

<pre>
  As an apartment hunter
  I want to sort apartment search results by size or number of bedrooms.

  Usage: ./apt_hunter filter apartment --sort bedrooms

  Acceptance Criteria:
  * I can sort by size.
  * I can sort by number of bedrooms.
  * I can filter by rent, then sort by bedrooms.
</pre>