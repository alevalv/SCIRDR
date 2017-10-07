# SCIRD-TS

To run this project on htcondor, copy your input files that follow this structure `input/source` with the original images `input/groundTruth` with the specialist segmentation and `input/mask` with the mask information of the retinal image. This project runs with the  DRIVE dataset.

To run locally, you can use the following command

```sh
 ./runner.sh scirdts_octave.m ../input/source ../input/groundTruth ../input/mask 1 2 1 1 2 1 -0.1 0.1 0.05 15 21
 ```
