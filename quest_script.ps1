#Oculus Quset を接続して無線でPCに出力するスクリプト

Set-Location C:\Users\riki\Desktop\scrcpy-win64
$COMMAND_RESULT = .\adb.exe shell ip addr show wlan0

# ip addr からIPアドレスのみを取得
foreach( $Line in $COMMAND_RESULT ){
    # 「NTP: 」の行を特定
    if( $Line -match "    inet"){

        # 「inet 」で分割
        $Buffers = $Line.Split("inet ")

        # 1つ目の文字列
        $TergetBuffer = $Buffers[0]

        # 「/」で分割
        $Buffers = $TergetBuffer.Split("/")

        # 1つ目の文字列
        $TergetBuffer = $Buffers[0]

        # Trim で余分な空白を取り除く
        $IpAddress = $TergetBuffer.Trim()
    
        # Loop から抜ける
        break
    }
}

Write-Output $IpAddress

.\adb.exe tcpip 5555


Read-Host "disconnect USB cable from Oculus. After that press Enter key."

.\adb connect "${IpAddress}:5555"

.\scrcpy.exe -c 1440:1600:0:0
