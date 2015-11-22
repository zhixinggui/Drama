[![LICENSE](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](LICENSE)
[![Donate](https://img.shields.io/badge/PayPal-Donate-yellow.svg?style=flat-square)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=LC58N7VZUST5N)

# Drama
用來觀看 [8Drama][1] 影片的 Universal App.


## 需求
* Xcode 7.1
* iOS 9.1 (因為使用了一些 Runtime 技術)


## 特色
基本我目前觀看劇集幾乎都去 [8Drama][1] 觀看, 所以另外寫了這個 App.

這個 App 基本上是照著我另一個 App [影音瀏覽器][2] 架構而做, 其中不一樣的地方是沒有影片來源查詢,  
而是直接使用 [8Drama][1] 的 HTML5 player.

內建的 HTML5 player 並不支援手勢前進後退, 所以我利用了 Objective-C runtime 與 category 技術,  
客製化了 AVPlayerViewController 前進後退的手勢.

> AVPlayerViewController 的 Category 參考了 [iOS runtime headers][3], 所以才需要 iOS 9.1 的需求.



[1]: http://8drama.com "8Drama"
[2]: https://itun.es/i6LV9Gm "影音瀏覽器"
[3]: https://github.com/nst/iOS-Runtime-Headers "runtime"