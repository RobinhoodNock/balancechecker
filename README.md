Nockchain Balance Checker Script
What it does

This script helps you check your Nockchain wallet balance by public key. It:

    Prompts you to enter your public key — a unique identifier for your wallet.

    Checks if a CSV file with your notes exists for that public key.

        If it doesn't exist, the script automatically generates it by querying your wallet.

    Reads all your notes from the CSV, each representing an amount of "Nicks" (the smallest asset unit).

    Displays each note’s balance individually in both Nicks and Nocks (where 1 Nock = 65,536 Nicks).

    Calculates and displays the total balance for your wallet in both Nicks and Nocks.

Why use it?

    You don’t need to manually sum your wallet’s assets.

    Easily see detailed balances per note and a clear total.

    Automatically fetches data if it’s not already available.

Usage

Run the script and enter your public key when prompted:

bash ./checkbalance.sh
