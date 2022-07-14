echo "Enter number of processes"
read n
echo "Enter burst time of each process"
burst=()
wait=()
turnaround=()
constBurst=()
for((i=0;i<$n;i++))
do
echo -n "P$(($i+1)): "
read b
burst+=($b)
constBurst+=($b)
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
fi
if [[ ${arrival[$i]} -gt z ]]
then
z=${arrival[$i]}
fi
done
t=0
for ((i=0;i<$n;i++))
do
if [[ ${arrival[$i]} == 0 ]]
then
wait[$i]=0
t=$(($t + ${burst[$i]}))
burst[$i]=-1
fi
done
for ((i=0;i<$n;i++))
do
min=$y
for ((j=0;j<$n;j++))
do
if [[ ${burst[$j]} -le $min ]] && [[ ${burst[$j]} -gt 0 ]] && [[ ${arrival[$j]} -le $t ]] && [[ ${arrival[$j]} -lt $z ]]
then
min=${burst[$j]}
x=$j
elif [[ ${burst[$j]} -lt $min ]] && [[ ${burst[$j]} -gt 0 ]] && [[ ${arrival[$j]} -le $t ]] && [[ ${arrival[$j]} == $z ]]
then
min=${burst[$j]}
x=$j
fi
done
if [[ ${burst[$x]} -gt 0 ]]
then
wait[$x]=$(($t - ${arrival[$x]}))
t=$(($t + ${burst[$x]}))
burst[$x]=-1
fi
done
echo "Results"
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
