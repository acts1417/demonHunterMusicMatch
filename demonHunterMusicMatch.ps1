# Define the song list
$songs = @(
    "Takedown (TWICE Version)",
    "How Its Done",
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

function Sum-Utf8Values {
    param (
        [string]$inputString
    )

    $utf8Bytes = [System.Text.Encoding]::UTF8.GetBytes($inputString)
    $sum = 0

    foreach ($byte in $utf8Bytes) {
        $sum += $byte
    }

    return $sum
}


# Prompt for user input
$favoriteColor = Read-Host "Enter your favorite color"
$favoriteWord = Read-Host "Enter your favorite word"

$colorSum = Sum-Utf8Values($favoriteColor)
$wordSum = Sum-Utf8Values($favoriteWord)

# Get the index of the chosen song using modulo operation
$songIndex = ($colorSum + $wordSum ) % $songs.Count

# Select the song
$selectedSong = $songs[$songIndex]

# Display the result
Write-Host "Your music match is: $selectedSong"
