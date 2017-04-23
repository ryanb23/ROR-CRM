class Form < ApplicationRecord
  belongs_to :patient
  belongs_to :customer, :class_name => 'User'
  belongs_to :provider, :class_name => 'User'
  belongs_to :supervisor, :class_name => 'User'
  belongs_to :tech_provider, :class_name => 'User'
  
  has_many :form_files,dependent: :destroy
  has_many :form_statuses,dependent: :destroy
  has_many :invoices_patients
  has_many :patients, through: :invoices_patients
  has_many :payments, dependent: :destroy

  enum form_type: {"ECG" => 1, "Polygraphic" => 2}
  enum status: {"draft" => 1,"validated" => 2, "payment_pending" => 3, "provider_pending" => 4, "analysis_in_progress" => 5, "completed" => 6 , "canceled" => 7 }
  
  validates :form_type, presence: true

  class << self

    def update_customer_id(form,current_user)
      form.update_attributes(customer_id: current_user.id)
    end

    def update_del_customer_id(form,current_user)
      if current_user.del_customers
        customer_id = current_user.del_customers.last.customer_id
        form.update_attributes(customer_id: customer_id)
      end
    end

    def create_name_with_del_customer(form,patient,user,current_user)
    	u_first_name = ActiveSupport::Inflector.transliterate(user.try(:first_name))
    	u_last_name = ActiveSupport::Inflector.transliterate(user.try(:last_name))
    	current_user_first_name = ActiveSupport::Inflector.transliterate(current_user.try(:first_name))
    	current_user_last_name = ActiveSupport::Inflector.transliterate(current_user.try(:last_name)	)
    	form.name = Time.now.strftime("%Y-%m-%d-%H-%M") + '-' + u_first_name.downcase + '-' + u_last_name.downcase + '-' + current_user_first_name.downcase + '-' + current_user_last_name.downcase
    end

    def create_name_and_status(form,patient,user)
    	u_first_name = ActiveSupport::Inflector.transliterate(user.try(:first_name))
    	u_last_name = ActiveSupport::Inflector.transliterate(user.try(:last_name))
    	form.name = Time.now.strftime("%Y-%m-%d-%H-%M") + '-' + user.try(:first_name).downcase + '-' + user.try(:last_name).downcase
    end

    def check_status_of_uploaded_file_every_minute
      all.each do |form|
        @form = form
        if form.form_type == "ECG"
          @setting = Setting.ECG.first
          Form.common_method_for_minute(@form,@setting)
        elsif form.form_type == "Polygraphic"
          @setting = Setting.Polygraphie.first
          Form.common_method_for_minute(@form,@setting)
        end
      end
    end

    def check_status_of_uploaded_file_every_hour
      all.each do |form|
        @form = form
        if @form.form_type == "ECG"
          @setting = Setting.ECG.first
          Form.common_method_for_hour(@form,@setting)
        elsif @form.form_type == "Polygraphic"
          setting = Setting.Polygraphie.first
          Form.common_method_for_hour(@form,@setting)
        end
      end
    end
    def common_method_for_minute(form,setting)
      if form.patient.present?
        patient = form.patient
      end
      if form.patient&.user.present?
        user = form.patient.user
      end
      if form.status == "validated" && setting.payment_type == "by patient"
        form.update_attributes(status: 3,payment_pending_at: Time.now)
        Form.update_form_status(form)
        invoice_patient = InvoicesPatient.create(form_id: form.id,patient_id: form&.patient_id,status: 1,amount: setting&.billing_price)

        if patient.present? && user.email.present?
          PatientMailer.payment_pending_email(patient,user,form,invoice_patient).deliver_now
        end
      elsif form.status == "validated" && setting.payment_type == "by customer or establishment"
        form.update_attributes(status: 4,provider_pending_at: Time.now)
        Form.update_form_status(form)
      end
    end
    def common_method_for_hour(form,setting)
      if form.status == "payment_pending"
        if form.patient.present?
          patient = form.patient
        end
        if form.patient&.user.present?
          user = form.patient.user
        end
        if form.payment_pending_at.present?
          get_payment_pending_hours =  ((Time.now - form.payment_pending_at) / 3600).round 
        else
          form.update_attributes(payment_pending_at: Time.now)
          Form.update_form_status(form)
          get_payment_pending_hours =  ((Time.now - form.payment_pending_at) / 3600).round 
        end
        mail_status = form.mail_status
        if get_payment_pending_hours > setting.payment_waiting_delay
          form.update_attributes(status: 7)
          Form.update_form_status(form)
        elsif get_payment_pending_hours > mail_status
          if patient.present? && user.email.present?
            mail_status = form.mail_status + 24
            form.update_attributes(mail_status: mail_status)
            PatientMailer.payment_pending_reminder_email(form.patient,form.patient.user,form).deliver_now
          end
        end
      elsif form.status == "provider_pending"
        if form.provider_pending_at.present?
          get_provider_pending_hours = ((Time.now - form.provider_pending_at) / 3600).round 
        else
          form.update_attributes(provider_pending_at: Time.now)
          get_provider_pending_hours = ((Time.now - form.provider_pending_at) / 3600).round 
        end

        if get_provider_pending_hours > setting.analysis_delay
          form.update_attributes(status: 7)
          Form.update_form_status(form)
        end
      end
    end

    def update_form_status(form)
      form.form_statuses.create(status: form.status)
    end
  end
  
end
