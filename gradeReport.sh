names=("Ariful" "Nirob" "Safwan" "Sabbir" "Mahin")
marks=(82 55 91 47 73)

get_grade() {
    local mark=$1
    if (( mark >= 80 )); then echo "A"
    elif (( mark >= 70 )); then echo "B"
    elif (( mark >= 60 )); then echo "C"
    elif (( mark >= 50 )); then echo "D"
    else echo "F"
    fi
}

is_pass() {
    (( $1 >= 50 )) && return 0 || return 1
}

echo "╔══════════════════════════════════════╗"
echo "║         STUDENT GRADE REPORT         ║"
echo "╚══════════════════════════════════════╝"
printf "%-12s %-6s %-6s %-8s\n" "Name" "Mark" "Grade" "Result"
echo "────────────────────────────────────────"

total=0
pass_count=0

for (( i=0; i<${#names[@]}; i++ ))
do
    name=${names[$i]}
    mark=${marks[$i]}
    grade=$(get_grade $mark)
    total=$(( total + mark ))
    
    if is_pass $mark; then
        result="Pass"
        (( pass_count++ ))
    else
        result="FAIL"
    fi
    printf "%-12s %-6s %-6s %-8s\n" "$name" "$mark" "$grade" "$result"
done

echo "────────────────────────────────────────"
avg=$(echo "scale=1; $total / ${#names[@]}" | bc)
echo "Class Average : $avg"
echo "Students Pass : $pass_count / ${#names[@]}"
