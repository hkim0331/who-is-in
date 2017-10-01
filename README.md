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

* 時刻を表すイメージを焼き込む（専門用語ではなんと言うか？）
* make が嘘つき。

## ChangeLog

* [change] --reset-at を --exit-at に変更。
* [new] --reset-at hh:mm:ss オプション。
* [new] make run で走らせる。
* [fix] 手抜きのため、10 フレームしか、キャプチャできない。
  => 9999 フレームまでに拡張。

---
hiroshi . kimura. 0331 @ gmail . com
