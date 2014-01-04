# encoding: utf-8

# サブディレクトリ設定
if yes?("use sub directory url?(y/n):")
  subdirname = ""
  subdirname = ask("sub directory name? (ex:/foo/bar):") until subdirname =~ /^\/[a-z0-9\/]+$/

  # 環境変数を前もって設定する為に使うgem
  gem "dotenv-rails"

  # サブディレクトリを設定する環境変数を設定
  create_file ".env"
  append_to_file ".env", "RAILS_RELATIVE_URL_ROOT=#{subdirname}"

  # 環境変数を使用するようにconfig.ruを編集
  insert_into_file "config.ru", "\nend", :after => /^run.+$/
  insert_into_file "config.ru", "map ENV['RAILS_RELATIVE_URL_ROOT'] || '/' do\n  ", :before => /^run.+$/
end