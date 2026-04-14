echo -n "Enter any integer number: "
read n
rev=0
while ((n!=0))
do
digit=$((n%10))
rev=$((rev*10+digit))
n=$((n/10))
done
echo "Reverse of the number : $rev"
