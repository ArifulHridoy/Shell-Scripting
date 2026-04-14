fact=1
echo -n "Enter any integer number: "
read n
if [ $n -lt 0 ]
then
echo "Negative number!"
elif [ $n -ge 40 ]
then
echo "Too big to calculate!"
else
for ((i=2; i<=n; i++))
do
fact=$((fact*i));
done
echo "Factorial: $fact"
fi
