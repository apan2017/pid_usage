module PidUsage
  class Getconf
    DEFAULT_CLK_TCK  = 100
    DEFAULT_PAGESIZE = 4096

    def self.getconf(name : String)
      output = IO::Memory.new
      Process.run("getconf", {name}, output: output)
      output.close
      output.to_s
    end

    def self.get_clk_tck
      (r = getconf("CLK_TCK")).empty? ? DEFAULT_CLK_TCK : r.to_i
    end

    def self.get_pagesize
      (r = getconf("PAGESIZE")).empty? ? DEFAULT_PAGESIZE : r.to_i
    end

    def self.get_uptime
      File.read(File.join("/proc/uptime")).split(" ")[0].to_f
    end
  end
end