echo "Enter number of processes"
read n
echo "Enter burst time of each process"
burst=()
wait=()
turnaround=()
constBurst=()
sumBurst=0
for((i=0;i<$n;i++))
do
echo -n "P$(($i+1)): "
read b
burst+=($b)
constBurst+=($b)
wait[$i]=0
sumBurst=$(($sumBurst+$b))
done
arrival=()
echo "Enter arrival time for each process"
for((i=0;i<$n;i++))
do
echo -n "P$(($i+1)): "
read a
arrival+=($a)
done
x=0
y=-1
z=-1
for ((i=0;i<$n;i++))
do
if [[ ${burst[$i]} -gt $y ]]
then
y=${burst[$i]}
elif [[ ${arrival[$i]} -gt z ]]
then
z=${arrival[$i]}
fi
done
end=0
while (($end<$n))
do
for((t=0;t<$sumBurst;t++))
do
min=$y
for((i=0;i<$n;i++))
do
if [[ ${burst[$i]} -lt $min ]] && [[ ${burst[$i]} -gt 0 ]] && [[ ${arrival[$i]} -le $t ]] && [[ ${arrival[$i]} -le $z ]]
then
min=${burst[$i]}
x=$i
fi
done
for((i=0;i<$n;i++))
do
if [[ $i == $x ]]
then
burst[$i]=$((${burst[$i]}-1))
elif [[ ${burst[$i]} -gt 0 ]] && [[ ${arrival[$i]} -le $t ]]
then
wait[$i]=$((${wait[$i]}+1))
fi
done
if [[ ${burst[$x]} -le 0 ]]
then
end=$(($end+1))
fi
done
done
echo "Results"
sumWait=0
for ((i=0;i<$n;i++))
do
echo -n "The waiting time of process $(($i+1)) : "
echo ${wait[$i]}
sumWait=$(($sumWait + ${wait[$i]}))
done
for ((i=0;i<$n;i++))
do
turnaround[$i]=$(( ${wait[$i]} + ${constBurst[$i]} ))
done
sumTurn=0
for ((i=0;i<$n;i++))
do
sumTurn=$(( $sumTurn + ${turnaround[$i]} ))
done
echo -n "The average waiting time= "
avrWait= bc -l <<< $sumWait/$n
echo -n "The average Turnaround time= "
avgTurn= bc -l <<< $sumTurn/$n
