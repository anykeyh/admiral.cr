require "spec"
require "../fixtures/*"

class Admiral::Command
  def panic
    raise "PANIC"
  end
end

describe "before_run" do
  it "should be called when running the main command" do
    File.tempfile("test") do |io|
      cmd = BeforeRunCommand.new([] of String, output: io)
      cmd.call
      io.rewind
      io.gets_to_end.should eq "Main command run\n"
      cmd.before_run_called.should be_true
    end
  end

  it "should be called when running a subcommand" do
    File.tempfile("test") do |io|
      cmd = BeforeRunCommand.new(["sub"], output: io)
      cmd.call
      io.rewind
      io.gets_to_end.should eq "SubCommand run\n"
      cmd.before_run_called.should be_true
    end
  end
end
