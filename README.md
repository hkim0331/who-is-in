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

* DEBUG=false で画面表示をやめたら、次のコードにたどり着くか？
  break if GUI::wait_key(SLEEP)

## ChangeLog

* make run で走らせる。
* [fixed] 手抜きのため、10 フレームしか、キャプチャできない。
  => 9999 フレームまでに拡張。

---
hiroshi . kimura. 0331 @ gmail . com
