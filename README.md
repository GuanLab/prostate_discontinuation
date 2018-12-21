## Predicting Discontinuation for Prostate Cancer Patients with Docetaxel Treatment
This is the codes for the winning solution of 2015 Prostate Cancer DREAM Challenge. In this solution, we integrate the information of death, treatment and discontinuation, and build a new responser for fitting the random forest base learner. 78 features are included in our model  

Background & source data: [DREAM9.5 - Prostate Cancer DREAM Challenge](https://www.synapse.org/#!Synapse:syn2813558/wiki/)

Solution see also: [Yuanfang Guan's winning solution](https://www.synapse.org/#!Synapse:syn7152438/wiki/403154)  

Please contact (gyuanfan@umich.edu or dengkw@umich.edu) if you have any questions or suggestions.
<p align="left">
  <img src="https://github.com/nonztalk/prostate_discontinuation/blob/master/img/Workflow.png" width="700">
</p>

### Data Summary
Data were collected from the provider-deidentified comparator arm datasets of phase III prostate cancer clinical trial, including ASCENT2 (ASC) from Memorial Sloan Kettering Cancer Center, with 105 patients discontinuing docetaxel due to adverse event or possible adverse event 35, CELGENE (CEL) from Celgene, with 41 discontinued patients 36, and EFC6546 (VEN) from Sanofi, with 51 discontinuations.  

**Basic Information**   
|                    | ASCENT2 (ASC) | CELGENE (CEL) | EFC6546 (VEN) |  
|--------------------|---------------|---------------|---------------|  
| # Sample           | 476           | 526           | 598           |  
| Median age (years) | 71            | 68            | 68            |  

**Discontinuation Status**  
|                Cohorts                | ASCENT2 (ASC) | CELGENE (CEL) | EFC6546 (VEN) |
|:-------------------------------------:|:-------------:|:-------------:|:-------------:|
|           % Discontinuation           |     22.05     |      7.79     |      8.52     |
| Median time to discontinuation (days) |     153.0     |     211.0     |     202.5     |
|   % Discontinuation records missing   |      0.00     |     18.06     |      0.00     |

