arr=($(cat data.txt))
for i in "${arr[@]}"
do
if [[ $i -gt 100 || $i -lt 0 ]]
then 
echo "Invalid Number"
else
case $((i/10)) in
10|9|8) echo "A+";;
7) echo "A";;
6) echo "B";;
5) echo "C";;
*) echo "F";;
esac
fi
done
