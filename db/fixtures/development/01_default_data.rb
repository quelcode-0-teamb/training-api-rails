User.seed do |s|
  s.id = 1
  s.name = 'kingmasa'
  s.email = 'kingmasa@gmail.com'
  s.password = '1'
  s.password_confirmation = '1'
end

cnt = 1
ary = %w[スクワット デッドリフト オーバーヘッドプレス インクラインベンチプレス フロントスクワット バーベルカール ベントオーバーロー スモウデッドリフト ヒップスラスト ルーマニアンデッドリフト バーベルシュラッグ]
ary.each do |a|
  Exercise.seed do |s|
    s.id = cnt
    s.name = a
    s.category = 0
  end
  cnt += 1
end

ary = %w[懸垂 腕立て伏せ ディップス 逆手懸垂 自重スクワット]
ary.each do |a|
  Exercise.seed do |s|
    s.name = a
    s.category = 1
  end
  cnt += 1
end

ary = %w[パワークリーン クリーンアンドジャーク スナッチ プッシュプレス クリーン]
ary.each do |a|
  Exercise.seed do |s|
    s.name = a
    s.category = 2
  end
  cnt += 1
end
ary = %w[ダンベルベンチプレス ダンベルカール ダンベルショルダープレス インクラインダンベルベンチプレス ダンベルロー]
ary.each do |a|
  Exercise.seed do |s|
    s.name = a
    s.category = 3
  end
end
ary = %w[レッグプレス レッグエクステンション ラットプルダウン]
ary.each do |a|
  Exercise.seed do |s|
    s.name = a
    s.category = 4
  end
end
