```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(tidy.opts=list(width.cutoff=50),tidy=TRUE)
library(knitr)
library(kableExtra)
library(stargazer)
library(plotly)
library(tidyverse)
library(car)
library(ggplot2)
library(wooldridge)
data(alcohol)
```

# Introduction 

## Why study this?
In the United States, approximately [13% of the American adult population](https://jamanetwork.com/journals/jamapsychiatry/fullarticle/2647079) abuses alcohol as of 2012. In fact, many state governments have tried to use economic policies to potentially decrease binge brinking, alcohol related death and injuries, and on paper, overall alcohol consumption. According to researchers from the National Center for Biotechnology Information, the general reported elasticities between the price of alcohol and binge drinking ranged from −0.29 to −1.29. 
Additionally, a recent study by the University of Florida also found that the general reported price elasticities were -0.46 for beer, -0.69 for wine and -0.80 for spirits. Therefore, increasing tax or the price on alcohol can decrease overall consumption since people are extremely price sensitive to alcohol. 

In this research project, I examine how basic social demographics and changes in taxes on alcohol affect alcohol consumption. I am particularly interested by the relationship between tax policy and alcoholism, especially given the high rates of alcoholicism and binge drinking in the United States. My general knowledge of this phenomenona is that states in the U.S. where alcohol taxes are lower have relatively higher rates of alcohol consumption which can be synonymous to higher rates of alcoholism amongst the U.S. population. 

For the analysis in this research project, the primary methods that I am going to use are linear regression models and hypothesis testing. My regression models will have the state per capita alcohol consumption (in gallons of alcohol) as the dependent variable. The four independent variables I have choosen for my linear regression models include the years of education of sampled individuals, beer tax in dollars per gallon, the unemployment rate of the sampled individual's state, and the sampled individual's alcohol abuse status. 

## Visualizations from Previous Studies 
Below are three visualizations from previous studies that show the relationship between alcohol tax, binge drinking prevalence in the U.S. and Finland. 

* **Beer Tax vs. Binge Drinking Prevalence in 2001 and 2010 across the 50 US States**

![Image Description](Directory Path){width=200px}

* **Map Plot of Alcohol Taxes across the United States as of 2016**

![Image Description](Directory Path){width=625px}

* **Time-Series Plot of Alcohol Consumption Trends in Relation to Alcohol Taxes in Finland (1960-2005)**

![Image Description](Directory Path){width=650px}

## Visualizations from my Dataset

### Beer Taxes between Abusers and Non-Abusers of Alcohol

This visual model presents possible visual differences on beer taxes between individuals who do/do not abuse alcohol. As we can see from the boxplot below, there doesn't seem to be any visual difference in the average  beer tax between individuals who abuse and don't abuse alcohol. However, if you look closely, there seems to be a range of slightly lower outliers of beer taxes for individuals who abuse alcohol, but this doesn't explain much. 
```{r}
ggplot(alcohol,aes(group=abuse, y=beertax)) + geom_boxplot(alpha=.45,color="red")+ggtitle("Beer Tax vs. Abusers/NonAbusers of Alcohol")+xlab("Left Box=Does Not Abuse Alcohol        Right Box=Abuses Alcohol")+ylab("Beer Tax ($ per gallon)") #geom_boxplot creates a boxplot that creates different groups or in this case, abusers and nonabusers

```


### Preliminary Linear Regression Plot of Years of Education vs. State per Capita Alcohol Consumption 

From this preliminary linear model plot, we can see that there is a slightly positive relationship between an increase in level of education amongst individuals in this sample against per capital alcohol consumption. At this moment, we can unofficially claim that an additional year of education slightly increases the state per capita alcohol consumption. This phenomenon is quite uncommon.  
```{r}
p <- ggplot(alcohol, aes(educ, ethanol))+geom_point(color="red") +geom_smooth(method='lm')+ ggtitle('Education vs. State per Capita Alcohol Consumption ')+ xlab('Years of Education of Sampled Individuals')+ylab('State Per Capita Alcohol Consumption (in gallons)')
ggplotly(p) #installing plotly into my R always to make my visualizations interactive, click on the table to see summary stats
#In ggplot, I listed to my dataset and proceed within aes() to first list my independent variable, and then my dependent variable. I then list the color of my datapoint to red. method="lm" creates a linear model in my ggplot function between my dependent (beer tax) and independent (educ) variables. ggtitle, xlab, and ylab create labels for my dataset. The labels must be in quotations for the code to run. 
```

### Preliminary Linear Regression Graph of Beer Tax vs. State per Capita Alcohol Consumption

From this preliminary model, we can see that there is a negative relationship between an increase in beer tax and state per capita alcohol consumption in this dataset. At this moment, we can unofficially claim that a higher beer tax decreases state per capita alcohol consumption. This phenomenon corresponds to the negative price elasticities of binge drinking and taxes on alcohol from the study discussed in the introduction.
```{r}
x <- ggplot(alcohol, aes(beertax,ethanol))+geom_point(color="red") +geom_smooth(method='lm')+ ggtitle('Beer Tax vs. State per Capita Alcohol Consumption')+ ylab('State Per Capita Alcohol Consumption')+xlab('Beer Tax ($ per Gallon)') #method="lm" creates a linear model between my dependent (beer tax) and independent (educ) variables. 
ggplotly(x)
```


# The Data 
In this section, I will introduce the variables of interest in this data set which will be used in this research paper. These are variables of interest are my independent variables and my dependent variable that I described in my introduction. This dataset is a cross sectional dataset which means this data was collected at a specific moment in time. 


## Structure of the Data
This dataset contains 10 numerical variables and the rest of the 23 variables can be considered binary and/or categorical variables. For example, mothalc is a binary variable which can only equal 0 or 1. In this context, 1 means the person had an alcoholic mother and 0 means the person did not have an alcoholic mother. Another categorical variable is status, where 1 means the person is out of the work force, 2 means unemployed, and 3 means employed. Numerical variables include education (which indicates the number of years of education for each sampled individual), beer tax (the tax of beer in dollars per gallon), and ethanol (the state per capita consumption of hard alcohol in gallons). 
```{r}
str(alcohol) #The code str() displays the structure of my dataset and defines my numerical variables as num and my binary categorical variables as int with values only equal to 0 or 1. Other categorical variables can have a certain integer range such status.  
```

## Summary of Population of Study
Below includes a summary table and a proportion table of the dataset regarding my variables of interest. 

From the summary table and proportion table of abuse status, we can see that:

The population of study includes 9,822 individuals between the ages of 25 and 59. Therefore, we will be focusing on middle age adults and adults with various levels of education who are the population of study in this dataset. The average age of the sampled population in this study is approximately 39 years old. 

The average of years of education of individuals in this dataset is approximately 13 years of education, the equivalent of a high school education. The maximum years of education of sampled individuals is 19 years of education. 

The average beer tax is 43 U.S. cents per gallon of beer and the maximum beer tax is 2.37 U.S. dollars per gallon of beer. 

The average unemployment rate for where sampled individuals live is 5.57% and the maximum unemployment rate for where sampled individuals live is 11%. 

The average state per capita alcohol consumption (ethanol) for where sampled individuals live is 2.04 gallons of hard alcohol per individual and the maximum state per capita alcohol consumption for where sampled individuals live is 4.02 gallons of hard alcohol per individual.

Only ~10% of the sampled adults between the ages of 25 and 59 report that they abuse alcohol and 90% report that they don’t abuse alcohol. This percentage is fairly representative of the U.S. population from previous studies listed.

```{r,results="asis"}
Summary1 <- alcohol %>% select(age,beertax,educ,unemrate,ethanol) #using the pipe function allows me to filter out two variables of interest in my dataset
stargazer(as.data.frame(Summary1), type = "html", digits =2, title="Summary of the Age, Beer Tax Rates, Years of Education, and Unemployment Rate of Sampled Individuals") #stargazer allows me to create nice summary table of both the variables age,beertax, years of education, and per capita alcohol consumption (ethanol) we do this summary by creating label as as.data.frame
```

```{r}
abusestatus <- factor(alcohol$abuse,labels=c("doesn't abuse alcohol","abuses alcohol")) #Generating the function "factor" attaches labels to my categorical and binary variables, the $ also allows us to factor one particular variable of the dataset. I can then create an object from this vector and include it in other functions to make tables. labels also assigns categories to my binary categorical variables.
kable((ccountstab <- prop.table(table(abusestatus)))) %>% kable_styling(bootstrap_options = "striped", full_width = F, font_size = 14) %>%  add_header_above(c("Percentage of Alcohol Abusers and Non-Alcohol Abusers" = 2)) %>%
  row_spec(0, background = "lightblue") %>%
  row_spec(1:2, background = "lightyellow") #prop.table creates a table of proportions/percentages between variables of interest chosen in this dataset, with the packages of kabledetail and kable I create a neater table with color blocks, titles, and row and column names
```

## Proportion Tables of Alcoholism by Social Demographics


### Abuse Status and State per Capita Alcohol Consumption
As seen from the contigency table below, the highest proportion of alcohol and non-alcohol abusers are individuals from states in the second ranking subgroup of per capita alcohol consumption (between 1.78 and 2.58 gallons of alcohol consumed per resident). The lowest proportion of alcohol abusers and non-alcohol abusers are individuals from states in the highest subgroup of per capita alcohol consumption (between 3.28 and 4.02 gallons of alcohol consumed per resident). Therefore, it seems that the majority states where sampled individuals live have per capita alcohol consumptions between 1.78 and 2.53 gallons. This table doesn't seem to help that much.
```{r}
cutpts <- c(1.03,1.78,2.53,3.28,4.02)
# Create factor variable containing ranges for the rank use function cut()
alcohol$percap <- cut(alcohol$ethanol, cutpts)
consumption <- factor(alcohol$percap,labels=c("Per Capita Alcohol Consumption between 1.03 and 1.78 gallons","Per Capita Alcohol Consumption between 1.78 and 2.53 gallons","Per Capita Alcohol Consumption between 2.53 and 3.28 gallons","Per Capita Alcohol Consumption between 3.28 and 4.02 gallons")) #Generating the function "factor" attaches labels to my categorical and binary variables, the $ also allows us to factor one particular variable of the dataset. I can then create an object from this vector and include it in other functions to make tables. labels also assigns categories to my binary categorical variables.

kable((countstab <- prop.table(table(consumption,abusestatus))))  %>% kable_styling(bootstrap_options = "striped", full_width = F, font_size = 14) %>%  add_header_above(c('',"State per Capita Alcohol Consumption by Abuse Status" = 2)) %>%
  row_spec(0, background = "lightblue") %>%
  row_spec(1:4, background = "lightyellow") %>% column_spec(1,background="lightgreen") #prop.table creates a table of proportions/percentages between variables of interest chosen in this dataset, with the packages of kabledetail and kable I create a neater table with color blocks, titles, and row and column names
```


### Beer Tax and State per Capita Alcohol Consumption
As seen from the contigency table below, the first group for individuals who live in states where the beer tax is between 5 cents and $1.21 US dollars have the highest proportion in the second  subgroup with a per capita alcohol consumption (between 1.78 and 2.53 gallons of alcohol consumed per individual) and the lowest proportion in the third subgroup with a per capita alcohol consumption (between 2.53 and 3.28 gallons of alcohol consumed per individual). The second group for individuals who live in states where the beer tax is between 1.21 and 2.37 US dollars have the highest proportion in the lowest subgroup of per capita alcohol consumption (between 1.03 and 1.78 gallons of alcohol consumed per individual) and the lowest proportion in the highest subgroup with a per capita alcohol consumption (between 3.28 and 4.02 gallons of alcohol consumed per individual). This shows potential evidence that states where higher beer taxes exist have lower proportions of people that consume higher amounts of alcohol.
```{r}
cutpts1 <- c(.05,1.21,2.37)
# Create factor variable containing ranges for the rank use function cut()
alcohol$BeerTaxRate <- cut(alcohol$beertax, cutpts1)
beertaxrate<- factor(alcohol$BeerTaxRate,labels=c("Beer Tax between 5 cents and $1.21 U.S. dallars per gallon","Beer Tax between $1.21 and $2.37 U.S. dallars per gallon"))
kable((countstab <- prop.table(table(consumption,beertaxrate))))  %>% kable_styling(bootstrap_options = "striped", full_width = F, font_size = 14) %>%  add_header_above(c('',"State per Capita Alcohol Consumption by Beer Tax" = 2)) %>%
  row_spec(0, background = "lightblue") %>%
  row_spec(1:4, background = "lightyellow") %>% column_spec(1,background="lightgreen")
```

### Level of Education and State per Capital Alcohol Consumption
As seen from the contigency table below, all of the proportions across all levels of per capita alcohol consumption for the group of individuals with 9.5 to 19 years of education are higher than the proportions for those with 0 to 9.5 years of education. These proportions suggest that higher levels of education potentially have a relationship with higher alcohol consumption and that the majority of individuals sampled have an average educational level greater than 9.5 years. 
```{r}
cutpts2 <- c(0,9.5,19)
# Create factor variable containing ranges for the rank use function cut()
alcohol$YearsofEduc <- cut(alcohol$educ, cutpts2)
# Display frequencies using table and kable
yearsofeduc <- factor(alcohol$YearsofEduc,labels=c("0 to 9.5 Years of Education","9.5 to 19 Years of Education"))
kable((countstab <- prop.table(table(consumption,yearsofeduc))))  %>% kable_styling(bootstrap_options = "striped", full_width = F, font_size = 14) %>%  add_header_above(c('',"State per Capita Alcohol Consumption by Level of Education" = 2)) %>%
  row_spec(0, background = "lightblue") %>%
  row_spec(1:4, background = "lightyellow") %>% column_spec(1,background="lightgreen")
```

### Unemployment Rate and State per Capita Alcohol Consumption
As seen from the contigency table below, all of the proportions across all levels of state per capita alcohol consumption for the group of individuals who live in states with unemployment rates between 3% and 7% are higher than the proportions for those who live in states with larger unemployment rates between 7% and 11%. These proportions suggest that higher rates of unemployment potentially have a relationship with lower alcohol consumption and that the majority of sampled individuals live in states where the unemployment is less than 7%. 
```{r}
cutpts3 <- c(3,7,11)
# Create factor variable containing ranges for the rank use function cut()
alcohol$UnemploymentRate <- cut(alcohol$unemrate, cutpts3)
# Display frequencies using table and kable
unemploymentrate <- factor(alcohol$UnemploymentRate,labels=c("Unemployment Rate between 3% and 7%","Unemployement Rate between 7% and 11%"))
kable((countstab <- prop.table(table(consumption,unemploymentrate))))  %>% kable_styling(bootstrap_options = "striped", full_width = F, font_size = 14) %>%  add_header_above(c('',"State per Capita Alcohol Consumption by Unemployment Rate" = 2)) %>%
  row_spec(0, background = "lightblue") %>%
  row_spec(1:4, background = "lightyellow") %>% column_spec(1,background="lightgreen")
```

# Methodology 
In this research paper, I will investigate how taxes on alcohol and social demographic indicators including years of education,beer taxes, unemployment rates, and alcohol abuse status affect state per capita alcohol consumption. This research question is based on the economic model that increasing taxes encourages savings and decreases consumption. 

In the case of this particular dataset, we can apply this economic model to understand how education, beer taxes,  unemployment rates, and alcohol abuse status influence state per capita alcohol consumption. The econometric model of this study thus far will be that an increase in education, a decrease in beer tax, a decrease in unemployment rate, and a positive alcohol abuse status (abuse=1) will make state per capita alcohol consumption increase. 

This is my specification because previous research studies have shown price elasticies on alcohol amongst the American population are negative and that my preliminary model in my introduction illustrates there is a slightly visible positive relationship between education and state per capita alcohol consumption and a visible negative relationship between beer tax and state per alcohol consumption. The contigency tables in the data section also show that the proportion of individuals living in states with lower unemployment rates and individuals with higher levels of education have a potential relationship with higher levels of state per capita alcohol consumption.

In the section below, I present my regression models. 

## Regression Models

### Model 1 
My first model includes only years of education of sampled individuals across the U.S. 50 states, and the beer tax in each of the U.S. states.
<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">
$Model1$
$$alcoholconsumption=\beta_0 + \beta_1education - \beta_2beertax+u$$
</div>
<br>

### Model 2
My second model includes only years of education of sampled individuals across the U.S. 50 states, the beer tax in each of the U.S. states, and the unemployment rate.
<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">
$Model2$
$$alcoholconsumption=\beta_0 + \beta_1education - \beta_2beertax-\beta_3urate+u$$
</div>
<br>

### Model 3
My third model includes years of education of sampled individuals across the U.S. 50 states, the beer tax in each of the U.S. states,the unemployment rate, and alcohol abuse status.
<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">
$Model2$ 
$$alcoholconsumption=\beta_0 + \beta_1education - \beta_2beertax-\beta_3urate+\beta_4abusesalcohol+u$$
</div>
<br>

### Model 4
My fourth model includes years of education of sampled individuals across the U.S. 50 states, the beer tax in each of the U.S. states, the unemployment rate, alcohol abuse status, and the interaction between years of education and unemployment rate.
<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">
$Model4$
$$alcoholconsumption=\beta_0 + \beta_1education - \beta_2beertax-\beta_3urate+\beta_4abusesalcohol+\beta_5education*urate+u$$
</div>
<br>

### Model 5
My fifth model includes years of education of sampled individuals across the U.S. 50 states, the beer tax in each of the U.S. states, the unemployment rate, alcohol abuse status, and the interaction between alcohol abuse status and unemployment rate.
<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">
$Model5$
$$alcoholconsumption=\beta_0 + \beta_1education - \beta_2beertax-\beta_3urate+\beta_4abusesalcohol+\beta_5abusesalcohol*urate+u$$
</div>
<br>

# Regression Analysis
The following analysis below includes the summary results of the five regression models.

## Regression Results 
```{r,results='asis'}
# run the regression analysis for the five models stated above using the lm function
model1 <- lm(ethanol~educ+beertax,data=alcohol)
model2 <- lm(ethanol~educ+beertax+unemrate,data=alcohol)
model3 <- lm(ethanol~educ+beertax+unemrate+abuse,data=alcohol)
model4 <- lm(ethanol~educ+beertax+unemrate+abuse+I(educ*unemrate),data=alcohol)
model5 <- lm(ethanol~educ+beertax+unemrate+abuse+I(abuse*unemrate),data=alcohol)

# output the stargazer table that summarizes the results of all these four regression models, the stargazer package is useful making a neat table and it is used by many academic journals
stargazer(list(model1, model2, model3, model4,model5), 
          title= "Summary of the Results of the Five Regression Models", align=TRUE,
          covariate.labels = c("Years of Education", "Beer Tax", "Unemployment Rate","Abuses Alcohol","Years of Education*Unemployment Rate", "Abuses Alcohol*Unemployment Rate"),
          column.labels = c("Model 1", "Model 2", "Model 3", "Model 4","Model 5"),
          dep.var.caption  = "<em> Dependent variable: </em>",
          dep.var.labels   = "Per Capita Alcohol Consumption", 
          out = "reg_table.html", type="html")
```

## Checking for Multicollinearity
The following tables below include the VIFs for each independent variables and interaction terms in models 3,4, and 5. 
```{r}
#Check the vif(variance inflation factor) of models 2,3 and 4 to see if any multicollinearity problems exist
vif_3 <- vif(model3)
v3 <- data.frame(vif_3,row.names = c("Years of Education","Beer Tax","Unemployment Rate","Abuses Alcohol"))

vif_4 <- vif(model4)
v4 <- data.frame(vif_4,row.names=c("Years of Education","Beer Tax","Unemployment Rate","Abuses Alcohol","Years of Education*Unemployment Rate"))
vif_5 <- vif(model5)
v5 <- data.frame(vif_5,row.names=c("Years of Education","Beer Tax","Unemployment Rate","Abuses Alcohol","Beer Tax*Unemployment Rate"))

# output tables to show the variance inflation factors for these three regression models
# here I also used the function kable in the knitr package to print these tables. I also used the package kableExtra to make these tables more lively
kable(v3, col.names="VIF", digits=3) %>% kable_styling(bootstrap_options = "striped", full_width = F, font_size = 14) %>% add_header_above(c("Model 3 VIFs" = 2)) %>% row_spec(0, background = "lightgreen") %>% row_spec(1:4, background = "lightblue")
kable(v4, col.names="VIF", digits=3) %>% kable_styling(bootstrap_options = "striped", full_width = F, font_size = 14) %>% add_header_above(c("Model 4 VIFs" = 2)) %>% row_spec(0, background = "lightgreen") %>% row_spec(1:5, background = "lightblue")
kable(v5, col.names="VIF", digits=3) %>% kable_styling(bootstrap_options = "striped", full_width = F, font_size = 14) %>% add_header_above(c("Model 5 VIFs" = 2)) %>% row_spec(0, background = "lightgreen") %>% row_spec(1:5, background = "lightblue")
```
By looking at the VIF(Variance Inflation Factor) tables for Models 3, 4 and 5, we can derive some conclusions about multicollinearity in the regression models.

<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">
<p style="text-align:left;">
In Model 3, all the VIFs for the independent variables are smaller than 10. Therefore, no multicollinearity problem exists in model 3.

In Model 4, the VIF for the variable Years of Education is 13.453, the VIF for variable Unemployment rate is 19.483 and the VIF for the interaction term Years of Education*Unemployment Rate is 30.922. These three VIFs are larger than 10. Therefore, a multicollinearity problem exiss in model 4. 

In Model 5, the VIF for the variable Abuses Alcohol is 14.438 and the VIF for the interaction term Beer Tax*Unemplomyment Rate is 14.518. These two VIFs are larger than 10. Therefore, a multicollinearity problem exists in model 5.

Because of the multicollinearity problem, Models 4 and 5 may not be useful for further regression analysis. Instead, since the VIFs in Model 3 are all small, the results of the estimated coefficients in Model 3 will be useful for interpreting the effects of these three independent variables (Years of Education, Beer Tax, and Alcohol Abuse) on our dependent variable (state per capita alcohol consumption).
</div>
<br>

## Intrepretation of Regression Results 
According to the results summarized in the above stargazer table for the regression models, we can get the following interpretation of the estimated coefficients of independent variables.


<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">
<p style="text-align:left;">
With respect to Model 3 and holding all other factors fixed, an additional year of education is associated with around a 0.64 ounce increase in per capita alcohol consumption.

With respect to Model 3 and holding all other factors fixed, an additional dollar on beer tax is associated with around a 17.024 ounce (approx. 2 cups) decrease in state per capita alcohol consumption. 

With respect to Model 3 and holding all other factors fixed, a one percent increase in the unemployment rate is associated with approximately an 8 ounce (1 cup) decrease in state per capita alcohol consumption. This is quite uncommon because typically unemployment, depression, alcohol abuse, and alcohol consumption are usually correlated.

With respect to Model 3 and holding all other factors fixed, a person who abuses alcohol has a  state per capita alcohol consumption of 6.52 ounces higher than a person who does not abuse alcohol. 
</div>
<br>

# Inference Analysis 
Below I include the t-values of Model 3 to visualize whether there is statistical significance in any of the  explanatory variables.

## The T-Tests
The t-test shows at which level of significance we can reject the null hypothesis that a variable in the above model is equal to 0, meaning that it has no expected impact on the state per capita alcohol consumption.

The t-tests and p-values for the variables for Model 3 are below. The critical t-value is positive and negative +/-1.96 given our degrees of freedom are 9,817 and our alpha is 0.05. 
```{r,results='asis'}
# output the stargazer table that summarizes the results of all these three regression models, the stargazer package is useful making a neat table and it is used by many academic journals
stargazer(summary(model3)[["coefficients"]][, "t value"],align=TRUE, 
    type = "html", title = "Model 3: t-values")
stargazer(summary(model3)[["coefficients"]][, "Pr(>|t|)"],align=TRUE, 
    type = "html", title = "Model 3: Pr(>|t|)")

```



<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">
<p style="text-align:left;">
All the independent variables that include years of education, beer tax, unemployment rate, and abuse status are significant at the 0.05% level. All of their critical values are greater and less than +/-1.96 and their p-values are less than 0.025. Therefore, we reject the null hypothesis that these parameters are equal to zero. 
</div>
<br>

## The F Test
For this F test, the null hypothesis and the alternative hypothesis are:


<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">
<p style="text-align:left;">
$Ho:\beta3=0$, $\beta4=0$ and $Ha:$ at least one of them is not equal to 0.
</div>
<br>

```{r}
myTestVar <- c("unemrate","abuse") # vector with the names of the variables that I am testing
linearHypothesis(model3, myTestVar)
```
According to the above outputs which show the consistent results by this method, the F statistic is 372.18 and the corresponding p-value is around 0. Because the p-value is very small and is much smaller than our default significance level of 0.05, we **reject the null hypothesis** and conclude that at least one of the population parameters $\beta_3$ or $\beta_4$ are not equal to 0. Therefore, the variables unemployment rate and alcohol abuse status, have jointly significant effects on state per capita alcohol consumption.

# Conclusions
In this project, I used the data set called “alcohol” with 9,822 observations to analyze the potential effects of the average years of education of sampled individuals, the beer taxes and unemployment rates across the 50 U.S. states, and alcohol abuse status on state per capita alcohol consumption. By running the regression analysis and performing the inference tests, I derived the conclusions that the variables years of education, and a status of current alcohol abuse are positively correlated with state per capita alcohol consumption. I've also derived that beer tax and strangely enough, unemployment rate are negatively correlated with state per capita  alcohol consumption. In other words, all of these four variables are statistically significant in explaining the variation in state per capita alcohol consumption. I hope this project can further provide information to policy makers who wish to use alcohol taxes as a strategy to curb alcoholism, binge drinking, and high alcohol consumption. 


# References to Previous Studies

[Effectiveness of Tax Policy Interventions for Reducing Excessive Alcohol Consumption](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3735171/)

[Effects of beverage alcohol price and tax levels on drinking (University of Florida): a meta-analysis of 1003 estimates from 112 studies](https://www.ncbi.nlm.nih.gov/pubmed/19149811/)

[The relationship between alcohol taxes and binge drinking: evaluating new tax measures incorporating multiple tax and beverage types](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4441276/)

[Prevalence of 12-Month Alcohol Use, High-Risk Drinking, and DSM-IV Alcohol Use Disorder in the United States, 2001-2002 to 2012-2013](https://jamanetwork.com/journals/jamapsychiatry/fullarticle/2647079)

[Recorded alcohol consumption trends in Finland and main policy measure changes (1960–2005)](https://www.researchgate.net/figure/Recorded-alcohol-consumption-trends-in-Finland-and-main-policy-measure-changes_fig1_51237812)

&nbsp;
<hr />
<p style="text-align: center;">An ECON 320 Project by <a href="Insert Linkedin">Aleksei Kaminski</a></p>
<p style="text-align: center;">Emory University</a></p>
<p style="text-align: center;"><span style="color: #808080;"><em>attach email</em></span></p>

</p>

&nbsp;
