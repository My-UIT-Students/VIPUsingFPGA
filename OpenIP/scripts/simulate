TESTNAME=test
SEED=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
echo "  Test name = $TESTNAME"
echo "  Test seed = $SEED"
vsim -c -voptargs=+acc work.top_tb \
-l ./results/log/$TESTNAME.log \
-wlf ./results/$TESTNAME.wlf \
-do "log -r /*; run -all " 
