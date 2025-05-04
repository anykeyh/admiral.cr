require "../../src/admiral"

class BeforeRunCommand < Admiral::Command
  property before_run_called = false

  class SubCommand < Admiral::Command
    def run
      puts "SubCommand run"
    end

    def exit(*args)
    end
  end

  register_sub_command sub, SubCommand

  def before_run
    @before_run_called = true
  end

  def run
    puts "Main command run"
  end

  def exit(*args)
  end
end
