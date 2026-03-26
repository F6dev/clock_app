# clock_app

A new Flutter project.

## アプリの概要
シンプルな時計アプリです。最初はFlutterの勉強として置き時計アプリを開発していましたが、ちゃんとしたアプリを作ろうと思ってこのアプリを開発し始めた感じです。
時計画面で横向きにすると置き時計モードになります

## 主な機能
- 時計
- 設定
    - 言語設定
    - フォントファミリーの変更
    - Coffeeモード
    - アプリの時間の調整 (一日の開始時刻と終了時刻と一日の長さの調整)


## 対応OS
iOS: 未対応
Android: バージョン5.0 (APIレベル: 21) 以上
Windows: 未対応
macOS: 未対応
Linux: 未対応

## 対応言語
- 日本語(Japanese)
- 英語(English)

## フォント
- [LINE Seed JP](https://seed.line.me/index_jp.html)
- [Zen Maru Gothic](https://fonts.google.com/specimen/Zen+Maru+Gothic)
- [Ubuntu](https://fonts.google.com/specimen/Ubuntu)
- [Roboto](https://fonts.google.com/specimen/Roboto)
- [Inter](https://fonts.google.com/specimen/Inter)
- [Lato](https://fonts.google.com/specimen/Lato)
- [Oswald](https://fonts.google.com/specimen/Oswald)
- [Raleway](https://fonts.google.com/specimen/Raleway)
- [Nunito](https://fonts.google.com/specimen/Nunito)

※ デバイスでカスタムフォントを設定している場合、フォントが変更できない可能性があります。

## Coffeeとは
この設定をオンにすると、アプリを開いている間は端末のスリープが無効化されます。
参考: https://f-droid.org/ja/packages/com.github.muellerma.coffee/

## アプリの時間の調整 (ベータ版)
アプリ内での一日の開始時間と終了時間を決めることで、時計の速度などを変更して時刻をカスタマイズすることができます。


<!-- ## メモ
フォント関係かな

"設定"と右上に書き、"一般設定"と"時計設定"という2つにわける。

"一般設定"には言語とフォント設定、そしてCoffee(横向きにした時にスリープしない設定にする)という項目。

言語は日本語とEnglishを選択する(ただし、設定画面のみの言語)。

フォントファミリーはとりあえず前みたいにGoogleFontsからとってくる感じで、LINESeedJP,Ubuntu,Roboto,ZenMaruGothicなどを選択できるように（別ページ）。

フォントサイズは

```
double timeFontSize = isLandscape ? screenWidth * 0.15 : screenWidth * 0.27;
double dateFontSize = isLandscape ? screenWidth * 0.1 : screenWidth * 0.18;
```

の部分の縦向きの時刻部分のみ変更できるようにし、日付は時刻の1.5倍、横向きは縦向きの1.8倍と固定してある。

Coffeeは

https://github.com/mueller-ma/Coffee.git

みたいに、オンにしたらこのアプリを開いている時はスリープしない、オフにしたら通常通りスリープするようになる。



"時計設定"には、端末の時刻・日付の編集、アプリの時間調整という項目。

端末の時刻・日付の編集は設定アプリを開いてなんとかして設定項目を自動で開きたい。

アプリの時間調整は別ページに移動して、アプリ内の相対的な1日の開始時刻・終了時刻・1日あたりの時間(hours)・1時間あたりの分(minute)・1分あたりの秒数(second)をカスタマイズできるように、一つ動かしたらそれに伴って全て動くような感じ？で。設定画面の上に現在の時刻とグローバルの時間から何倍速くなったかをプレビューする。

例: 6:00スタート、22:00終了に設定→18h/d、90m/h、90s/m、x1.5→'21:38:09→23:27:14' -->
