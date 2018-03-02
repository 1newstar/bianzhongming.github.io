##MHA����ָ��
### һ��׼������

1. Ӳ��׼��������ϵͳ��װ��ϣ���Ҫroot�û�Ȩ�޺����룩��
2. �����mysql���ӷ���ע�⸴���û���root�û���master��slave��MHAmanager�ڵ�����Ҫ���ܷ��ʣ���
3. SLAVE��read_onlyȨ��ͨ��set global�������ã���ͨ��my.cnf���á�

### �����滮��MHA��װ

1. �滮
   - mhaManager�ڵ�������IP
   - mhaNode�ڵ㣨����mysql master��slave��������IP
   - �滮vip

2. mhaNode/mhaManager������֮�佨��ssh���ţ���֤���ܵ�½��

3. mhaNode�ڵ㰲װ

   ```sh
   yum��װ��
   yum install perl-DBD-MySQL -y

   rpm��װ��
   rpm -ivh mysql-libs-5.1.73-8.el6_8.x86_64.rpm
   rpm -ivh perl-DBD-MySQL-4.013-3.el6.x86_64.rpm 

   ��װ�ڵ����
   rpm -ivh mha4mysql-node-0.56-0.el6.noarch.rpm
   ```

   ��װ��ɺ����/usr/binĿ¼���������½ű��ļ�(��Щ����ͨ����MHAManager�Ľű�������������Ϊ����)��

   - save_binary_logs              //����͸���master�Ķ�������־
   - apply_diff_relay_logs          //ʶ�������м���־�¼������������¼�Ӧ����������slave
   - filter_mysqlbinlog             //ȥ������Ҫ��ROLLBACK�¼���MHA�Ѳ���ʹ��������ߣ�
   - purge_relay_logs               //����м���־����������SQL�̣߳�

4. mhaManager�ڵ㰲װ

   ```sh
   yum��װ��
   yum install perl-DBD-MySQL -y  ����node�ڵ��ظ���
   yum install perl-Config-Tiny -y
   yum install epel-release -y
   yum install perl-Log-Dispatch -y
   yum install perl-Parallel-ForkManager -y

   rpm��װ��
   rpm -ivh perl-Config-Tiny-2.12-7.1.el6.noarch.rpm
   rpm -ivh epel-release-6-8.noarch.rpm
   rpm -ivh perl-Parallel-ForkManager-0.7.9-1.el6.noarch.rpm
   # rpm -ivh  compat-db-4.6.21-17.el6.x86_64.rpm
   rpm -ivh perl-Mail-Sender-0.8.16-3.el6.noarch.rpm
   rpm -ivh perl-Mail-Sendmail-0.79-12.el6.noarch.rpm
   rpm -ivh perl-Email-Date-Format-1.002-5.el6.noarch.rpm
   rpm -ivh perl-MIME-Types-1.28-2.el6.noarch.rpm
   rpm -ivh perl-TimeDate-1.16-13.el6.noarch.rpm
   rpm -ivh perl-Params-Validate-0.92-3.el6.x86_64.rpm
   rpm -ivh perl-MailTools-2.04-4.el6.noarch.rpm
   rpm -ivh perl-MIME-Lite-3.027-2.el6.noarch.rpm
   rpm -ivh perl-Log-Dispatch-2.27-1.el6.noarch.rpm

   ��װ�������
   rpm -ivh mha4mysql-manager-0.56-0.el6.noarch.rpm 
   ```

   ��װ��ɺ����/usr/binĿ¼���������½ű��ļ�:

   - masterha_check_repl  
   - masterha_check_ssh  
   - masterha_check_status  
   - masterha_conf_host  
   - masterha_manager  
   - masterha_master_monitor  
   - masterha_master_switch  
   - masterha_secondary_check  
   - masterha_stop  
   - filter_mysqlbinlog  
   - save_binary_logs  
   - purge_relay_logs  
   - apply_diff_relay_logs 

   ?

### ��������(����ڵ�)

1. �޸�ȫ�������ļ���masterha_default.conf��

   ```sh
   # vi masterha_default.conf 

   [server default]
   #MySQL���û�������
   user=root
   password=mysql
   #ϵͳssh�û�
   ssh_user=root
   #�����û�
   repl_user=repl
   repl_password= repl.123
   #���
   ping_interval=1
   #shutdown_script=""
   #�л����õĽű�
   master_ip_failover_script= /etc/masterha/master_ip_failover
   master_ip_online_change_script= /etc/masterha/master_ip_online_change
   ```

