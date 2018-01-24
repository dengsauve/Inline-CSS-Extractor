# Main file to use

def main
  # Get filename from user
  print "filename: "
  filename = gets.chomp

  # Open and read file
  inline_html = File.readlines(filename)

  # Get array of styles
  style_array = find_styles(inline_html)
  puts style_array

  # Make CSS classes


end


def find_styles(inline_html)
  ret_array = []
  # Iterate through each line
  inline_html.each do |line|
    # Search each line for inline styles
    if line.include?("style=")
      # Add string between `style="` and  `"` to style array UNLESS
      # style array already has it
      css = line.scan( /style="(.*?)"/ ).flatten[0]
      unless css == nil || ret_array.include?(css)
        ret_array << css
      end
    end
  end
  return ret_array
end

main()
