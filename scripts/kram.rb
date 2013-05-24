# Simple tool to run kramdown on individual files.

require "fileutils"
require "pathname"
require "kramdown"

def md2html(infile, outfile)
  markdown = fileReadContent(infile)
  html = Kramdown::Document.new(markdown, :auto_ids => false).to_html
  fileSaveContent(outfile, html)
end

def html2md(infile, outfile)
  html = fileReadContent(infile)
  markdown = Kramdown::Document.new(html).to_kramdown
  fileSaveContent(outfile, markdown)
end

def fileReadContent(filePath)
  File.open(filePath, "rb") { |f| f.read.force_encoding("UTF-8") }
end

def fileSaveContent(destFile, content)
  File.open(destFile, "wb") { |f| f.write(content) }
end

if (ARGV[0] == "md2html" and ARGV.length == 3)
  md2html ARGV[1], ARGV[2]
  puts "Done, output is in file: " + ARGV[2]
elsif (ARGV[0] == "html2md" and ARGV.length == 3)
  html2md ARGV[1], ARGV[2]
  puts "Done, output is in file: " + ARGV[2]
else
  puts "Description:"
  puts "  kram takes a Markdown file and creates an HTML file."
  puts "Syntax:"
  puts "  kram md2html <inputfile> <outputfile>"
  puts "  kram html2md <inputfile> <outputfile>"
end
