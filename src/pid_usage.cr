require "./pid_usage/exceptions"
require "./pid_usage/getconf"
require "./pid_usage/version"

{% if flag?(:linux) %}
  require "./pid_usage/proc_state"
{% elsif flag?(:darwin) %}
  require "./pid_usage/ps_state"
{% end %}

module PidUsage
  def self.state(pid : Int32)
    PidUsage::State.info(pid)
  end
end
