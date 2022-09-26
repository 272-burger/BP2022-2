# 4. 데이터 분석 기초

# 4.1 데이터 형태
# R에 내장된 데이터 - 대부분 DF 형태
library(help = datasets)

? trees # 데이터셋에 대한 설명 

data("trees") # 데이터셋 불러오기
class(trees) # 자료형 확인

df_trees <- as.data.frame(trees) # DF 자료형으로 변환해야 하는 경우 바꿔주기
class(df_trees)

head(trees) # 데이터셋의 앞 부분 보여줌
head(trees, n = 8) # 8개의 행을 보고 싶은 경우

tail(trees) # 데이터셋의 뒷 부분 보여줌

names(trees) # 데이터셋의 칼럼명 보여줌

str(trees) # 데이터셋의 내부 구조 확인

dim(trees) # 데이터셋의 차원(행, 열) 확인

summary(trees) # 데이터셋의 기초통계량 확인

# 조회한 데이터셋의 내용을 파일로 저장하고 저장된 파일 읽기
data("Orange")
Orange

write.table(Orange, 'orange.txt', sep=',') # 데이터셋을 .txt 파일로 저장하기

df_orange <- read.csv('orange.txt', header = T) 
## 첫 번째 행 = 칼럼명으로 설정해서 부르고 싶으면 header = T
df_orange

# 4.2 변수명 변경
## cf. 변수명 변경 작업을 할 때는 원본 대신 복사본으로 하는 것이 좋다
library(MASS) # 각각이 패키지 내에 실습 데이터가 있는 경우도 있다. 

# View(Cars93)

? Cars93

names(Cars93)
names(Cars93[1:5]) # 첫 번째부터 다섯 번째 변수명만 추출

cars93_subset <- Cars93[,c(1:5)]
cars93_subset 

class(names(cars93_subset)) # 변수명은 현재 문자열 
names(cars93_subset) <- c("v1", "v2", "v3", "v4", "v5")
View(cars93_subset)

## subset이 아닌 원본 데이터의 복사본의 변수명 변경
cars_new <- Cars93
names(cars_new[1:5]) <- c("v1", "v2", "v3", "v4", "v5")
names(cars_new) # 데이터의 일부만 변경하는 경우 
                # 변경사항이 반영되지 않고 그대로임

## 일부분만 바꾸고 싶은 경우 
### reshape 패키지의 rename 함수 사용
install.packages("reshape")
library(reshape)

cars93_subset <- rename(cars93_subset, c(v1 = "v1_manufacturer",
                                         v2 = "v2_model",
                                         v3 = "v3_type",
                                         v4 = "v4_min_price",
                                         v5 = "v5_price"))

names(cars93_subset)

cars_new <- rename(cars_new, c(Manufacturer = "v1",
                               Model = "v2"))

names(cars_new)

### dplyr 패키지의 rename 함수 사용
install.packages("dplyr")
library(dplyr)

cars_new <- rename(cars_new, v1_Manufacturer = v1,
                               v2_Model = v2)

names(cars_new)
# detach("package:reshape", unload=TRUE)

# 4.3 파생변수 생성
## 파생변수: 기존 변수를 연산 등을 통해 변형하여 만든 변수
df_score <- data.frame(kor = c(50, 60, 90, 70, 95),
                       eng = c(85, 90, 80, 75, 95),
                       math = c(75, 80, 85, 100, 95))

df_score

### total 
df_score$total <- df_score$kor + df_score$eng + df_score$math # 새로운 칼럼 total 추가
df_score

### average
df_score$avg <- round(df_score$total / 3, digits=1)
df_score

### result [ifelse]
df_score$result <- ifelse(df_score$avg >= 80, "Pass", "Fail")
df_score

### 중첩조건문 활용
# A: 90점 이상
# B: 80점 이상 90점 미만
# C: 70점 이상 80점 미만
# F: 70점 미만
df_score$grade <- ifelse(df_score$avg >= 90, "A", 
                         ifelse(df_score$avg >= 80, "B",
                         ifelse(df_score$avg >= 70, "C", "F")))
df_score


# 5. 데이터 전처리
## dplyr 패키지의 filter 함수 사용
library(readxl)

empdata <- read_excel("data.xlsx")
View(empdata)

empdata[empdata$department == "Sales", ] # department가 Sales에 해당하는 행을 가져 오겠다

empdata %>% ## 파이프 연산자
  filter(department == "Sales")

## 포지션이 manager인 사람만 추출
empdata %>% 
  filter(position == "Manager")

#### 
empdata[empdata$department == "Sales" & empdata$position == "Manager", ]

empdata %>% ## 파이프 연산자
  filter(department == "Sales" & position == "Manager")


## dplyr 패키지의 select 함수 사용
empdata['name']

empdata %>%
  select("name")

empdata[c("name", "department")]

empdata %>%
  select(name, department)

## filter & select 조합
empdata[empdata$department == "Sales", ][c('name', 'worktime')]


empdata %>%
  filter(department == "Sales") %>%
  select(name, worktime)


# 데이터 정렬하기
## arrange함수: 데이터를 오름차순 또는 내림차순으로 정렬할 때 사용
empdata %>% 
  arrange(name)

empdata %>%
  arrange(department, position) # 첫 번째 기준으로 먼저 정렬한 뒤 
# 첫 번째 기준으로 같은 경우 두 번째 기준으로 정렬됨. 

## 내림차순
empdata %>%
  select(name, salary) %>%
  arrange(desc(salary))

empdata %>%
  select(name, salary) %>%
  arrange(-salary)

empdata %>%
  select(-name)


