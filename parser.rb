class Parser
  def initialize
    @array = []
    @result = Hash.new(0)
  end

  def result(file_name=nil, method=nil)
    fill_array(file_name)
    if @array.any?
      if method == 'unique'
        unique_page_views
      elsif method == 'views'
        page_views
      elsif method == 'full_info'
        page_views
        unique_page_views
      else
        help
      end
    else
      help
    end
  end

  private
  def fill_array(file_name)
    if file_name && File.exist?(file_name)
      File.open(file_name).each {|line| @array << line.split(' ')}
    end
    @array
  end

  def page_views
    puts 'list of webpages with most page views ordered from most pages views to less page views:'
    @array.map{|i| i[0]}.each{|address| @result[address] += 1 unless address.empty? }
    @result.sort_by{|k,v| v}.reverse.each { |k, v| puts "#{k} #{v} visits\n" }
  end

  def unique_page_views
    puts 'list of webpages with most unique page views also ordered:'
    @result.clear
    @array.uniq.map{|i| i[0]}.each{|address| @result[address] += 1 unless address.empty? }
    @result.sort_by{|k,v| v}.reverse.each { |k, v| puts "#{k} #{v} unique views\n" }
  end

  def help
    puts "Please run parser with following attributes: parser.rb [webserver.log] [method]; \n"\
    "where:\nwebserver.log: text logfile name;\nmethod: string 'unique', 'views' or 'full_info'"
  end
end

Parser.new.result(ARGV[0], ARGV[1])