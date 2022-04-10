# unixCommandModuleForWindows
\*nix like commands module for windows written in powershell. It is not completely same as *nix command but still useful.
it is powershell module so you can use them on any windows machine.

unixライクなコマンドのpowershell モジュールです。どんな環境のwindows pcでも使えます。

#### currently Available commands
* `su`
* `touch`

## Set up to use the commands
Put 'unixCommandMimic' directory under 'C:\Windows\System32\WindowsPowerShell\v1.0\Modules' directory. Make sure you have appropriate powershell execution policy. Here is an example.

'C:\Windows\System32\WindowsPowerShell\v1.0\Modules'下に'unixCommandMimic'ディレクトリを置いてください。適当なpowershell実行ポリシーであることを確認してください。

* eg)
`Set-ExecutionPolicy remoteSigned`   (run as admin is required)

you may need to unblock program.

プログラムの実行を許可しなければいけないかもしれません。

* eg)
`Unblock-File unixCommandMimic.psm1` (also you may need to `Unblock-File unixCommandMimic.psd1`)

restart powershell (close and open new terminal emulator)

powershellを再起動してください。 (ターミナルエミュレータを閉じて新しく開く）

ALL SET :)

>*if still you can't run, please try loosing execution policy.*

>`Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted` (not recommended)
*or copy paste to new psm1 and psd1 file.*

>_それでも動かなかった場合は、上記のコマンドでポリシーを緩めるか、.psm1と.psd1ファイルを新しく作成して内容をコピペしてください。_

### command explanation
`su` runs new shell as admin
`touch` can modify timestamp or create new file

eg)

`su`

`touch file1 file2 file3`
`touch file1 -a -t '2020-01-02 7:30:30 PM'`
