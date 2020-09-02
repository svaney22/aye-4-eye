# aye-4-eye

These two scripts have been provided in order to show possible ways to read in and statistically analyse historical sociolinguistic data,
using ctrees (conditional inference trees), random forests, and downsampling. The first script shows the application of ctrees and random forests to a
dataset of eighteenth century Scots and English words. This dataset (coded as datBigrf1) contains a number of genres, authors and other independent variables,
and the interest is in what conditions the use of Scots or English words (the dependent variable, coded as Scots_English). Using standard R packages ctree (under
partykit) and random forest (under ranger) a ctree and a random forest is grown from the data.

The second script was kindly provided by Dr Vica Papp, and demonstrates how to downsample a dataset before growing a random forest. In this case, a subset of the
data was used (coded as datBigrf2), in which we were interested in the language use of authors with known political sympathies only. They were coded as Pro(-Union),
Anti(-Union) or Unknown in this dataset (this refers to attitudes towards the Union of the Parliaments between Scotland and England in 1707). The latter authors were 
removed from the analysis. However, there were much less Scots tokens than English tokens in the corpus. The original dataset (datBigrf1) was already skewed towards the 
English tokens, and with the subset data the class imbalance became too high to achieve accurate statistical results. To address this, the subset first had to be downsampled, 
to reduce class imbalance and ensure the same frequency of Scots to English tokens, before a random forest could be grown off this data. A possible approach to this is 
demonstrated in the code, though no doubt there are other ways of achieving this.
