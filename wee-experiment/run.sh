TIMELIMIT=30

while read instance; do
  line=$(grep $instance ~/Code/ijcai2017-partitioning-common-subgraph/experiments/mcsplaininstances.txt)
  file1=$(cut -d" " -f2 <(echo $line))
  file2=$(cut -d" " -f3 <(echo $line))
  ../mcsp -t $TIMELIMIT min_max $file1 $file2 > results/$instance-plain.out
  ../mcsp -t $TIMELIMIT min_max -b $file1 $file2 > results/$instance-b.out
  ../mcsp -t $TIMELIMIT min_max -h $file1 $file2 > results/$instance-h.out
  echo $instance \
    $(grep "CPU" results/$instance-plain.out | awk '{print $4}') \
    $(grep "CPU" results/$instance-b.out | awk '{print $4}') \
    $(grep "CPU" results/$instance-h.out | awk '{print $4}') \
    $(grep "Solution" results/$instance-plain.out | awk '{print $3}') \
    $(grep "Solution" results/$instance-b.out | awk '{print $3}') \
    $(grep "Solution" results/$instance-h.out | awk '{print $3}')
done < instances.txt | tee results.txt
