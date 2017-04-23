class Success < Response::Base

  def initialize(data = nil, message = nil, status = :success, status_code = 200)
    super
    @status = status
  end

	def success?
		true
	end

	def on_success(&block)
    block.call(@data, @message, @status)
    self
  end

  def on_error(&block)
    self
  end

end