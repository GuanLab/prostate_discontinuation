# Predicting Discontinuation for Prostate Cancer Patients with Docetaxel Treatment
This is the codes for the winning solution of 2015 Prostate Cancer DREAM Challenge. In this solution, we integrate the information of death, treatment and discontinuation, and build a new responser for fitting the random forest base learner. 78 features are included in our model  

Background & source data: [DREAM9.5 - Prostate Cancer DREAM Challenge](https://www.synapse.org/#!Synapse:syn2813558/wiki/)

Solution see also: [Yuanfang Guan's winning solution](https://www.synapse.org/#!Synapse:syn7152438/wiki/403154)  

Please contact (gyuanfan@umich.edu or dengkw@umich.edu) if you have any questions or suggestions.
<p align="left">
  <img src="https://github.com/nonztalk/prostate_discontinuation/blob/master/img/Workflow.png" width="700">
</p>

## Data Summary
The raw data were collected from the provider-deidentified comparator arm datasets of phase III prostate cancer clinical trial, including ASCENT2 (ASC) from Memorial Sloan Kettering Cancer Center, with 105 patients discontinuing docetaxel due to adverse event or possible adverse event 35, CELGENE (CEL) from Celgene, with 41 discontinued patients 36, and EFC6546 (VEN) from Sanofi, with 51 discontinuations. The raw data won't include in this repository because of privacy consideration. We only upload the features we selected and their importance maps in the `data` directory.

**Basic Information**

|                    | ASCENT2 (ASC) | CELGENE (CEL) | EFC6546 (VEN) |  
|:--------------------:|:---------------:|:---------------:|:---------------:|  
| # Sample           | 476           | 526           | 598           |  
| Median age (years) | 71            | 68            | 68            |  

**Discontinuation Status**  

|                                | ASCENT2 (ASC) | CELGENE (CEL) | EFC6546 (VEN) |
|:-------------------------------------:|:-------------:|:-------------:|:-------------:|
|           % Discontinuation           |     22.05     |      7.79     |      8.52     |
| Median time to discontinuation (days) |     153.0     |     211.0     |     202.5     |
|   % Discontinuation records missing   |      0.00     |     18.06     |      0.00     |

**Death Status**

|                      | ASCENT2 (ASC) | CELGENE (CEL) | EFC6546 (VEN) |
|:---------------------------:|:-------------:|:-------------:|:-------------:|
|           % Death           |     28.99     |     17.49     |     72.41     |
| Median time to death (days) |     357.0     |     279.0     |     642.5     |

**Treatment Status**

|               Cohorts              | ASCENT2 (ASC) | CELGENE (CEL) | EFC6546 (VEN) |
|:----------------------------------:|:-------------:|:-------------:|:-------------:|
|                % AE                |      9.03     |     13.31     |     21.07     |
|            % Possible AE           |     46.85     |     45.24     |     22.24     |
|            % Progression           |     19.96     |     21.29     |     55.68     |
|             % Complete             |     24.16     |      0.00     |      0.17     |
| % Treatment status records missing |      0.00     |     20.15     |      0.84     |

## Code Summary
The codes for data manipulation and model construction are written in R Markdown files: `OriginDataProcess.Rmd` and `PaperMainCode.Rmd`, including the plots and the results for paper revision. The other R files are the helper functions: `theme_self.R` and `grid_arrange_share_legend.R` are used to customize the figure styles; `kFoldCV_BaseLearner.R` and `kFoldCV_GoldStandard.R` are used to perform the 5-folds cross-validation for selecting base learner and gold standard; `modelFit.R` is used to fit different types of base learners conveniently.
