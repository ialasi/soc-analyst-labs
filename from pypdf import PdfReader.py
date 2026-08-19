from pypdf import PdfReader

pdf = "locked.pdf"
wordlist = "wordlist.txt"

reader = PdfReader(pdf)

with open(wordlist, "r", encoding="utf-8") as f:
    passwords = [line.strip() for line in f if line.strip()]
    
for password in passwords:
    try:
        result = reader.decrypt(password)

        if result:
            print(f"[+] Password found: {password}")
            break

    except Exception:
        pass
else:
    print("[-] Password not found in wordlist.")