package NX::Nebraska::Schema::Result::MapWithTripPlace;

use strict;
use warnings;
use base qw( DBIx::Class::Core );

# Get a list of maps that have stats and values.  This is
# used to create the map selector on the Compare Map main
# page.

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

__PACKAGE__->table('map_with_values');

__PACKAGE__->add_columns(
  "id",
  { data_type => "char", is_nullable => 0, size => 3 },
  "code",
  { data_type => "char", is_nullable => 1, size => 2 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 128 },
);

__PACKAGE__->result_source_instance->is_virtual(1);

__PACKAGE__->result_source_instance->view_definition(q(
  SELECT 
    m.id AS id,
    m.country_code AS code,
    m.name AS name
  FROM 
    trip_place_map AS tpm 
    JOIN map AS m ON m.id = tpm.map_id
  GROUP 
    BY tpm.map_id
  ORDER BY
    m.name
));

1;
