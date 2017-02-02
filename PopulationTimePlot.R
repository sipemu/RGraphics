bmt <- read.csv("https://raw.githubusercontent.com/sahirbhatnagar/casebase/master/inst/extdata/bmtcrr.csv")
devtools::install_github("sahirbhatnagar/casebase")
library(casebase)
obj <- popTime(bmt, time = "ftime")

obj %>% 
  dplyr::filter(event == 1) %>% 
  dplyr::select(time, yc) %>% 
  dplyr::rename(y = time,
                x = yc) -> df

library(highcharter)
hchart(obj, "bar", hcaes(x = ycoord, y = time), color = "#00aacc", borderColor = "#00aacc", name = "At-risk person-time") %>% 
  hc_add_series(data = list_parse(df), type = "scatter", color = "#b90000", marker = list(radius = 3), name = "Event") %>% 
  hc_yAxis(reversed = F, title = list(text = "Follow-up Time"))  %>% 
  hc_xAxis(reversed = F, title = list(text = "Population")) %>% 
  hc_tooltip(headerFormat = '<span style="font-size: 10px">{series.name}</span><br/>',
             pointFormat  = 'At-risk person-time: <b>{point.y}</b><br/>') %>% 
  hc_title(text = "POPULATION TIME PLOTS")
