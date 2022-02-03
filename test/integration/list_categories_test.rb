require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
  end

  test 'should show categories listing' do
    get '/categories'
    assert_select 'span', text: @category.name
    assert_select 'span', text: @category2.name
  end

end
