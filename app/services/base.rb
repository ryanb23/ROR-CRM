# no need to initialize 'new' method over n over when call service using 'call' method
# We using 'call' method to call services. But we can also use perform(), process() method.
# But call() is slightly better then other because this is also used by rails Proc and lambda.
# you can call code block using call(). also you can call like 'ServiceName.new.(args)' insteade os ServiceName.new.call(args)
module Base
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def call(*args, &block)
      @instance ||= self.new
      @instance.call *args, &block
   end
  end
end