2. �޸ļ�Ⱥ�����ļ���app1.conf��

   ```sh
   # vi app1.conf

   [server default]
   user=root
   password=mysql
   #mha manager����Ŀ¼
   manager_workdir = /var/log/masterha/app1
   manager_log = /var/log/masterha/app1/app1.log
   remote_workdir = /var/log/masterha/app1
   [server1]
   hostname=172.32.3.104 #����������ϣ��Ѵӿ�д�����ڵ�
   ## cat my.cnf|grep log-bin
   master_binlog_dir =/export/servers/data/my3306/binlog/
   port=3306
   [server2]
   hostname=172.32.3.102 #����������ϣ�������д�ɱ��ڵ�
   ## cat my.cnf|grep log-bin
   master_binlog_dir=/export/servers/data/my3307/binlog/
   port=3307
   candidate_master=1
   check_repl_delay = 0 #�÷�ֹmaster����ʱ���л�ʱslave���ӳ٣����������в�������

   #ע�������һ����Ӽܹ�����ôֻ��Ҫ��app1/conf�ļ������ٶ���Ӽ������ü��ɣ��������£�
   [server3]
   hostname=192.168.0.x
   port=3306
   master_binlog_dir=/data/mysql/data
   ```

3. �޸�IP�л������ļ�

   ```sh
   �޸�master_ip_failover�ļ��е�VIP�Ͱ�����
   vim /etc/masterha/master_ip_failover
   my $vip = "172.32.3.195";
   my $if = "eth0";

   �޸�master_ip_online_change�ļ��е�VIP�Ͱ�������
   vim /etc/masterha/master_ip_online_change
   ���޸�������ͬ��

   ��drop_vip.sh��init_vip.sh�е�������VIP���Ĺ���
   ```

   �ѽű�����ִ��Ȩ�ޣ�chmod +x drop_vip.sh init_vip.sh master_ip_*



### �ġ����Ժ͹���ڵ����ͣ

1. Manager����ssh��ͨ�ԣ�

   ```sh
   masterha_check_ssh --conf=/etc/masterha/app1.conf

      ע�⣺����������������ʵ�飬�ܿ��������ⲽ�豨���������߶��޷�ssh����һ�߿��ԣ�һ�߲����ԣ���ʱ���������´�����Կ���ԣ������γ�����Ȼ���У���ô�Ͱѷ���ssh���Ӷ�ʧ�ܵ��������һ̨���ԡ����ߣ�������ļܹ��ǲ��ǰѹ���ڵ�����ݽڵ��һ�𣬶�����ڵ�����û�������Լ����Լ�����Կ��¼��

      ���������ʾ��[info] All SSH connection tests passed successfully.��ʾ����ͨ��
   ```

2. ���Լ�Ⱥ�е����Ӹ���

   ```sql
   masterha_check_repl --conf=/etc/masterha/app1.conf --global_conf=/etc/masterha/masterha_default.conf
   ע�⣺ִ�������������ʱ��ʹ�õ���user=root�ʺ�ȥ��⣬
   ע��user=root�ʺ�ҲҪ��Զ��Ȩ��,���⣬��mysqlĿ¼�µ������������ӣ�
   # ln -s /usr/local/mysql/bin/* /usr/bin/
   -- ln -s ����Ŀ�� ���������·��
   ���������ʾ��MySQL Replication Health is OK.��ʾ����ͨ��
   ```

3. ����ڵ����ͣ��״̬

   ```sh
   ��������ڵ�(ֻ�ڴӿ�����������ڵ�)��
   ��������ڵ����ʹ��screen������
   nohup masterha_manager --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf --remove_dead_master_conf --ignore_last_failover> /tmp/mha_manager.log 2>&1 &
   # ps -elf |grep masterha_manager

   ȷ��VIP �󶨳ɹ������ҵ��VIP ���õķ���DB��Ӧ���Ѿ�������������
   ����֮��鿴����̨�����־��
   tail -100f /tmp/mha_manager.log
   �鿴app1��־�����
   tail -f /var/log/masterha/app1/app1.log

   �鿴master�Ľ���״����־��
   cat /var/log/masterha/app1/app1.master_status.health

   ����Ƿ������ɹ���
   masterha_check_status --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf

   ֹͣmha server
   masterha_stop   --conf=/etc/masterha/app1.conf
   ```
