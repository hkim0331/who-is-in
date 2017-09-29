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
```

## FIXME

* 時刻を表すイメージを焼き込む（専門用語ではなんと言うか？）
* --headless したらどうやって break if GUI::wait_key(SLEEP)？
  脱出のコードが必要だな。
  linux サーバに USB カメラつないで夜通し監視させるようなケース。
  時間でリセットするか？ --rest-at hh:mm:ss はどうか？

## ChangeLog

* make run で走らせる。
* [fixed] 手抜きのため、10 フレームしか、キャプチャできない。
  => 9999 フレームまでに拡張。

---
hiroshi . kimura. 0331 @ gmail . com
