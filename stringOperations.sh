str="Hello, Shell Programming!"

echo "String : $str"
echo "Length : ${#str}"

echo "Chars 7-11 : ${str:7:5}"

echo "Uppercase : ${str^^}"
echo "Lowercase : ${str,,}"

echo "Replace first : ${str/l/L}"

echo "Replace all : ${str//l/L}"

path="/home/student/scripts/demo.sh"
echo "Filename : ${path##*/}"

echo "Without ext : ${path%.*}"

echo -e "Enter a username: \c"
read username

if [ -z "$username" ]; then
echo "Error: Username cannot be empty."
exit 1
fi

if [ ${#username} -lt 4 ]; then
echo "Error: Username must be at least 4 characters."
exit 1
fi

case $username in
[a-zA-Z]*) echo "Valid username: $username";;
*) echo "Error: Username must start with a letter.";;
esac
