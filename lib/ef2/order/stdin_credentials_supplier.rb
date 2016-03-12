class STDINCredentialsSupplier

  def initialize thor
    @authenticated = false
    @thor = thor
  end

  def get_credentials
    if !@authenticated
      @thor.say 'Enter your Amazon Fresh credentials'
      username = @thor.ask 'Username:'
      password = @thor.ask 'Password:', :echo => false
      @thor.say
      @credentials = {:username => username, :password => password}
    end
    @credentials
  end

  def get_captcha link
    @thor.say 'You\'ve been CAPTCHA\'d, a CAPTCHA image will open in a few seconds for you to enter'
    sleep(3)
    puts link
    @thor.ask 'CAPTCHA:'
  end

end