class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    binding.pry
    @default || req.headers['Accept'].include?("application/vnd.example.v#{@version}")
  end
end
