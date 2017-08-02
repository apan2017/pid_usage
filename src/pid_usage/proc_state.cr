module PidUsage
  class State
    REGEXP = /(?<pid>\d+)\s\((?<name>.*?)\)\s(?<infos>.*)/

    CLK_TCK  = Getconf.get_clk_tck
    PAGESIZE = Getconf.get_pagesize
    UPTIME   = Getconf.get_uptime

    getter utime  : Float64
    getter stime  : Float64
    getter cutime : Float64
    getter cstime : Float64
    getter start  : Float64
    getter rss    : Float64

    def initialize(@utime : Float64, @stime : Float64, @cutime : Float64, @cstime : Float64, @start : Float64, @rss : Float64)
    end

    def total_time
      (utime + stime) / CLK_TCK
    end

    def total_time_with_children
      (total_time + cutime + cstime) / CLK_TCK
    end

    def cpu
      (total_time / uptime_seconds) * 100
    end

    def memory
      rss * PAGESIZE
    end

    def uptime_seconds
      seconds = (start - UPTIME).abs
      seconds = 1 if seconds == 0
      seconds.to_f
    end

    def self.info(pid : Int32)
      stat_raw = File.read(File.join("/proc", pid.to_s, "stat"))
      meta = REGEXP.match(stat_raw)
      raise UnknowProcResult.new if meta.nil?

      name, infos = meta["name"], meta["infos"].split(" ")
      state = State.new(
        utime:  infos[11].to_f,
        stime:  infos[12].to_f,
        cutime: infos[13].to_f,
        cstime: infos[14].to_f,
        start:  infos[19].to_f / Getconf.get_clk_tck,
        rss:    infos[21].to_f
      )

      {state.cpu, state.memory}
    rescue e : Errno
      raise PidNotFoundException.new(pid)
    end
  end
end