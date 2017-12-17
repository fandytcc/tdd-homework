class Codebreaker
  class Game
    attr_reader :output
    GUIDANCE = "Try guessing a number with four digits"

    def initialize(output)
      @output = output
      @plus = 0
      @minus = 0
    end

    def start(secret_number)
      @secret_number = secret_number
      @secret_digit = @secret_number.split("").map { |n| n.to_i }
      output.puts "Welcome to Codebreaker"
      output.puts "Enter guess:"
    end

    def print_plus
      "+" * @plus
    end

    def print_minus
      "-" * @minus
    end

    def remove_duplicated_counts
      @minus = @minus - @plus
    end

    def guess(input)
      input_digit = input.split("").map { |num| num.to_i }
      if input.size != @secret_number.size
        output.puts GUIDANCE
      else
        for i in 0..3 #counting exact matches
          @plus += 1 if input_digit[i] == @secret_digit[i]
        end
        for i in 0..3 #counting number matches
          for j in 0..3
            if input_digit[j] == @secret_digit[i]
              @minus += 1
              input_digit[j]= -1
              break
            end
          end
        end

        remove_duplicated_counts

        if @minus == 0 && @plus == 0
          hint = ""
        elsif @plus == 4
          hint = print_plus
        elsif @minus == 0
          hint = print_plus if @plus != 0
        elsif @plus == 0
          hint = print_minus if @minus != 0
        else
          @plus == 1 ? hint = print_plus : hint = print_plus
          @minus == 1 ? hint += print_minus : hint += print_minus
        end
        output.puts(hint)
      end
    end
  end
end
