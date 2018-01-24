# Get the Controller / View Name for the file
print "Please enter a controller name: "
controller = gets.chomp
print "Please enter a view name: "
view = gets.chomp

class_prefix = controller + "_" + view

# Get the unholy HTML
heresy_html = File.readlines('heresy.html')

purged_html = ""
unified_html = ""
holy_css_batman = ""

# returns formatted css for file string
def format_css(css, line, prefix)
  stylings = css.split("; ")
  ret_str = ".#{prefix}_#{line} {"
  stylings.each do |style|
    ret_str << "\n\t#{style};"
  end
  ret_str << "\n}"
  return ret_str
end

# merges multiple classes into one class
def format_class(line)
  ret_str = " class='"
  classes = line.scan(/[^-]class=(["'])(.*?)\1/)
  #puts classes.inspect
  classes.each do |c|
    c[1..-1].each do |cc|
      ret_str << "#{cc} "
    end
  end
  ret_str << "' "
  return ret_str
end

heresy_html.each_with_index do | line, i |
  if line.include?("style=")
    # Get style, append to css
    css = line.scan( /style="(.*?)"/ ).flatten[0]
    unless css == nil
      fcss = format_css(css, i, class_prefix)
      holy_css_batman << fcss + "\n"
      # Get purged html line, append to html
      html = line.gsub(/style="(.*?)"/, "class='#{class_prefix}_#{i}'")
      purged_html << html
    else
      purged_html << line
    end
  else
    purged_html << line
  end
end

html_array = purged_html.split("\n")

html_array.each do |line|
  unless line.scan(/\<.*?(class=).*?(class=).*?\>/) == []
    #puts line
    fline = format_class(line)
    rline = line.gsub(/[^-]class=(["'])(.*?)\1/, fline)
    unified_html << rline + "\n"
  else
    unified_html << line + "\n"
  end
end


File.open("output.html", "w") do |f|
  f.write(unified_html)
end

File.open("output.css", "w") do |f|
  f.write(holy_css_batman)
end
