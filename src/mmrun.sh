cd ~/user/public
while true 
do
find ./bak -cmin +300 -type f -print|xargs -i rm {}
./mmcheck -w >/dev/null
sleep 120
done
