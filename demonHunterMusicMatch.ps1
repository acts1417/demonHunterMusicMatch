# Load the necessary WPF assembly
Add-Type -AssemblyName PresentationFramework

# Define the XAML for the WPF window
[xml]$XAML = @"
<Window x:Class="MainWindow" xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Title="Music Match" Height="200" Width="300">
    <Grid>
        <Label Content="Favorite Color:" HorizontalAlignment="Left" Margin="10,10,0,0" VerticalAlignment="Top" Width="100"/>
        <TextBox Name="ColorInput" HorizontalAlignment="Left" Margin="110,10,0,0" VerticalAlignment="Top" Width="170"/>
        <Label Content="Favorite Word:" HorizontalAlignment="Left" Margin="10,50,0,0" VerticalAlignment="Top" Width="100"/>
        <TextBox Name="WordInput" HorizontalAlignment="Left" Margin="110,50,0,0" VerticalAlignment="Top" Width="170"/>
        <Button Content="Submit" HorizontalAlignment="Left" Margin="10,90,0,0" VerticalAlignment="Top" Width="270" Click="Submit_Click"/>
    </Grid>
</Window>
"@

# Create the WPF window
$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Define the song list
$songs = @(
    "Takedown (TWICE Version)",
    "How It’s Done",
    "Soda Pop",
    "Golden",
    "Strategy",
    "Takedown",
    "Your Idol",
    "Free",
    "What It Sounds Like",
    "Path",
    "Score Suite",
    "Love, Maybe"
)

# Function to generate a simple hash
function Generate-Hash {
    param (
        [string]$input
    )
    return [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($input)) | ForEach-Object { $_.ToString("x2") } | ForEach-Object { [Convert]::ToInt64($_, 16) }
}

# Event handler for the Submit button
$window.Add_Click({
    $color = $window.FindName("ColorInput").Text
    $word = $window.FindName("WordInput").Text

    if ($color -and $word) {
        $colorHash = Generate-Hash -input $color
        $wordHash = Generate-Hash -input $word
        $combinedHash = $colorHash + $wordHash
        $songIndex = $combinedHash % $songs.Count
        $selectedSong = $songs[$songIndex]

        [System.Windows.MessageBox]::Show("Your music match is: $selectedSong", "Result", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information)
    } else {
        [System.Windows.MessageBox]::Show("Please enter both your favorite color and word.", "Error", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
    }
})

# Show the window
$window.ShowDialog()
