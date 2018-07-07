class Category < ApplicationRecord
  acts_as_tree order: 'name'

end
