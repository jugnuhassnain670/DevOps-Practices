#arrays
name[0]=5
name[1]=6
name[2]=7
name[3]=8

echo ${name[0]}
echo ${name[1]}
echo ${name[2]}
echo ${name[3]}




# First Programe
echo "What is your name?"
read PERSON
echo "Hello, $PERSON"

for PERSON in $*
do
   echo $PERSON
done

#Listing file
ls -l
pwd
#Readonly variables 

jugnu="Jugnu is a Vloger"
readonly jugnu
echo $jugnu


jugnu2="Using unset value"
unset jugnu2
echo $jugnu2

#Special Variables
echo $$



a=0
while [ "$a" -lt 10 ]    # this is loop1
do
   b="$a"
   while [ "$b" -ge 0 ]  # this is loop2
   do
      echo -n "$b "
      b=`expr $b - 1`
   done
   echo
   a=`expr $a + 1`
done