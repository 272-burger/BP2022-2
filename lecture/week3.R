# 3. 엑셀파일가져오기 & 기초함수

# read_excel 패키지 설치
install.packages("readxl")
library(readxl)


df_pop <- read_excel("./data1/birth.xlsx")
df_pop #tibble

View(df_pop) # 대문자 V, 엑셀처럼 데이터를 보고 싶은 경우

# 3.1 기초함수와 패키지
## 함수의 정의: 반복적으로 자주 사용되는 코드를 묶어 놓은 것
## 함수에 전달하는 입력값: 인수(arguments) -> 출력값

## 내장함수
## 1. 수학 함수
abs(-10) # 절대값
sqrt(9) # 제곱근
trunc(20.5) # 소수점 자리 버림
round(21.382, digits=1) # 반올림
round(21.382, digits=2) 


## 2. 기초통계량 함수
## 기초통계; 데이터의 특성을 간단하게 서술하는 통계
df_seoul <- read.csv("./data1/seoul_weather.csv")
df_seoul

length(df_seoul$Avg_temp) #자료의 개수
mean(df_seoul$Avg_temp) #평균
median(df_seoul$Avg_temp) #중앙값
max(df_seoul$Avg_temp) #최대값
min(df_seoul$Avg_temp) #최소값
sd(df_seoul$Avg_temp) #표준편차
summary(df_seoul$Avg_temp)

## cf. 기초통계량 함수에 인자로 전체 df를 넣으면 NULL 값이 나온다

## 3. 문자열 처리 함수
k <- c('a대학', 'b대학', 'c대학')

substr(k, 1, 2) # 첫 번째, 두 번째 글자만 가져온다

gsub('a', 'aaa', k) # a를 aaa로 바꾼다
k <- gsub('a', 'aaa', k) # 재할당해야 바뀐 값이 k에 반영됨

paste(k, '교', sep = '') # 문자열 합치기
paste(k, '교', sep = ';')

grep('b', k) # 패턴 문자열을 포함하는 x의 원소 번호 반환

## 사용자 정의 함수

total <- function(x, y)
{
  s <- x + y # s는 total이라는 함수가 구동될 때만 사용됨
  return(s)
}

total(10, 20)

# 3.2 제어문
## if-else 구문
num <- 50

if(num %% 2 == 0) # num이 짝수라면
{
  print("짝수")
} else
{
  print("홀수")
}

### 조건식이 간단한 경우
num <- 17
ifelse(num %% 2 == 0, "짝수", "홀수")

score <- c(88, 60, 95, 100, 70, 60)
ifelse(score >= 80, '합격', '불합격')

## 논리식을 활용한 조건검사
df_seoul[df_seoul$Avg_temp >= 0, ] # 조건에 해당하는 행 추출
df_seoul[df_seoul$Avg_temp >= 0, ]['date'] # 조건에 해당하는 날짜만 추출
df_seoul[df_seoul$Avg_temp >= 0, 'date'] # 조건에 해당하는 날짜 '값'들만 추출

### 조건이 여러 개 필요한 경우
### 두 조건을 모두 만족해야 하는 경우 AND
df_seoul[df_seoul$Avg_temp >= 2 & df_seoul$Max_temp <= 10, ]

### 두 조건 중 하나를 만족해야 하는 경우 OR
df_seoul[df_seoul$Avg_temp >= 2 | df_seoul$Max_temp <= 10, ]

# 3.2 패키지 소개
## 패키지: 함수의 모음
## 구글 cran에서 어떤 패키지를 사용할 수 있는지 확인 가능

install.packages('ggplot2') # 패키지 설치는 한 번만 하면 됨
library(ggplot2)

## ggplot2로 그래프 그리기
weather <- read.csv("./data1/weather.csv")
View(weather)
str(weather)

## 지역별 최고 기온을 그래프로
### 1. 데이터 연결하기 ggplot(data, aes(x = , y = ))
### 2. 그래프 모양 지정하기 
ggplot(weather, aes(x = region, y = max_temp)) +
  geom_point()

ggplot(weather, aes(x = region, y = max_temp)) +
  geom_boxplot()




