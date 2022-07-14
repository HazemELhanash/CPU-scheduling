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
wait[$i]=0
done
echo "Enter the quantum time"
read q
end=0
for ((i=0;$end<$n;i++))
do
i=$(($i%$n))
if [[ ${burst[$i]} -gt $q ]]
then
burst[$i]=$((${burst[$i]}-$q))
for ((j=0;j<$n;j++))
do
if [[ $i == $j ]] || [[ ${burst[$j]} -le 0 ]]
then
continue
fi
wait[$j]=$((${wait[$j]} + $q))
done
elif [[ ${burst[$i]} -le $q ]] && [[ ${burst[$i]} -gt 0 ]]
then
for((j=0;j<$n;j++))
do
if [[ $i == $j ]] || [[ ${burst[$j]} -le 0 ]]
then
continue
fi
wait[$j]=$((${wait[$j]} + ${burst[$i]}))
done
burst[$i]=$((${burst[$i]}-$q))
end=$(($end + 1))
fi
done
sumWait=0
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
