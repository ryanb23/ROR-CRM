class Error < Response::Base

	def initialize(data = nil, message = nil, status = :error, status_code = 500)
    super
    @status = status
  end

  def success?
		false
	end

	def on_error(&block)
    block.call(@data, @message, @status)
    self
  end

  def on_success(&block)
  	self
  end

end