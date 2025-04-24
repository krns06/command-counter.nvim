# command-counter.nvim
インサートモードとターミナルモード以外で入力されたキーを記録するプラグイン

## Usage
lazy.nvimを用いてインストールを行う。specは以下のように設定する。output_pathはキーが記録されるファイルを指定する。

```
return {
        {
                "krns06/command-counter.nvim/",
                config = {
                        output_path = "/tmp/command-counter.nvim"
                }
        }
}
```
