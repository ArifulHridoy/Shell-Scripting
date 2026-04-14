echo -n "Enter your mark: "
read n
case $n in
[8-9][0-9]|100) echo "A+";;
7[0-9]) echo "A";;
6[0-9]) echo "A-";;
5[0-9]) echo "B";;
4[0-9]) echo "C";;
3[3-9]) echo "D";;
*) echo "F";;
esac
