import hashlib

# List of songs
songs = [
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
]

def generate_hash(input_string):
    # Generate a simple hash using SHA-256
    return int(hashlib.sha256(input_string.encode()).hexdigest(), 16)

def get_music_match(favorite_color, favorite_word):
    # Generate hashes for the favorite color and word
    color_hash = generate_hash(favorite_color)
    word_hash = generate_hash(favorite_word)

    # Sum the hashes
    combined_hash = color_hash + word_hash

    # Get the index of the chosen song using modulo operation
    song_index = combined_hash % len(songs)

    # Return the chosen song
    return songs[song_index]

# Example usage
favorite_color = input("Enter your favorite color: ")
favorite_word = input("Enter your favorite word: ")

music_match = get_music_match(favorite_color, favorite_word)
print(f"Your music match is: {music_match}")