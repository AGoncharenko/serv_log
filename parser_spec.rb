require './parser'

describe Parser do
  let(:page_views_response) do
    "list of webpages with most page views ordered from most pages views to less page views:\n"\
    "/about/2 90 visits\n"\
    "/contact 89 visits\n"\
    "/index 82 visits\n"\
    "/about 81 visits\n"\
    "/help_page/1 80 visits\n"\
    "/home 78 visits\n"\
  end
  let(:unique_page_views_response) do
    "list of webpages with most unique page views also ordered:\n"\
    "/help_page/1 23 unique views\n"\
    "/index 23 unique views\n"\
    "/contact 23 unique views\n"\
    "/home 23 unique views\n"\
    "/about/2 22 unique views\n"\
    "/about 21 unique views\n"\
  end
  let(:help_response) do
    "Please run parser with following attributes: parser.rb [webserver.log] [method]; \n"\
    "where:\nwebserver.log: text logfile name;\nmethod: string 'unique', 'views' or 'full_info'\n"
  end

  it "#result without params" do
    expect { Parser.new.result }.to output(help_response).to_stdout
  end

  it "#result with log file and unique method" do
    expect { Parser.new.result('webserver.log', 'unique') }.to output(unique_page_views_response).to_stdout
  end

  it "#result with log file and views method" do
    expect { Parser.new.result('webserver.log', 'views') }.to output(page_views_response).to_stdout
  end

  it "#result with log file and full_info method" do
    expect { Parser.new.result('webserver.log', 'full_info') }.to output(page_views_response+unique_page_views_response).to_stdout
  end

  it "#result with log file and asd method" do
    expect { Parser.new.result('webserver', 'asd') }.to output(help_response).to_stdout
  end
end