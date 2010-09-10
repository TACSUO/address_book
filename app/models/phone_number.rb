class PhoneNumber < ActiveRecord::Base
  set_table_name "address_book_phone_numbers"
  
  cattr_reader :label_options, :number_tips

  @@label_options = %w(Office Cell Home Fax)
  @@number_tips = ["enter digits only, formatting will be automatic"]
  
  acts_as_revisable :revision_class_name => 'PhoneNumberRevision', :on_delete => :revise
  
  has_and_belongs_to_many :contacts, {
    :join_table => 'address_book_contacts_phone_numbers'
  }
  
  before_validation :strip_non_digits
  
  validates_length_of :local_number, {
    :within => (7..14)
  }
  validates_length_of :country_code, {
    :within => (1..8)
  }
  validates_numericality_of :extension, {
    :allow_blank => true,
    :only_integer => true
  }
  validates_numericality_of :country_code, :local_number, {
    :only_integer => true
  }
  validates_presence_of :label
  validate :fifteen_or_less_total_digits
  validates_uniqueness_of :local_number, :scope => [:country_code, :extension]
  
  composed_of :number, {
    :class_name => 'TelephoneNumber',
    :mapping => [ %w(country_code country_code) ] +
                [ %w(local_number local_number) ] +
                [ %w(extension extension)]
  }
  
  private
    # According to Telecommunications Standardization Sector (ITU-T)
    # E.164, the total number of digits in a phone number (including country
    # code) should not exceed 15.
    def fifteen_or_less_total_digits
      if number.digits_only.length > 15
        errors.add_to_base("total number of digits must be less than 15")
      end
    end
    # Allow numbers to be pasted into text fields but we only want to store
    # the digits to provide easy comparisons during queries. Also simplifies
    # validations.
    def strip_non_digits
      country_code.gsub!(/[^\d]/, '') unless country_code.blank?
      local_number.gsub!(/[^\d]/, '') unless local_number.blank?
      extension.gsub!(/[^\d]/, '') unless extension.blank?
    end
  protected
  public
    def update_reverse_phonebook
      self.reverse_phonebook = self.contact_ids.join(',')
    end
end

class TelephoneNumber
  attr_reader :country_code, :local_number, :extension
  
  def initialize(country_code, local_number, extension)
    @country_code = country_code
    @local_number = local_number
    @extension = extension
  end
  
  def digits_only
    "#{country_code}#{local_number}"
  end
  
  def ==(other_number)
    country_code == other_number.country_code &&
      local_number == other_number.local_number &&
      extension == other_number.extension
  end
end




# == Schema Information
#
# Table name: address_book_phone_numbers
#
#  id                         :integer         not null, primary key
#  country_code               :string(15)      default("1")
#  local_number               :string(15)
#  extension                  :string(15)
#  label                      :string(31)
#  created_at                 :datetime
#  updated_at                 :datetime
#  revisable_original_id      :integer
#  revisable_branched_from_id :integer
#  revisable_number           :integer         default(0)
#  revisable_name             :string(255)
#  revisable_type             :string(255)
#  revisable_current_at       :datetime
#  revisable_revised_at       :datetime
#  revisable_deleted_at       :datetime
#  revisable_is_current       :boolean         default(TRUE)
#  reverse_phonebook          :text
#

