$cert = Get-Content -AsByteStream -Path .\testcert.pfx
[System.Convert]::ToBase64String($fileContentBytes) | Out-File 'pfx-bytes.txt'
[System.Convert]::ToBase64String($cert) | Out-File 'pfx-bytes.txt'
