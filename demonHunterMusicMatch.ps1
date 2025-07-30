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

# Prompt for user input
$favoriteColor = Read-Host "Enter your favorite color"
$favoriteWord = Read-Host "Enter your favorite word"

# Generate hashes for the favorite color and word
$colorHash = Generate-Hash -input $favoriteColor
$wordHash = Generate-Hash -input $favoriteWord

# Sum the hashes
$combinedHash = $colorHash + $wordHash

# Get the index of the chosen song using modulo operation
$songIndex = $combinedHash % $songs.Count

# Select the song
$selectedSong = $songs[$songIndex]

# Display the result
Write-Host "Your music match is: $selectedSong"
