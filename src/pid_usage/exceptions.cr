module PidUsage
  class UnknowPSResult < Exception; end

  class UnknowProcResult < Exception; end

  class PidNotFoundException < Exception
    def initialize(pid : Int32)
      super("PID: #{pid} not found.")
    end
  end
end
