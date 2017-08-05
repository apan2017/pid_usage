module PidUsage
  class State
    REGEXP   = /(?<cpu>\d\.\d)\s*(?<rss>\d+)/

    def self.get_raw(pid : Int32)
      String.build do |io|
        Process.run("ps", args: { "-o", "pcpu,rss", "-p", pid.to_s }, output: io)
      end
    end

    def self.info(pid : Int32)
      raw = get_raw(pid)
      lines = raw.chomp.split('\n')

      if lines.size > 1
        meta = REGEXP.match(lines[1])
        raise UnknowPSResult.new(raw) if meta.nil?

        cpu, rss = meta["cpu"], meta["rss"]
        {cpu.to_f, rss.to_f * 1024}
      else
        raise PidNotFoundException.new(pid)
      end
    end
  end
end
