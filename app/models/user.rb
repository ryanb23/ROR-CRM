class User < ApplicationRecord
  include Filterable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :authy_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,:password_expirable
  
  acts_as_paranoid

  enum status: { :Pending => 0, :Confirmation_pending => 1, :Active => 2, :Deactive => 3 }
  enum gender: { 'Male' => "0", 'Female' => "1" }
  enum emp_status: {"Self Employed" => 1, "Employee" => 2}
  enum title: {'Dr' => "1", 'Pr' => "2", 'Mr' => "3", 'Mme' => "4"}
  belongs_to :establishment
  has_one :user_temp_detail
  has_many :subscriptions , as: :entity
  has_many :bank_accounts, dependent: :destroy
  has_many :user_insurances
  has_many :equipments, dependent: :destroy
  has_many :insurances, through: :user_insurances,dependent: :destroy
  has_many :user_skills
  has_many :skills, through: :user_skills,dependent: :destroy
  has_many :user_roles
  has_many :roles, through: :user_roles,dependent: :destroy
  has_many :salesmans_postal_codes, dependent: :destroy
  has_many :customer_forms, :class_name => 'Form', :foreign_key => 'customer_id', dependent: :destroy
  has_many :provider_forms, :class_name => 'Form', :foreign_key => 'provider_id', dependent: :destroy
  has_many :supervisor_forms,:class_name => 'Form', :foreign_key => 'supervisor_id',  dependent: :destroy
  has_many :tech_provider_forms,:class_name => 'Form', :foreign_key => 'tech_provider_id',  dependent: :destroy

  has_many :customer_form_statuses, :class_name => 'FormStatus', :foreign_key => 'customer_id', dependent: :destroy
  has_many :provider_form_statuses, :class_name => 'FormStatus', :foreign_key => 'provider_id', dependent: :destroy
  has_many :supervisor_form_statuses,:class_name => 'FormStatus', :foreign_key => 'supervisor_id',  dependent: :destroy
  has_many :tech_provider_form_statuses,:class_name => 'FormStatus', :foreign_key => 'tech_provider_id',  dependent: :destroy

  has_many :patients, dependent: :destroy
  has_many :del_customers,foreign_key: :delegate_customer_id,class_name: "DelCustomer"
  has_many :customers,foreign_key: :customer_id,class_name: "DelCustomer"
  accepts_nested_attributes_for :user_skills, allow_destroy: true
  accepts_nested_attributes_for :insurances, allow_destroy: true
  accepts_nested_attributes_for :bank_accounts, allow_destroy: true
  accepts_nested_attributes_for :salesmans_postal_codes, allow_destroy: true
  has_and_belongs_to_many :specialities
  has_and_belongs_to_many :positions
  has_many :own_notifications, class_name: "Notification", foreign_key: "user_id", dependent: :destroy
  has_many :notifications_recipients, foreign_key: :recipient_id, dependent: :destroy
  has_many :notifications, through: :notifications_recipients, dependent: :destroy

  # validates :country, presence:true
  VALID_URL_REGEX = /\A(?=._*[a-z])(?=.*[A-Z])(?=.*[\d])(?=.*[\W]).{8,64}\z/
  has_attached_file :signature,:styles => { :medium => "300x300>",:thumb => "100x100>" }
  has_attached_file :photo,:styles => { :medium => "300x300>",:thumb => "100x100>" }, :default_url => "missing.png"
  validates_attachment_content_type :photo, :content_type => ["image/jpeg", "image/png", "image/jpg"]
  validates :password, :format => { with: VALID_URL_REGEX }, on: :update, allow_blank: true
  validates :password, :format => { with: VALID_URL_REGEX }, on: :create, unless: -> { is_patient }
  validates_attachment_size :photo, :less_than => 1.megabytes
  validates_attachment_content_type :signature, :content_type => ["image/jpeg", "image/png", "image/jpg"]
  validates_attachment_size :signature, :less_than => 1.megabytes
  validates :phone, presence: true, unless: -> { is_patient }
  validates_uniqueness_of :phone, :allow_blank => true, if: -> { phone.present? }
  validates :phone, phone: { possible: false, allow_blank: false, types: [:mobile] }, unless: -> { is_patient }
  validates_uniqueness_of :email, :allow_blank => true, if: -> { email.present? } # allow blank email to be saved in case of patient
  validates :first_name, :last_name, :gender, :birth_date, presence: true, if: -> { is_patient }

  scope :find_user_email,->(email) { find_by(email: email)}
  
  before_save :default_values

  # after_commit -> { CreateNotificationJob.perform_later(self, action: update) }, on: :update

  attr_accessor :is_patient

  def active_for_authentication?
    super && (Active?)
  end

  def is_patient
    @is_patient ||= false
  end

  class << self
    def send_mail_about_expire_insurance
      all.each do |user|
        user.insurances.each do |insurance|
          if insurance.end_date && ((insurance.end_date - 1.month) - Date.today).to_i == 0
            # Send mail to user and admin before one month from expire insurance
            InsuranceMailer.notify_before_insurance_expired(user).deliver_now
          elsif insurance.end_date && (insurance.end_date - Date.today).to_i == -1
            # Send mail to user and admin after expire insurance
            user.Deactive! # deactivate user account
            InsuranceMailer.notify_after_insurance_expired(user).deliver_now
          end
        end
      end
    end

    def authy(user)
      authy = Authy::API.register_user(
        email: user.email,
        cellphone: user.phone,
        country_code: user.country
      )
      user.update(authy_id: authy.id)
      # Send an SMS to your user
      Authy::API.request_sms(id: user.authy_id)
    end

    def user_fields
      ["id","email","first_name","last_name","title", "birth_date","address","street","city","postal_code","country","phone", "emp_status"]
    end
  end
  
  def update_without_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end


  def default_values
    self.deleted ||= '0'
  end

  # def password
  #   errors.add(:password,"not in vaild format")
  # end

  def full_name
    "#{first_name} #{last_name}".present? ? "#{first_name} #{last_name}".strip : nil
  end

  def has_role?(role)
    custome_role = roles.pluck(:custom_role_id)
    custome_role.include?(role)
  end

  def admin?
    has_role?("root")
  end

  def identity
    full_name || email
  end
  
  protected

  def email_required?
    true unless is_patient # allow blank email to be saved in case of patient
  end

  # allow to save patient detail without passowrd
  def password_required?
    return false if is_patient
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

end
