# 参考
[NokogiriとNattoで、Webページ内の単語を抽出する](https://qiita.com/YoshiyukiKato/items/815a99bea572ce788baf)

# bundle install
```
bundle install --path vendor/bundler
```

# 辞書をインストール
```
git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
cd mecab-ipadic-neologd
./bin/install-mecab-ipadic-neologd -n
```

# 実行
```
bundle exec ruby natto.rb
```
