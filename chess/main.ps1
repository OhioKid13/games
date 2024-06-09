# Function to display the main menu
function Show-MainMenu {
    Clear-Host
    Write-Host "=============================="
    Write-Host "        Chess Game            "
    Write-Host "=============================="
    Write-Host "1. Start Game"
    Write-Host "2. Save Progress"
    Write-Host "3. Load Progress"
    Write-Host "4. Exit"
    Write-Host "=============================="
}

# Function to start the game
function Start-Game {
    # Define the initial chess board
    $board = @(
        @('♜', '♞', '♝', '♛', '♚', '♝', '♞', '♜'),
        @('♟', '♟', '♟', '♟', '♟', '♟', '♟', '♟'),
        @(' ', '.', '.', '.', '.', '.', '.', ' '),
        @(' ', '.', '.', '.', '.', '.', '.', ' '),
        @(' ', '.', '.', '.', '.', '.', '.', ' '),
        @(' ', '.', '.', '.', '.', '.', '.', ' '),
        @('♙', '♙', '♙', '♙', '♙', '♙', '♙', '♙'),
        @('♖', '♘', '♗', '♕', '♔', '♗', '♘', '♖')
    )

    # Variable to keep track of moves
    $moves = @()

    # Function to display the chess board
    function Show-Board {
        Clear-Host
        Write-Host "    a  b  c  d  e  f  g  h"
        Write-Host "  +------------------------+"
        for ($i = 0; $i -lt 8; $i++) {
            $row = "$(8 - $i) |"
            for ($j = 0; $j -lt 8; $j++) {
                $row += " $($board[$i][$j]) "
            }
            $row += "|"
            Write-Host $row
        }
        Write-Host "  +------------------------+"
        Write-Host "    a  b  c  d  e  f  g  h"
        Write-Host
        Write-Host "Moves: "
        foreach ($move in $moves) {
            Write-Host $move
        }
    }

    # Function to translate chess notation to board indices
    function Get-Indices {
        param (
            [string]$notation
        )
        $col = [int][char]::ToLower($notation[0]) - [int][char]'a'
        $row = 8 - [int][string]$notation[1]
        return @($row, $col)
    }

    # Function to make a move
    function Make-Move {
        param (
            [string]$from,
            [string]$to,
            [string]${player}
        )
        $fromIndices = Get-Indices -notation $from
        $toIndices = Get-Indices -notation $to
        $piece = $board[$fromIndices[0]][$fromIndices[1]]
        $board[$fromIndices[0]][$fromIndices[1]] = ' '
        $board[$toIndices[0]][$toIndices[1]] = $piece
        $moves += "${player}: $from to $to"
    }

    # Main game loop
    while ($true) {
        # Player move
        Show-Board
        $move = Read-Host "Enter your move (e.g., e2 e4)"
        if ($move -eq "exit") {
            $fileName = Read-Host "Enter the name for the .txt file to save your progress"
            $moves | Out-File -FilePath "$fileName.txt" -Encoding ASCII
            return
        }
        if ($move -match "^([a-h][1-8])\s+([a-h][1-8])$") {
            Make-Move -from $matches[1] -to $matches[2] -player "Player"
        } else {
            Write-Host "Invalid move. Please enter a move in the format 'e2 e4'."
            continue
        }
    }
}

# Function to save progress
function Save-Progress {
    $fileName = Read-Host "Enter the name for the .txt file to save your progress"
    try {
        $movesString = $moves -join "`r`n"  # Join moves with line breaks
        $movesString | Out-File -FilePath "$fileName.txt" -Encoding ASCII
        Write-Host "Progress saved successfully to $fileName.txt"
    } catch {
        Write-Host "Error saving progress: $_"
    }
}


# Function to load progress
function Load-Progress {
    $fileName = Read-Host "Enter the name of the .txt file to load your progress (with extension)"
    try {
        $moves = Get-Content -Path $fileName
        Start-Game
    } catch {
        Write-Host "Error loading progress: $_"
    }
}

# Main menu loop
while ($true) {
    Show-MainMenu
    $choice = Read-Host "Enter your choice"
    switch ($choice) {
        1 { Start-Game }
        2 { Save-Progress }
        3 { Load-Progress }
        4 { exit }
        default { Write-Host "Invalid choice. Please enter 1, 2, 3, or 4." }
    }
}
