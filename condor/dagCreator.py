#!/usr/bin/env python3
#generates a list of dagman jobs, this is a combinatory problem.
import numpy as np
JOB = 'JOB {} scirdr.condor\n'
VARIABLES = 'VARS {0} sigma1start="{1}"\nVARS {0} sigma1end="{2}"\nVARS {0} sigma1step="{3}"\nVARS {0} sigma2start="{4}"\nVARS {0} sigma2end="{5}"\nVARS {0} sigma2step="{6}"\nVARS {0} kstart="{7}"\nVARS {0} kend="{8}"\nVARS {0} kstep="{9}"\nVARS {0} anglestep="{10}"\nVARS {0} threshold="{11}"'

currentjob = 1
jobs = ""
variables = ""

#for sigma1start in range(1, 5):
#    for sigma1end in range(2, 6):
        #for sigma1step in np.arange(1, 1):
#            for sigma2start in range(2, 6):
#                for sigma2end in range(4, 8):
                   #for sigma2step in np.arange(1, 1):
for kstart in np.arange(-2, -0.25, 0.25):
    for kend in np.arange(0.25, 2, 0.25):
        kstep = 0.05
        anglestep = 30
        threshold = 1
        sigma1step = 1
        sigma2step = 1
        sigma1start = 2
        sigma1end = 4
        sigma2start = 2
        sigma2end = 3
        jobs += JOB.format('SCIRDR'+str(currentjob))
        variables += VARIABLES.format('SCIRDR'+str(currentjob), sigma1start, sigma1end, sigma1step, sigma2start, sigma2end, sigma2step, kstart, kend, kstep, anglestep, threshold)
        variables += '\n'
        currentjob+=1
dagmanFile = open('scirdr.dag', 'w')
dagmanFile.write(jobs)
dagmanFile.write('\n')
dagmanFile.write(variables)
