# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Location.count.zero?
  Location.create(
    [{ title: 'Store Fist', url_handle: 'little-miss-bbq first', interval: 10, start_time: Time.now.beginning_of_day, end_time: Time.now.end_of_day, address: 'Store ', latitude: '33.4217144', longitude: '-111.98916109999999' },
     { title: 'Store Second', url_handle: 'little-miss-bbq second', interval: 10, start_time: Time.now.beginning_of_day,
       end_time: Time.now.end_of_day, address: 'Store ', latitude: '33.4217144', longitude: '-111.98916109999999' }]
  )
end

if Category.count.zero?
  Category.create([
                    { title: 'Menu', description: 'Menu' },
                    { title: 'Online Store', description: 'Online Store' }
                  ])
end

if Category.count == 2
  Category.create(
    [
      { title: 'Meat by Weight', description: 'Meat by Weight', sub_category_id: 1 },
      { title: 'Sandwiches with 1 Side', description: 'Sandwiches with 1 Side', sub_category_id: 1 },
      { title: 'Plates with 2 Sides', description: 'Plates with 2 Sides', sub_category_id: 1 },
      { title: 'Sides', description: 'Sides', sub_category_id: 1 },
      { title: 'Dessert', description: 'Dessert', sub_category_id: 1 },

      { title: 'Clothing/Apparel', description: 'Clothing/Apparel', sub_category_id: 2 },
      { title: 'Hats/Visors', description: 'Hats/Visors', sub_category_id: 2 }
    ]
  )
end

if Product.count.zero?
  Product.create(
    [
      { price: 45.00, title: 'Brisket', description: 'Brisket', aval_week: %w[0 2 3 5], category_id: 3,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Chopped Brisket', description: 'Chopped Brisket', aval_week: %w[0 2 3 5],
        category_id: 3, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Pulled Pork', description: 'Pulled Pork', aval_week: %w[0 2 3 5], category_id: 3,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Pork Ribs', description: 'Pork Ribs', aval_week: %w[0 2 3 5], category_id: 3,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Turkey', description: 'Turkey', aval_week: %w[0 2 3 5], category_id: 3,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Beef Ribs', description: 'Beef Ribs', aval_week: %w[0 2 3 5], category_id: 3,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Prime Pastrami Brisket', description: 'Prime Pastrami Brisket', aval_week: %w[0 2 3 5],
        category_id: 3, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },

      { price: 45.00, title: 'The Jefe', description: 'The Jefe', aval_week: %w[0 2 3 5], category_id: 4,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Brisket', description: 'Brisket', aval_week: %w[0 2 3 5], category_id: 4,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Chopped Brisket', description: 'Chopped Brisket', aval_week: %w[0 2 3 5],
        category_id: 4, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Pulled Pork', description: 'Pulled Pork', aval_week: %w[0 2 3 5], category_id: 4,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Turkey', description: 'Turkey', aval_week: %w[0 2 3 5], category_id: 4,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },

      { price: 45.00, title: 'Brisket', description: 'Brisket', aval_week: %w[0 2 3 5], category_id: 5,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Chopped Brisket', description: 'Chopped Brisket', aval_week: %w[0 2 3 5],
        category_id: 5, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Pulled Pork', description: 'Pulled Pork', aval_week: %w[0 2 3 5], category_id: 5,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Turkey', description: 'Turkey', aval_week: %w[0 2 3 5], category_id: 5,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Sausage', description: 'Sausage', aval_week: %w[0 2 3 5], category_id: 5,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Pork Rib (3/4lb)', description: 'Pork Rib (3/4lb)', aval_week: %w[0 2 3 5],
        category_id: 5, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: '2 Meat Plate (3/4lb)', description: '2 Meat Plate (3/4lb)', aval_week: %w[0 2 3 5],
        category_id: 5, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },

      { price: 45.00, title: 'Ranch Style Beans', description: 'Ranch Style Beans', aval_week: %w[0 2 3 5],
        category_id: 6, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Jalapeno Cheddar Grits', description: 'Jalapeno Cheddar Grits', aval_week: %w[0 2 3 5],
        category_id: 6, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Potato salad', description: 'Potato salad', aval_week: %w[0 2 3 5], category_id: 6,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Coleslaw', description: 'Coleslaw', aval_week: %w[0 2 3 5], category_id: 6,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Single', description: 'Single', aval_week: %w[0 2 3 5], category_id: 6,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Pint (3 people)', description: 'Pint (3 people)', aval_week: %w[0 2 3 5],
        category_id: 6, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Quart (6–7 people)', description: 'Quart (6–7 people)', aval_week: %w[0 2 3 5],
        category_id: 6, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Half Pan (25 people)', description: 'Half Pan (25 people)', aval_week: %w[0 2 3 5],
        category_id: 6, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },

      { price: 45.00, title: 'Bekke’s Smoked Pecan Pie', description: 'Bekke’s Smoked Pecan Pie',
        aval_week: %w[0 2 3 5], category_id: 7, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },

      { price: 45.00, title: 'Black Cow Logo T-Shirt', description: 'Black Cow Logo T-Shirt', aval_week: %w[0 2 3 5],
        category_id: 8, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Grey Logo T-shirt', description: 'Grey Logo T-shirt', aval_week: %w[0 2 3 5],
        category_id: 8, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },

      { price: 45.00, title: 'Black and White Hat', description: 'Black and White Hat', aval_week: %w[0 2 3 5],
        category_id: 8, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Black Logo Fitted Hat', description: 'Black Logo Fitted Hat', aval_week: %w[0 2 3 5],
        category_id: 9, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'White Logo Visor', description: 'White Logo Visor', aval_week: %w[0 2 3 5],
        category_id: 9, product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }] },
      { price: 45.00, title: 'Grey Logo Visor', description: 'Grey Logo Visor', aval_week: %w[0 2 3 5], category_id: 9,
        product_to_qties_attributes: [{ price: '20.00', qty_type: 'lbs' }]	}
    ]
  )
end

if ProductToLocation.count.zero?
  ProductToLocation.create([
                             { product_id: 1, location_id: 1 },
                             { product_id: 2, location_id: 1 },
                             { product_id: 3, location_id: 1 },
                             { product_id: 4, location_id: 1 },
                             { product_id: 5, location_id: 1 },
                             { product_id: 6, location_id: 1 },
                             { product_id: 7, location_id: 1 },
                             { product_id: 8, location_id: 1 },
                             { product_id: 9, location_id: 1 },
                             { product_id: 11, location_id: 1 },
                             { product_id: 10, location_id: 1 },

                             { product_id: 12, location_id: 2 },
                             { product_id: 13, location_id: 2 },
                             { product_id: 14, location_id: 2 },
                             { product_id: 15, location_id: 2 },
                             { product_id: 16, location_id: 2 },
                             { product_id: 17, location_id: 2 },
                             { product_id: 18, location_id: 2 },
                             { product_id: 19, location_id: 2 },
                             { product_id: 20, location_id: 2 },

                             { product_id: 20, location_id: 1 },
                             { product_id: 19, location_id: 1 },
                             { product_id: 18, location_id: 1 },
                             { product_id: 17, location_id: 1 },
                             { product_id: 16, location_id: 1 },
                             { product_id: 15, location_id: 1 },

                             { product_id: 21, location_id: 2 },
                             { product_id: 22, location_id: 2 },
                             { product_id: 23, location_id: 2 },
                             { product_id: 24, location_id: 2 },
                             { product_id: 25, location_id: 2 },
                             { product_id: 26, location_id: 2 }
                           ])
end
