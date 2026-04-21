target="$1"

if [ -z "$target" ]; then
echo "Usage: $0 <path>"
exit 1
fi

echo "Inspecting: $target"
echo ""

[ -e "$target" ] && echo "[YES] Path exists" || echo "[NO] Path does not exist"
[ -f "$target" ] && echo "[YES] Is a regular file" || echo "[NO] Not a regular file"
[ -d "$target" ] && echo "[YES] Is a directory" || echo "[NO] Not a directory"
[ -r "$target" ] && echo "[YES] Is readable" || echo "[NO] Not readable"
[ -w "$target" ] && echo "[YES] Is writable" || echo "[NO] Not writable"
[ -x "$target" ] && echo "[YES] Is executable" || echo "[NO] Not executable"
[ -s "$target" ] && echo "[YES] File is non-empty" || echo "[NO] File is empty"
[ -L "$target" ] && echo "[YES] Is a symbolic link" || echo "[NO] Not a symbolic link"
