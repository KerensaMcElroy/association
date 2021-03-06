library(tidyverse)
library(readxl)
library(janitor)

has_data <- function(c) {!all(is.na(c))}
meta <- read.table(file='data/2018-01-01_e-camal-assoc_samples.meta', sep='\t', header=TRUE)
#metadata from Shannon
path <- 'data/Deniliquin_Metrics.xlsx'
sheets <- lapply(excel_sheets(path), read_excel, path = path)

sheets <- lapply(sheets, function(sheet) sheet[rowSums(is.na(sheet)) <= 6,]) #weird excel analysis hack
sheets <- lapply(sheets, function(sheet) sheet[, colSums(!is.na(sheet)) != 0])

#from Andrew
lib_dates <- tibble('Plate' = 1:4, 'lib_date' = c('22082017', '29082017', '05092017', '12092017'))

#filenames - contains index data
fastq <- read_table('data/2018-01-01_e-camal-assoc_samples.files', col_names = FALSE)
colnames(fastq) <- 'files'
fastq <- fastq %>% 
  separate(col = 1, into = c('flowcell', 'lane', 'DT', 'CBY', 'UDF/Origin', 
                                         'index', 'R', 'sub.date', 'researcher', 'PM', 
                                         'M', 'read.pair'), sep = '_', remove = FALSE ) %>% 
  select_if(has_data) %>%
  mutate(DT = format(as.Date(DT, "%y%m%d"), format = "%d-%m-%Y")) %>%
  mutate(sub.date = format(as.Date(sub.date, "%d%m%Y"), format = "%d-%m-%Y"))  

#metadata supplied by garvan sequencing centre
garvan <- read_csv('data/R_171103_SHADIL_LIB2500_M001.csv', skip = 12) %>%
  select_if(has_data)%>% 
  mutate(index=str_match(`UDF/Index`, "\\((.*)\\)")[,2])

#merge
complete.data <- inner_join(fastq, garvan, by = 'index') %>%
  inner_join(sheets[[7]]) %>%
  left_join(sheets[[8]]) %>%
  left_join(lib_dates)%>%
  left_join(sheets[[9]], by = 'Capture') %>%
  add_column('PL'='illumina', 'CN'='Garvan', organism='Eucalyptus_camaldulensis') %>%
  clean_names(case = 'snake')

colnames(complete.data) <- sub('_x$','',colnames(complete.data))
colnames(complete.data) <- sub('u_l','ul',colnames(complete.data))
complete.data <- complete.data %>% 
  rename('sm' = 'udf_external_id', 'garvan_id' = 'sample_name') %>%
  mutate(lib_date= format(as.Date(lib_date, "%d%m%Y"), format = "%d-%m-%Y"))  


#print
meta.data <- select(complete.data, c('files', 'sm', 'index', 'lib_date', 
                                     'organism', 'garvan_id', 'udf_pool_id', 
                                     'cn', 'dt', 'pl', 'i7', 'i5', 
                                     'ng_ul_pre_covaris', 'ul_input_library',
                                     'ng_input_library', 'cycles_library',
                                     'ng_ul_final_library', 'well', 'plate',
                                     'capture', 'ul_input_mybait', 
                                     'ng_input_mybait', 'cycles_mybait', 
                                     'ng_ul_final_mybait'))

write_delim(meta.data,'data/2018-01-01_e-camal-assoc_samples.meta', delim='\t', append=FALSE, col_names=TRUE )
