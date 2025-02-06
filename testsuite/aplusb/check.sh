#!/bin/bash

# 编译 std.cpp，生成可执行文件 std
echo "编译 std.cpp ..."
g++ std.cpp -o std
if [ $? -ne 0 ]; then
  echo "编译失败，请检查 std.cpp"
  exit 1
fi
echo "编译成功！"

for infile in data/*.in; do
  base=$(basename "$infile" .in)
  expected="data/${base}.out"
  if [ ! -f "$expected" ]; then
    echo "测试样例 $base 的预期输出文件 $expected 不存在"
    continue
  fi
#   cat temp_output.txt
  ./runprog -cgroup -runner=container -in="$infile" -out=temp_output.txt /root/wk/sailor/testsuite/aplusb/std 
  if diff -q -B temp_output.txt "$expected" > /dev/null; then
    echo "$base: ✔"
  else
    echo "$base: ✖"
  fi
done

echo 
rm -f temp_output.txt
