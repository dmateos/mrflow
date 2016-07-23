module MrFlow
  class InputReader
    def initialize(input)
      @input = input
      @str = ""
    end

    def gets
      while s = @input.gets 
        @str += s
      end

      @str
    end
  end
end
