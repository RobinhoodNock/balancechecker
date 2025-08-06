# balancechecker
Balance Checker for Nicks and Nocks in Nockchain

What this script does:

    Ask you for a public key — the identifier for your Nockchain wallet.

    Check if a file with your notes exists for that public key.

        If it doesn’t, it will automatically create that file by asking Nockchain for all your notes.

    Add up all your assets (called "Nicks") from that file.

        Each asset is a tiny part of your total balance.

    Convert the total Nicks into Nocks — the bigger unit.

        (1 Nock = 65,536 Nicks)

    Show you your balance both as:

        Total Nicks (smallest unit)

        Total Nocks (decimal number)
