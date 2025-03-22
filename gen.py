# python script that takes in a file and generates a new file
# The content of the file is a C++ program that has a million unique public symbols
# and a hundred shared public symbols

import sys

def main():
    if len(sys.argv) != 2:
        print("Usage: python gen.py <filenum>")
        sys.exit(1)

    filenum = int(sys.argv[1])
    filename = "gen/src" + str(filenum) + ".cpp"
    with open(filename, "w") as f:
        # unique symbols
        for i in range(100000):
            f.write(f"int unique_{filenum}_{i} = {i};\n")
        # shared symbols
        for i in range(1000):
            f.write(f"int shared_{i} = {i};\n")
        
        

if __name__ == "__main__":
    main()