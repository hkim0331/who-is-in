# who-is-in?

シンプルな動体検知プログラム。卒論生に出した週末課題に回答をつける。
Clojure/OpenCV3 で書き直したいぞ。

## require

* opencv2
* ruby 2.3
* ruby-opencv gem
* ffmpeg

## usage

```sh
$ make run
or
$ make headless
```

## FIXME

* 起動の仕方。make ががんばり足りない。
* キャプチャの時間感覚を引数に。--interval オプション。
* カメラキャプチャと wait_key との違う場面で SLEEP を使い回すのはオカシイ。

## ChangeLog

* [changed] 起動時に IMAGES_DIR をクリア。
* [new] --exit-afger s オプション。
* [new] --help オプション。オプションと使い方の説明。
* [change] --with-date オプション廃止、--without-date に変更。
* [change] query はキャプチャするまで回る。
* [new] --with-date オプション。
* [change] --reset-at を --exit-at に変更。
* [new] --reset-at hh:mm:ss オプション。
* [new] make run で走らせる。
* [fix] 手抜きのため、10 フレームしか、キャプチャできない。
  => 9999 フレームまでに拡張。

---
hiroshi . kimura. 0331 @ gmail . com
