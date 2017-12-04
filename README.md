# who-is-in?

シンプルな動体検知プログラム。卒論生に出した週末課題に回答をつける。
Clojure/OpenCV3 で書き直したいぞ。

## require

* opencv2
* ruby 2.3
* ruby-opencv gem
* ffmpeg

## usage

CHANGED. need update.

```sh
$ make run
or
$ make headless
```

## TODO

* 最後のフレームをキーフレームに。今は最初のフレームになっている。
* /etc/rc.local から起動するので、イメージのオーナーが root。
* キャプチャの時間間隔。--interval オプション。
* 必ずしもセーブしていない、最近のフレームをチェックする。
* who-is-in が fire up したら、それを watcher に届ける。メール？

## DONE

* ムービーを逆順に作成。フォルダのクリアを忘れているぞ、きっと。
* 閾値も画面に表示。
* 最新の who-is-in jpg をどこかにコピー、web で見せる。

## FIXME


## LXD device through

LXD ゲストで who-is-in する場合、
ホスト側で認識した USB カメラをゲストで共有する必要がある。

```sh
hkim@nuc:~$ lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 8087:0a2b Intel Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
$
```

ここで USB カメラを適当なポートにつなぐ。

```sh
hkim@nuc:~$ lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 8087:0a2b Intel Corp.
Bus 001 Device 018: ID 046d:0821 Logitech, Inc. HD Webcam C910
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
$
```
Logtech C910が Bus 001 Device 018 でホストに認識されている。

### これは必要か？

picaro では次のコマンドで /dev/video0 を作った後、
webcam を認識させるコマンドを実行している。

```sh
picaro$ lxc config device add vm2017 video0 unix-char path=/dev/video0
```

その後、

```sh
nuc$ lxc config device add opencv logitec unix-char path=/dev/bus/usb/001/018
nuc$ lxc config device set opencv logitec mode 666
```

path= を忘れないように。

### remove

add の時に使った名前で、

```sh
nuc$ lxc config device remove container name
```

## ChangeLog

* [2017-11-20] who-is-in.rb and restart.sh goes to /opt/who-is-in/bin/
* [2017-11-20] jpg2mp4 will copy out.mp4 to /opt/who-is-in/images/
* [add] --log filename
* [change] GUI::wait\_key unless reset\_at or exit\_at
* [change] -y (overwrite) to ffmpeg
* [add] --without-jpg2mp4 オプション。
* [add] --reset-at オプション。
* [add] --version オプション。0.5.0
* [add] sd2. ピクセル差分の標準偏差で明暗が違うだけのフレームを捨てる。
* [add] qt-rate.scpt
* [change] 最初の1枚は必ずセーブ。
* [change] 起動時に IMAGES_DIR をクリア。
* [new] --exit-after s オプション。
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
