# TSCCA

### Introduction
In this study, we proposed a Tensor Sparse Canonical Correlation Analysis (TSCCA) method for identifying cancer-related miRNA-gene modules across multiple cancers. TSCCA can overcome the drawbacks of existing solutions and capture both the cancer-shared and specific miRNA-gene co-expressed modules with better biological interpretations. We comprehensively evaluated the performance of TSCCA using a set of simulated data and matched miRNA/gene expression data across 33 cancer types from the TCGA database. Experimental results demonstrate that TSCCA is superior to related methods for detecting biologically meaningful modules. These modules can advance our understanding of the regulatory mechanisms of cancer and provide evidence for developing miRNA treatment of cancer.

More descriptions about these functions can be found in their annotation part.

<p align="center"> 
<img src="https://github.com/wenwenmin/TSCCA/blob/master/TSCCA.png">
</p>

### R code
Note that before running the codes, please first set the path for "Fun2_simulation_study_main.R".
Please run the following R command in the Console. 

``` r
> source('Fun2_simulation_study_main.R') 
```

### TCGA data 
We comprehensively evaluate the performance of TSCCA using a set of simulated data and matched miRNA/gene expression data across 33 cancer types from the TCGA database.
<p align="center"> 
<img src="https://github.com/wenwenmin/TSCCA/blob/master/Fig_tcga_data_table.png">
</p>


### References
<table class="docutils footnote" frame="void" id="id2" rules="none">
<colgroup><col class="label" /><col /></colgroup>
<tbody valign="top">
<tr><td class="label"><a class="fn-backref" href="#id2">[1]</a></td><td> 
Wenwen Min, Tsung-Hui Chang, Shihua Zhang and Xiang Wan. TSCCA: A tensor sparse CCA method for detecting microRNA-gene patterns from multiple cancers. PLOS Computational Biology (Revision). 
</td></tr>
</tbody>
</table>
