# MachiKania-JJYCLK

MachiKania type P/PUに電波時計モジュールをデジタルI/Oに接続し、RTCを設定する。<BR>

## 設定
MICHIKANIAP.INI の 「RTCFILE」を有効にすることによって、SDカード上のファイルへの書き込み時にタイムスタンプの日付もRTCの日付で更新されるようになる。<BR>

## 電波時計モジュールについて
以前、aitendoで売られていた電波時計モジュールを使用して動作確認しているが、他の電波時計モジュールでも出力波形は同様（正論理、府論理の違いはある可能性がある）と思われる。<BR>
<img width="458" height="562" alt="image" src="https://github.com/user-attachments/assets/adf058d9-d529-4d67-8bd9-8e45d024de1f" />
<BR>

## 接続
電波時計モジュールの配線は以下の通り。<BR>
V：+3V (電波時計モジュールの電源電圧の許容範囲内で供給)　<BR>
G：GND<BR>
T：受信信号出力（負論理） MachiKania type P/PUのGP0へ<BR>
無印：受信信号出力（正論理）<BR>
P：出力制御（プルダウンでON。10kΩを介してGNDへ）<BR>
H：不明（接続なし）<BR>

## 設置について
電波時計モジュールは、出来る限り窓際などに近づけ、ノイズに弱いため、PC等のデジタル機器（MachiKania本体も含む)から遠ざけ、電源もノイズが少ない電源（乾電池3本とか）で供給し、信号とGNDだけをMachiKaniaヘ接続するのが最も安定する様子。<BR>
動作確認するには、PCのヘッドホン端子にイヤホンを取り付け、イヤホンの音が出る部分を電波時計モジュールのアンテナの近くに配置する。その状態で、WebブラウザでJJYシミュレータWeb版 ( https://shogo82148.github.io/web-jjy/ )を動作させる。この際、もし、オシロがあれば波形をみてノイズが無い状態の波形が出力されているかどうか確認してから、ソフトの動作確認を行うのが良い。<BR>
<img width="2054" height="1473" alt="image" src="https://github.com/user-attachments/assets/174a7052-3596-4f55-8ffe-028c204199b7" />





