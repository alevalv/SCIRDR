### HTCondor Files
This folder contains a condor file that enables running the programmed code of this repository in the univalle HTCondor cluster, this file is used by a Dagman file that can be generated with `dagCreator.py`.

To submit it to the cluster move these two files (`scirdr.condor` and `scirdr.dag`) to the root folder of this project and run:
```
condor_submit_dag scirdr.dag
```
You can watch the execution process using `condor_q`
