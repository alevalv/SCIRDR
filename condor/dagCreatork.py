#!/usr/bin/env python3
#generates a list of dagman jobs, this is a combinatory problem.
import numpy as np
JOB = 'JOB {} scirdr.condor\n'
VARIABLES = 'VARS {0} sigma1start="{1}"\nVARS {0} sigma1end="{2}"\nVARS {0} sigma1step="{3}"\nVARS {0} sigma2start="{4}"\nVARS {0} sigma2end="{5}"\nVARS {0} sigma2step="{6}"\nVARS {0} k1start="{7}"\nVARS {0} k1end="{8}"\nVARS {0} k1step="{9}"\nVARS {0} k2start="{10}"\nVARS {0} k2end="{11}"\nVARS {0} k2step="{12}"\nVARS {0} anglestep="{13}"\nVARS {0} threshold="{14}"'

currentjob = 1
jobs = ""
variables = ""

#for sigma1start in range(1, 5):
#    for sigma1end in range(2, 6):
        #for sigma1step in np.arange(1, 1):
#            for sigma2start in range(2, 6):
#                for sigma2end in range(4, 8):
                   #for sigma2step in np.arange(1, 1):
for k1start in np.arange(-1.0, 1.0, 0.20):
    for k1end in np.arange(0.0, 2.0, 0.20):
        if k1start > k1end:
            break
        for sigma1start in range(1, 5, 1):
            for sigma1end in range(2, 6, 1):
                if sigma1start >= sigma1end:
                    break
                for sigma2start in range(2, 6, 1):
                    for sigma2end in range(3, 7, 1):
                        if sigma2start >= sigma2end:
                            break
                        for k2start in np.arange(-2.0, 1.0, 0.10):
                            for k2end in np.arange(0.0, 3.0, 0.10):
                                k1step = 0.05
                                k2step = 0.05
                                anglestep = 30
                                threshold = 0.5
                                sigma1step = 1
                                sigma2step = 1
                                jobs += JOB.format('SCIRDR'+str(currentjob))
                                variables += VARIABLES.format('SCIRDR'+str(currentjob), sigma1start, sigma1end, sigma1step, sigma2start, sigma2end, sigma2step, k1start, k1end, k1step, k2start, k2end, k2step, anglestep, threshold)
                                variables += '\n'
                                currentjob+=1
dagmanFile = open('scirdrk.dag', 'w')
dagmanFile.write(jobs)
dagmanFile.write('\n')
dagmanFile.write(variables)
