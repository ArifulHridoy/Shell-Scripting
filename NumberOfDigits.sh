echo -n "Enter any integer number: "
read n
count=0
while ((n!=0))
do
n=$((n/10))
count=$((count+1))
done
echo "Number of digits = $count."
