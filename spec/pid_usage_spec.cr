require "./spec_helper"
require "benchmark"

describe PidUsage do
  it "PidUsage.state should return a tuple {percent, rss}" do
    p = Process.fork { sleep 1 }
    PidUsage.state(p.pid).is_a?(Tuple).should be_true
    p.wait
  end

  it "getconf.get_clk_tck" do
    PidUsage::Getconf.get_clk_tck.should eq PidUsage::Getconf::DEFAULT_CLK_TCK
  end

  it "getconf.get_pagesize" do
    PidUsage::Getconf.get_pagesize.should eq PidUsage::Getconf::DEFAULT_PAGESIZE
  end

  {% unless flag?(:darwin) %}
    it "getconf.get_uptime" do
      PidUsage::Getconf.get_uptime.is_a?(Float64).should be_true
    end

    it "PidUsage.state should return a tuple {percent, rss}" do
      p = Process.fork { sleep 1 }
      PidUsage.state(p.pid).is_a?(Tuple).should be_true
      p.wait
    end
  {% end %}
end
