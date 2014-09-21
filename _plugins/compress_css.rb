require 'yui/compressor'

compressor = YUI::CssCompressor.new

path_to_css = './_assets/css/'
css_filenames = ['poole.css', 'syntax.css', 'lanyon.css',
                 'bootstrap_button.css']

path_to_output = './public/css/'
output_fname = 'stylesheets.css'

combined_contents = ''

css_filenames.each do |fname|
    combined_contents << File.open(path_to_css + fname).read
end

compressed_contents = compressor.compress(combined_contents)

output_file = File.open(path_to_output + output_fname, 'w')
output_file.write(compressed_contents)
