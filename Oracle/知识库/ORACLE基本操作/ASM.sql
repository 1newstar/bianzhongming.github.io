export ORACLE_SID=+ASM1
asmcmd

-----------
��ʹ�ÿռ䣺
1.�鿴v$asm_diskgroup��ͼ
SQL> select group_number,name,total_mb,free_mb from v$asm_diskgroup;

2.����asmcmd�鿴
rac2:oracle:rac2 > export ORACLE_SID=+ASM1
rac2:oracle:rac2 > asmcmd
ASMCMD> lsdg