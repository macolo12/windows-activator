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
    "1"  = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "2"  = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "3"  = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "4"  = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "5"  = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "6"  = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "7"  = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "8"  = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "9"  = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "10" = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "11" = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "12" = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "13" = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "14" = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    "15" = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
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
