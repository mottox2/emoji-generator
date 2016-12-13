require 'highline/import'
require 'mechanize'
require 'pry'

# Decomoji Importer
class Importer
  BASE_DIR = File.expand_path(File.dirname(__FILE__))

  def initialize(path)
    @path = path
    @page = nil
    @agent = Mechanize.new
  end
  attr_accessor :page, :agent, :path

  def import_decomojis
    move_to_emoji_page
    upload_decomojis
  end

  private

  def login
    team_name  = ask('Your slack team name(subdomain): ')
    email      = ask('Login email: ')
    password   = ask('Login password(hidden): ') { |q| q.echo = false }

    emoji_page_url = "https://#{team_name}.slack.com/admin/emoji"

    page = agent.get(emoji_page_url)
    page.form.email = email
    page.form.password = password
    @page = page.form.submit
  end

  def enter_two_factor_authentication_code
    page.form['2fa_code'] = ask('Your two factor authentication code: ')
    @page = page.form.submit
  end

  def move_to_emoji_page
    loop do
      if page && page.form['signin_2fa']
        enter_two_factor_authentication_code
      else
        login
      end

      break if page.title.include?('Emoji')
      puts 'Login failure. Please try again.'
      puts
    end
  end

  def upload_decomojis
    name = ask('emoji name: ')
    path = File.expand_path("#{BASE_DIR}/#{@path}")

    # skip if already exists
    p 'Already exists' and return if page.body.include?(":#{name}:")

    puts "importing #{basename}..."

    form = page.form_with(action: '/customize/emoji')
    form['name'] = name
    form.file_upload.file_name = path
    @page = form.submit
  end
end

path = ARGV[0]
importer = Importer.new(path)
importer.import_decomojis
puts 'Done!'
