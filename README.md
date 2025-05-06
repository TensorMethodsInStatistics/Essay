# Tensor Methods in Statistics Essay

All the codes used to implement the different algorithms and produce the results found in the Tensor Methods in Statistics Essay may be found in this repository. For examples 1 and 2, we used R and the ```.Rmd``` files may be run in RStudio. For the tensor completion examples we found it convenient to use MATLAB to utilise the existing SiLRTCnr. We also implemented the DR-TC algorithm from [4] in MATLAB. This document explains which codes are borrowed (not written for this essay) and which section of the essay each file in this repository corresponds to, along with a short description of the purpose of each file.  

The codes found inside the folder [mylib](mylib) and the file [SiLRTCnr.m](SiLRTCnr.m) are borrowed codes originally written for [6], implementing the SiLRTCnr algorithm. They are both included in this repository for convenience and were obtained from the following [Github repository](https://github.com/Kaimaoge/Tensor-decomposition-completion-and-recovery-papers-and-codes).   

For this essay, I made use of codes in the following repository: [tensor_toolbox](https://gitlab.com/tensors/tensor_toolbox) [3]. To use the functions in the Tensor Toolbox, I downloaded the entire repository as a ```.zip``` file and extracted it. This creates a folder ```tensor_toolbox-dev```. Please ensure that this folder is present in the Current Folder of the MATLAB session (which should be the root folder of this repository) before running the codes and that the folder name remains unchanged (```tensor_toolbox-dev```) as it is referred to in several addpath commands.

## Tensor Decompositions

### Example 1 (CP or PCA for clustering)

- [CPvsPCA.Rmd](CPvsPCA.Rmd) contains codes for Example 1. We use the quantmode package [2] in R to retrieve the stock data and the rTensor package [1] to compute the CP decompositions of the tensor.

### Example 2 (Compression)

- [TUCKERvsSVD.Rmd](TUCKERvsSVD.Rmd) contains codes for Example 2. Here we again use rTensor [1] to compute the Tucker decompositions.

### Example 3 (Recovery of Low Rank Image)

The images used in this example may be found in the [Images](Images) folder. The [Jellybeans](Images/jellybeans.png), [Baboon](Images/baboon.png), [Car](Images/housecar.png) and [Peppers](Images/peppers.png) images were obtained from [The USC-SIPI Image Database](https://sipi.usc.edu/database/). The [Gauss](Images/Gauss.jpg) was obtained [here](https://en.wikipedia.org/wiki/Carl_Friedrich_Gauss). All remaining images were either taken or produced by the author of the essay.

- [LowRankApproximation.m](LowRankApproximation.m) contains codes for the Low Rank Recovery using both Tucker Decomposition and SVD. We use the Tensor Toolbox [3] to compute the Tucker decompositions of the images.

## Tensor Completion and Low-n-rank Tensor Recovery

### 4.5 Numerical Experiments for Tensor Completion

[data.mat](data.mat) is the Monkey Brain Machine Interface dataset from [5].  
[stemcell_post_trans.mat](stemcell_post_trans.mat) is the Stem Cell dataset used the tensor completion numerical experiment. The raw data may be found [here](Post-transplant%20data_anonymised.xlsx) and the pre-processing is done in [TensorProcessingFinal.Rmd](TensorProcessingFinal.Rmd).

- [CompletionSynthetic.m](CompletionSynthetic.m) contains the codes for Tensor Completion on synthetic data. We use the Tensor Toolbox [3] to generate synthetic low-rank tensors.
- [DR_TR_monkey.m](DR_TR_monkey.m) contains the codes for the implementation of Douglas-Rachford Tensor Completion and SiLRTCnr on the Monkey BMI dataset [5].
- [DRTR_NHS.m](DRTR_NHS.m) contains the codes for SiLRTCnr and DRTC on the Stem Cell dataset.

Our implementation of the Douglas-Rachford Tensor Completion algorithm from [4] may be found in [DR_TR2.m](DR_TR2.m). Our implementation of the DRTC algorithm uses the [Pro2TraceNorm.m](mylib/Pro2TraceNorm.m) function found in the folder [mylib](mylib). This function implements the shrinkage operator efficiently.
[prox_f0.m](prox_f0.m) implements the proximal map of f0 used in [DR_TR2.m](DR_TR2.m).

### 4.7 Low-rank Tensor Completion on Images

The images used in this section may be found in the [Images](Images) folder.

[DRTRimage.m](DRTRimage.m) contains the codes for the DRTC and SiLRTCnr application to images: [Gauss](Images/Gauss.jpg) and [Cambridge University Logo](Images/camblogo3.png).

### 4.7.1 Evaluation of Low-rank Tensor Completion for Images

[ratioS_calculator.m](ratioS_calculator.m) contains the codes used to calculate the ratio S and the RSE for various images from [Images](Images) for Figure 11 in section 4.7.1. An interactive plot where you may see which image corresponds to each point in Figure 11 may be found [here](https://tensormethodsinstatistics.github.io/Essay/SvsRSE.html).

## References

[1] Li, J., Bien, J., and Wells, M. T. (2018). rTensor: An R Package for Multidimensional Array (Tensor) Unfolding, Multiplication, and Decomposition. Journal of Statistical Software, 87(10), 1–31. https://doi.org/10.18637/jss.v087.i10  
[2] Ryan, J. A., and Ulrich, J. M. (2024). quantmod: Quantitative Financial Modelling Framework. R package version 0.4.26. https://CRAN.R-project.org/package=quantmod  
[3] Brett W. Bader, Tamara G. Kolda and others, Tensor Toolbox for MATLAB, Version 3.6, www.tensortoolbox.org, September 28, 2023.  
[4] Gandy, S., Recht, B. and Yamada, I. (2011). Tensor completion and low-n-rank tensor recovery via convex optimization, Inverse problems, 27, 025010.
[5] T. G. Kolda, Monkey BMI Tensor Dataset, https://gitlab.com/tensors/tensor data monkey bmi, 2021.  
[6] Liu, J., Musialski, P., Wonka, P. and Ye, J. (2013). Tensor Completion for Estimating Missing Values in Visual Data. IEEE Transactions on Pattern Analysis and Machine Intelligence, 35(1), pp.208–220. doi:https://doi.org/10.1109/tpami.2012.39.  
