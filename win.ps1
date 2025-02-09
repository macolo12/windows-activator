# Enable Fullscreen
$signature = @'
[DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
'@
$User32 = Add-Type -MemberDefinition $signature -Name "WinAPI" -Namespace "User32" -PassThru
$User32::ShowWindow((Get-Process -Id $PID).MainWindowHandle, 3)  # 3 = Maximize window

# Clear screen
Clear-Host

# Function to center text
function CenterText($text) {
    $width = $Host.UI.RawUI.WindowSize.Width
    $padding = ($width - $text.Length) / 2
    return " " * [math]::Max([math]::Floor($padding), 0) + $text
}

# Print Header
Write-Host "`n"  # Extra line for spacing
Write-Host (CenterText "============================================================") -ForegroundColor Magenta
Write-Host (CenterText "||                 ** Windows Activation Menu **           ||") -ForegroundColor Magenta
Write-Host (CenterText "============================================================") -ForegroundColor Magenta
Write-Host "`n"  # Extra line for spacing

# Display activation options
$menuOptions = @(
    "1. Activate Windows XP Home",
    "2. Activate Windows XP Professional",
    "3. Activate Windows Vista Home Basic",
    "4. Activate Windows Vista Home Premium",
    "5. Activate Windows Vista Ultimate",
    "6. Activate Windows 7 Home Premium",
    "7. Activate Windows 7 Professional",
    "8. Activate Windows 8 Home",
    "9. Activate Windows 8 Pro",
    "10. Activate Windows 8.1 Home",
    "11. Activate Windows 8.1 Pro",
    "12. Activate Windows 10 Home",
    "13. Activate Windows 10 Pro",
    "14. Activate Windows 11 Home",
    "15. Activate Windows 11 Pro",
    "16. Exit"
)

foreach ($option in $menuOptions) {
    Write-Host (CenterText $option) -ForegroundColor Cyan
}

# Get user choice
$choice = Read-Host "`n$(CenterText 'Enter your choice (1-16)')"

# Define activation keys (Replace with real ones)
$keys = @{
    "1"  = "D34G-EH2H-7Q87-P6D8-J1VP-BF34"
    "2"  = "F6HQW-Q3799-9CJXR-9P3YD-6CJJ6"
    "3"  = "246PH-B8XYM-B7DFM-RR8PM-JRHXC"
    "4"  = "2TYBW-XKCQM-XY9X3-JDXYP-6CJ97"
    "5"  = "3YDB8-YY3P4-G7FCW-GJMPG-VK48C"
    "6"  = "DDRV-TNCDD-K3IR-V0WTF-YRTY-3K27"
    "7"  = "JJOL-AA9KH-DNJ4-B8GPM-VGYFP-X2YT"
    "8"  = "V7C3N-3W6CM-PDKR2-KW8DQ-RJMRD"
    "9"  = "V7C3N-3W6CM-PDKR2-KW8DQ-RJMRD"
    "10" = "XGXQ-WYFT-DPTN-BT9S-FEWC-HCRX"
    "11" = "MPGY-V7TJ-NP2I-2DFM-MRYC-KPDJ"
    "12" = "37GNV-YCQVD-38XP9-T848R-FC2HD"
    "13" = "NF6HC-QH89W-F8WYV-WWXV4-WFG6P"
    "14" = "TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
    "15" = "VK7JG-NPHTM-C97JM-9MPGT-3V66T"
}

# Handle activation
if ($choice -eq "16") {
    Write-Host (CenterText "Exiting...") -ForegroundColor Red
    exit
} elseif ($keys.ContainsKey($choice)) {
    $productKey = $keys[$choice]
    Write-Host "`n$(CenterText 'Activating Windows...')" -ForegroundColor Yellow
    Start-Process -NoNewWindow -FilePath "cmd.exe" -ArgumentList "/c slmgr /ipk $productKey"
    Start-Process -NoNewWindow -FilePath "cmd.exe" -ArgumentList "/c slmgr /ato"
    Write-Host "`n$(CenterText 'Activation process completed!')" -ForegroundColor Green
} else {
    Write-Host "`n$(CenterText 'Invalid choice. Please try again.')" -ForegroundColor Red
}

Pause
