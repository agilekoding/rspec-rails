require 'spec_helper'

<% module_namespacing do -%>
describe <%= class_name %> do
  before(:each) do
    @<%= class_name.underscore %> = FactoryGirl.create :<%= class_name.underscore %>
  end

  subject{@<%= class_name.underscore %>}

  it "should be invalid when empty" do
    <%= class_name %>.new.should be_invalid
  end

  it "should be valid with valid attributtes" do
     should be_valid
  end

  # -----------------------------------------------------------------------------------------------------------------------
  # RESPONSES
  # -----------------------------------------------------------------------------------------------------------------------
  describe "responses to" do
    def self.instance_collections
      [
        attributtes = [<%= attributes.map(&:name).map{ |a| ":#{a}" }.join(', ') %>],
        associations = [],
        instance_methods = [],
      ]
    end

    def self.class_collections
      [
        class_methods = [],
        scopes = [],
      ]
    end

    instance_collections.flatten.each do |a|
      it "#{a} should be valid" do
        should respond_to(a)
      end
    end

    class_collections.flatten.each do |a|
      it "#{a} should be valid" do
        <%= class_name %>.should respond_to(a)
      end
    end
  end

  # -----------------------------------------------------------------------------------------------------------------------
  # MODEL ATTRIBUTES
  # -----------------------------------------------------------------------------------------------------------------------
  describe "model attributes" do
    <% attributes.map(&:name).map do |a| %>
      describe <%= "\"" + a + "\"" %> do
        <%= "# Here define the contexts and tests to #{a} attributes" %>
      end
    <% end %>
  end

  # -----------------------------------------------------------------------------------------------------------------------
  # ASSOCIATIONS
  # -----------------------------------------------------------------------------------------------------------------------
  describe "associations" do
    describe "belongs to" do
      # Here define the tests to belongs to associations.
    end

    describe "has many" do
      # Here define the tests to has many to associations.
    end
  end

  # -----------------------------------------------------------------------------------------------------------------------
  # INSTANCE METHODS
  # -----------------------------------------------------------------------------------------------------------------------
  describe "instance methods" do
  end

  # -----------------------------------------------------------------------------------------------------------------------
  # CLASS METHODS
  # -----------------------------------------------------------------------------------------------------------------------
  describe "class methods" do
  end

  # -----------------------------------------------------------------------------------------------------------------------
  # SCOPES
  # -----------------------------------------------------------------------------------------------------------------------
  describe "scopes" do
  end

end
<% end -%>
