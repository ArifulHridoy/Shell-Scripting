echo -n "Enter no. of students: "
read n
total=0
pass=0
fail=0

for ((i=1; i<=n; i++))
do
echo -n "Enter mark for student $i: "
read m
total=$((total+m))
if [ $m -ge 80 ]
then
grade="A+"
cgpa=4.00
((pass++))
elif [ $m -ge 75 ]
then
grade="A"
cgpa=3.75
((pass++))
elif [ $m -ge 70 ]
then
grade="A-"
cgpa=3.50
((pass++))
elif [ $m -ge 65 ]
then
grade="B+"
cgpa=3.25
((pass++))
elif [ $m -ge 60 ]
then
grade="B"
cgpa=3.00
((pass++))
elif [ $m -ge 55 ]
then
grade="B-"
cgpa=2.75
((pass++))
elif [ $m -ge 50 ]
then
grade="C"
cgpa=2.50
((pass++))
elif [ $m -ge 45 ]
then
grade="D"
cgpa=2.25
((pass++))
elif [ $m -ge 40 ]
then
grade="E"
cgpa=2.00
((pass++))
else
grade="F"
cgpa=0.00
((fail++))
fi
echo -e "Student$i got $grade grade and cgpa $cgpa\n"
done
avg=$(echo "scale=2; $total/$n" | bc)
echo "Total marks: $total"
echo "Average marks : $avg"
echo "Total Passed: $pass"
echo "Total Failed: $fail"
