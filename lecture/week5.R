# 5. 데이터 전처리
## 5.2 데이터 정렬하기
library(dplyr)
library(readxl)

empdata <- read_excel("data.xlsx")
empdata

empdata %>%
  arrange(-salary) # 연봉 내림차순

empdata %>%
  arrange(-salary) %>%
  head(5) %>% # 연봉 상위 5명
  select(name) # 이름만 추출

## 연봉 하위 5명
### 1방법
empdata %>%
  arrange(salary) %>%
  head(5) 
  
### 2방법
empdata %>%
  arrange(-salary) %>%
  tail(5) 

### 1방법 / 2방법 같은 목록이어도 순서!! 가 다르게 나온다

## 5.3 데이터 변형하기
### 파생변수 추가하기
empdata$bonus1 <- empdata$salary * 0.1
empdata

empdata %>%
  mutate(bonus2 = salary * 0.1) # 그러나 실제 df에 추가되지는 않음!
# 실제로 추가되게 하고 싶으면 할당을 다시 시켜줘야 함.
empdata <- 
  empdata %>%
  mutate(bonus2 = salary * 0.1)


empdata$timecheck1 <- ifelse(
  empdata$worktime >= 40, "over", "normal"
)
empdata

# 새로운 변수에 할당 - 원본 df 훼손되지 않게
empdata_new <-
  empdata %>%
  mutate(timecheck2 = ifelse(
    worktime >= 40, "over", "normal"
  ))
empdata_new

## 5.4 데이터 요약하기
### 전체 데이터의 평균 근무시간?
mean(empdata$worktime)

empdata %>%
  summarise(mean_worktime = mean(worktime)) # df 형식으로 출력됨

empdata %>%
  group_by(department) %>%
  summarise(mean_salary = mean(salary),
            mean_worktime = mean(worktime)) # department별 급여, 근무시간 평균

empdata %>%
  group_by(position) %>%
  summarise(cnt_emp = n(), # n: 행의 개수를 세어주는 함수
            sum_worktime = sum(worktime))

## 5.5 데이터 결합하기
## 가로로 결합하기
## inner_join: key가 되는 변수값이 동일할 때만 가로로 결합
df_1 <- data.frame(name = c('aaa', 'bbb', 'ccc'),
                   birthyear = c(1984, 1989, 1991))

df_2 <- data.frame(name = c('aaa', 'ccc', 'ddd'),
                   birthregion = c('seoul', 'incheon', 'daejon'))

df_inner <- inner_join(df_1, df_2, by = "name")
df_inner
  

## left_join: 왼쪽 df의 key를 기준으로 결합
df_left <- left_join(df_1, df_2, by = "name")
df_left
 
## full_join: 기준으로 정한 변수를 기준으로 데이터를 가로로 결합
df_full <- full_join(df_1, df_2, by = "name")
df_full



rep_num <- data.frame(department = c("Management", "Sales", "Marketing", "HR", "Development"),
                      rep_num =c('000-0001','000-0002','000-0003','000-0004','000-0005'))
rep_num

View(empdata)

empdata <- left_join(empdata, rep_num, by = "department") # empdata에 재할당

## 세로로 결합하기
## bind_rows: 기존 데이터 세트에 변수가 같은 데이터를 추가하는 기능
df_a <- data.frame(name = c("aaa", "bbb", "ccc", "ddd"),
                   birthyear = c(1984, 1989, 1985, 1991))
df_b <- data.frame(name = c("eee", "fff", "ggg"),
                   birthyear = c(1986, 1990, 1988))

df_all <- bind_rows(df_a, df_b) # 칼럼명이 다른 경우 칼럼명을 동일하게 맞춰주면 됨

# 6. 데이터 정제
## 6.1 결측 데이터 처리
## 결측치 확인
data <- data.frame(group = c("A", "B", NA, "C", "D", NA),
                   prod = c(20, 10, 50, NA, 30, NA))
data

is.na(data) # 결측치면 TRUE
table(is.na(data)) # 결측치 개수 확인
sum(data$prod) # 결측치가 있는 경우 연산 X
table(is.na(data$prod)) # 각 칼럼의 결측치 확인

## 결측치가 있는 행 제거
library(dplyr)
data %>%
  filter(is.na(group)) # 결측치가 있는 행 출력

data %>%
  filter(!is.na(group)) # 결측치가 없는 행 출력

data %>%
  filter(!is.na(group) & !is.na(prod))

na.omit(data) # 결측치 있는 행 한 번에 제거하기
## 데이터의 손실을 가져올 수 있기 때문에 주의해서 사용해야 한다

mean(data$prod, na.rm = T) # 결측치를 제거한 상태에서의 평균을 구하고 싶을 때

data %>%
  summarise(mean_prod = mean(prod, na.rm = T))

## 결측치를 다른 값으로 대체

df_mean_prod <- data %>%
  summarise(mean_prod = mean(prod, na.rm = T))

df_mean_prod[1,]

data$prod <- ifelse(is.na(data$prod),df_mean_prod[1,], data$prod) # 결측치 평균값으로 대체
data

table(data$prod) # 빈도표 -> 최빈값

## 6.2 이상 데이터 처리
df <- data.frame(gen = c(2, 1, 2, 1, 3, 2, 1),
                 score = c(4, 5, 2, 3, 6, 5, 7)) 
df

table(df$gen)
table(df$score)

data_num <- c(0, 4, 5, 6, 6, 6, 7, 7, 7, 10, 15, 16)
boxplot(data_num) # 비어있는 동그라미 = 아웃라이어

# 정상범위 확인 후, 이 범위를 벗어나는 이상치를 결측치로 처리
x <- boxplot(data_num)$stats
x

data <- ifelse(data_num < 4 | data_num > 10, NA, data_num)
data

mean(data_num, na.rm = T)

