abstract class Admiral::Command
  private macro inherited
    def self.run(*args, **params)
      new(*args, **params).call
    end

    rescue_from ::Admiral::Error do |e|
      panic e.message.colorize(:red)
    end

    def call : Nil
      with_rescue do
        puts_version
        puts_help
        validate_flags!
        validate_arguments!
        command = @argv.shift if SubCommands.locate(@argv[0]?)
        before_run
        next sub(command.to_s, @argv) if command
        run
      end
    end
  end
end
