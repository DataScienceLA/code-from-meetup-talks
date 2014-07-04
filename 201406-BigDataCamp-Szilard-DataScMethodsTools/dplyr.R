library(devtools)
install_github("babynames")

library(dplyr)
library(babynames)
library(ggplot2)
d <- tbl_df(babynames)

head(d)
nrow(d)

d %>% filter(year==2000, sex=="F") %>% arrange(desc(prop)) 
d %>% filter(year==1950, sex=="F") %>% arrange(desc(prop)) 
d %>% filter(year==1900, sex=="F") %>% arrange(desc(prop)) 
d %>% filter(year==2000, sex=="F") %>% arrange(desc(prop)) %>% select(-n)
d %>% filter(year==2000, sex=="F") %>% arrange(desc(prop)) %>% mutate(pc = prop*100)
d %>% filter(year==2000, sex=="F") %>% arrange(desc(prop)) %>% mutate(p_csum = cumsum(prop))
d %>% filter(year==2000, sex=="F") %>% arrange(desc(prop)) %>% mutate(rnk = row_number(desc(prop)))
d %>% filter(year==2000, sex=="F") %>% summarize(p_sum = sum(prop))
d %>% group_by(year, sex) %>% summarize(p_sum = sum(prop))

d %>% group_by(year, sex) %>% filter(row_number(desc(prop))<=20) %>% summarize(p_sumtop = sum(prop))

d %>% group_by(year, sex) %>% filter(row_number(desc(prop))<=20) %>% summarize(p_sumtop = sum(prop)) %>%
ggplot() + geom_line(aes(x=year, y=p_sumtop, color=sex, ymin=0))

d %>% group_by(year, sex) %>% filter(row_number(desc(prop))<=20) %>% summarize(p_sumtop = sum(prop)) %>%
  qplot(year, p_sumtop, color=sex, data=., geom="line")

d %>% group_by(year,sex) %>% filter(row_number(desc(prop))<=20) %>% summarize(p=sum(prop)) %>% 
  qplot(year,p,color=sex,data=.,geom="line")

