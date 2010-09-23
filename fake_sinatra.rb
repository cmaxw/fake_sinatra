def general_request_method(request_method, path, &block)
  middleware = Class.new
  middleware.send(:define_method, 'initialize') do |app|
    @app = app
  end
  
  middleware.send(:define_method, 'call') do |env|
    if env["REQUEST_METHOD"] == self.class.request_method && env["PATH_INFO"] == self.class.path
      action
    else
      @app.call(env)
    end
  end
  
  middleware.instance_eval do
    def path=(path)
      @path = path
    end
    
    def path
      @path
    end
    
    def request_method=(rm)
      @rm = rm
    end
    
    def request_method
      @rm
    end
  end
  
  middleware.send(:define_method, 'action', &block)
  middleware.path = path
  middleware.request_method = request_method
  
  use middleware
end

def get(path, &block)
  general_request_method("GET", path, &block)
end

def post(path, &block)
  general_request_method("POST", path, &block)
end

def put(path, &block)
  general_request_method("PUT", path, &block)
end

def delete(path, &block)
  general_request_method("DELETE", path, &block)
end