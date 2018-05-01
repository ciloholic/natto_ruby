require 'natto'
require 'open-uri'
require 'nokogiri'
require 'sanitize'
require 'uri'
require 'pp'

url = 'XXXXXXXXXX'
doc = Nokogiri::HTML(open(url)) do |config|
  config.noblanks
end

# scriptを削除
doc.search('script').each do |script|
  script.content = ''
end

# styleを削除
doc.search('style').each do |style|
  style.content = ''
end

# 辞書のインストール先を設定
path = `echo \`mecab-config --dicdir\`"/mecab-ipadic-neologd"`

natto = Natto::MeCab.new("-d #{path.chomp}")
wordList = {}
doc.css('body').each do |elm|
  text = Sanitize.clean(elm.content).gsub(URI.regexp, '')
  natto.parse(text) do |n|
    wordList[n.surface] ? wordList[n.surface] += 1 : wordList[n.surface] = 1 if n.feature.match('名詞')
  end
end

# 降順ソート後、先頭10件を表示
pp wordList.sort_by{|_, v| -v}.take(10)