4. �л�����

   ```sh
   1.�����ֹ��л���ά���л�����Ҫ��MHA��ؽ��̹ص�����
   masterha_master_switch --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf --master_state=alive --new_master_host=172.32.3.102 --orig_master_is_new_slave --running_updates_limit=10000
   masterha_master_switch --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf --master_state=alive --new_master_host=172.32.3.104 --orig_master_is_new_slave --running_updates_limit=10000
   --orig_master_is_new_slave���Ѿɵ�master����Ϊ�ӿ�
   --running_updates_limit=10000��������ӿ�ͬ���ӳ���10000s�ڶ������л������ǵ����л���ʱ�䳤������recoverʱrelay ��־�Ĵ�С����
   --interactive=0���Ƿ���Ҫ�ֶ�yesȷ�Ͻ���
   �л��ɹ���Ҫ���������������ʾ��
   [info] Switching master to 192.168.171.135(192.168.171.135:3306) completed successfully.
   ͬʱҪ�鿴VIP�Ƿ��Ѿ�Ư�Ƶ����µ���������
   ע���ֶ������л�mha���л�ʱ��Ҫ�������е�mha ͣ��������л���

   #�л�����
   Fri Feb  9 10:27:24 2018 - [error][/usr/share/perl5/vendor_perl/MHA/MasterRotate.pm, ln142] Getting advisory lock failed on the current master. MHA Monitor runs on the current master. Stop MHA Manager/Monitor and try again.
   Fri Feb  9 10:27:24 2018 - [error][/usr/share/perl5/vendor_perl/MHA/ManagerUtil.pm, ln177] Got ERROR:  at /usr/bin/masterha_master_switch line 53.
   #��Ҫ��ֹͣmha server���л�
   masterha_stop   --conf=/etc/masterha/app1.conf
   #�ٴγ����л�
   Execution of /etc/masterha/master_ip_online_change aborted due to compilation errors.
   Fri Feb  9 10:38:40 2018 - [error][/usr/share/perl5/vendor_perl/MHA/ManagerUtil.pm, ln177] Got ERROR:  at /usr/bin/masterha_master_switch line 53.
   syntax error at /etc/masterha/master_ip_online_change line 171, near ")
         ## Waiting for N * 100 milliseconds so that current connections can exit
         my "
    # ��������Ҫ�ӷֺŽ�����&drop_vip();��
    #�����޸�my.cnf �����report_id �� report_port������������������master�����ѯslaveHosts��show slave hosts;

   2.�����ֹ��л���MHA����û�������߹��˵�ͬʱ����Ҳ���ˣ���
   # masterha_master_switch --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf --dead_master_host=old_ip --master_state=dead --new_master_host=new_ip --ignore_last_failover
   masterha_master_switch --global_conf=/etc/masterha/masterha_default.conf --conf=/etc/masterha/app1.conf --dead_master_host=192.168.171.135 --master_state=dead --new_master_host=192.168.171.136 --ignore_last_failover
   �л��ɹ���Ҫ��������������ʾ��
   Started manual(interactive) failover.
   Invalidated master IP address on 192.168.171.135(192.168.171.135:3306)
   Selected 192.168.171.136(192.168.171.136:3306) as a new master.
   192.168.171.136(192.168.171.136:3306): OK: Applying all logs succeeded.
   192.168.171.136(192.168.171.136:3306): OK: Activated master IP address.
   192.168.171.136(192.168.171.136:3306): Resetting slave info succeeded.
   Master failover to 192.168.171.136(192.168.171.136:3306) completed successfully.
   ע�⣺�������������������ţ�ֻ��mysqld���˵�ʱ��VIP���л���ʱ��Ҳ���Զ�Ư�ƣ�����Ƿ��������ˣ���ô�ڹҵ�������������ע�ⲻҪ��VIP�濪����������Ϊ��ʱVIP�Ѿ�Ư�Ƶ��˴ӿ��ϣ��ӿ��Ͽ������ڽӹ�ҵ�񣬹���������������Ҫȷ�������Ƿ���µ�����һ�������һ������ô�Ͱѹ���������Ϊ�µĴӿ������������

   3.�����Զ��л�������MHA��ؽ��̣��ֶ�������mysqldͣ�����۲�/var/log/masterha/app1.log��־���������������Ϣ��
   ----- Failover Report -----

   app1: MySQL Master failover 192.168.171.135(192.168.171.135:3306) to 192.168.171.136(192.168.171.136:3306) succeeded

   Master 192.168.171.135(192.168.171.135:3306) is down!

   Check MHA Manager logs at bzm.testing:/var/log/masterha/app1/app1.log for details.

   Started automated(non-interactive) failover.
   Invalidated master IP address on 192.168.171.135(192.168.171.135:3306)
   Selected 192.168.171.136(192.168.171.136:3306) as a new master.
   192.168.171.136(192.168.171.136:3306): OK: Applying all logs succeeded.
   192.168.171.136(192.168.171.136:3306): OK: Activated master IP address.
   192.168.171.136(192.168.171.136:3306): Resetting slave info succeeded.
   Master failover to 192.168.171.136(192.168.171.136:3306) completed successfully.
   ��ʾ�ɹ��л����л��ɹ��󣬲鿴VIP�Ƿ�Ư�Ƶ��˴ӿ���(�л��ɹ���MHA���̻��Զ�ֹͣ)��ͬʱ�鿴/etc/masterha/app1.conf�ļ��е�[server1]�������Ƿ񶼱�ɾ������
   ����������������Ҫȷ�������Ƿ���µ�����һ�������һ������ô�Ͱѹ���������Ϊ�µĴӿ�����������¡�Ȼ���ڹ�������������MHA���̡�

   ```

