require 'spec_helper'

<% module_namespacing do -%>
describe <%= class_name %> do
  before(:all) do
  end

  before(:each) do
    @<%= class_name.underscore %> = FactoryGirl.create <%= class_name.underscore.to_sym %>
  end

  subject{@<%= class_name.underscore %>}

  it "should be invalid when empty" do
    <%= class_name %>.new.should be_invalid
  end

  it "should be valid with valid attributtes" do
     should be_valid
  end

  def self.attributes
    [<%= attributes.map(&:field).map(&:to_sym).join(', ') %>]
  end

  def self.required_attributes
    []
  end

  attributes.each do |a|
    it "should respond to #{a}" do
      should respond_to(a)
    end

    it "should have no error on #{a.to_s}" do
      should have(:no).error_on(a)
    end
  end if self.respond_to?(:attributes)

  describe "Validations" do
    required_attributes.each do |a|
      it "should have 1 error without #{a.to_s}" do
        subject.send "#{a.to_s}=", nil
        should have_at_least(1).error_on(a)
      end
    end if self.respond_to?(:required_attributes)
  end

  describe "Belongs to" do
    def self.parent_models
      []
    end

    attr_accessor *parent_models

    parent_models.each do |p|
      its(p) {should eq(method(p).call)}
    end if self.respond_to?(:parent_models)

  end

  describe "Has Many" do
    def self.model_collections
      []
    end

    model_collections.each do |c|
      describe "#{c.capitalize}" do
        before(:each) do
          10.times do
            subject.method(c).call << FactoryGirl.create(c.to_s.singularize.to_sym, <%= class_name.underscore.to_sym %> => subject)
          end
        end

        it "should have 10 #{c.capitalize}" do
          should have(10).send(c)
        end
      end
    end

  end

  # Define more specific tests here

end
<% end -%>
