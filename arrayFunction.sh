echo "Array"
languages=("C" "C++" "Java" "Python" "Bash")
for x in "${languages[@]}"
do
echo "- $x"
done

for (( i=0; i<${#languages[@]}; i++ ))
do
echo "languages[$i] = ${languages[$i]}"
done

echo "Associative Array"
declare -A st
st[a]="Ariful"
st[b]="3.82"
echo "Name : ${st[a]}"
echo "CGPA : ${st[b]}"
echo "Keys : ${!st[@]}"
echo "Values : ${st[@]}"

add(){
local a=$1;
local b=$2;
local s=$(( a+b ))
echo "Sum of $1 and $2 : $s"
}

multiply(){
local p=$(( $1 * $2))
echo $p
}

ans=$(multiply 7 8)
echo "7 X 8 = $ans"

fact(){
local n=$1
if (( n <= 1 )); then
echo 1
else
local sub=$(fact $(( n - 1 )))
echo $(( n * sub ))
fi
}

add 2 3
res=$(fact 5)
echo "5!= $res"
