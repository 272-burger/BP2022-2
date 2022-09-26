# 1. R에서 제공하는 내부 데이터 세트 중 CO2 데이터 세트의 데이터를 다음과 같이 조회해보세요.
?CO2 # 데이터셋에 대한 설명 확인

## 1.1. CO2의 전체 데이터를 조회하세요.
View(CO2)

## 1.2. CO2의 행과 열의 개수(차원)를 조회하세요.
dim(CO2) 

## 1.3. CO2의 앞부분 10개의 데이터만 조회하세요.
head(CO2, n = 10)

## 1.4. CO2의 뒷부분 10개의 데이터만 조회하세요.
tail(CO2, n = 10)

## 1.5. CO2의 데이터 내부구조를 조회하세요.
str(CO2)

## 1.6. CO2의 기초통계량 요약 정보를 조회하세요.
summary(CO2)

# 2. R에서 제공하는 내부 데이터 세트 중 state.x77 데이터에 대해 다음 코드를 작성하세요.
?state.x77

## 2.1. state.x77 데이터 세트의 데이터 타입을 확인하고 데이터 프레임 형태로 불러와서 st 변수에 저장 하세요.
class(state.x77) # matrix 

st <- as.data.frame(state.x77)
class(st) # data.frame

## 2.2. state.x77 데이터 세트의 인구(population)와 수입(income) 열의 값들만 추출하여 “state_x77.txt” 파일로 저장하세요.
names(st) # 열 이름 확인
st_pop_income <- st[c("Population", "Income")] # 열 추출
st_pop_income
write.table(st_pop_income, 'state_x77.txt', sep=',') # .txt 파일로 저장 / 구분자 쉼표

## 2.3. 위 항목에서 작성한 “state_x77.txt” 파일을 읽어서 ds 변수에 저장한 후 ds의 내용을 출력하세요.
ds <- read.csv('state_x77.txt', header = T) # 첫 번째 행 칼럼명으로
ds

# 3. R에서 제공하는 내부 데이터 세트 중 iris 데이터에 대해 다음 작업을 수행 하세요.
?iris

## 3.1. iris 데이터 세트의 변수명(칼럼명)을 출력하세요.
names(iris)

## 3.2. iris 데이터 세트의 “Sepal.Length”, “Sepal.Width”, “Species” 열의 모든 데이터를 iris_subset 변수 에 저장하고, 
## names( ) 함수를 이용하여 변수명을 “V1”, “V2”, “V3”으로 변경하세요.
iris_subset <- iris[c('Sepal.Length', 'Sepal.Width', 'Species')]
iris_subset

names(iris_subset) <- c("V1", "V2", "V3")
names(iris_subset)

## 3.3. iris_subset 데이터 세트의 변수명을 dplyr 패키지의 rename( ) 함수를 사용하여 “Length”, “Width”, “Variety”로 변경하여 iris_subset2 변수로 저장하세요. 
library(dplyr)
iris_subset2 <- rename(iris_subset, c(Length = V1,
                               Width = V2,
                               Variety = V3))

iris_subset2

# 4. R에서 제공하는 내부 데이터 세트 중 women 데이터를 파악하고, 다음과 같이 파생 변수를 생성 하세요.
?women

## 4.1. women의 데이터 내부구조와 데이터 앞부분을 출력하세요.
str(women) # 데이터 내부구조
head(women) # 데이터 앞부분 출력

## 4.2. women의 height와 weight 변수를 height_in와 weight_lb로 변수명을 변경하세요.
new_women <- women # 복사본
new_women <- rename(new_women, height_in = height,
                    weight_lb = weight)
new_women

## 4.3. women의 height_in와 weight_lb 값을 센티미터(cm)와 킬로그램(kg)으로 변환하여 
## height_cm와 weight_kg으로 파생 변수를 생성하세요. (1in = 2.54cm, 1lb = 0.453592kg)
new_women$height_cm <- new_women$height_in * 2.54
new_women$weight_kg <- new_women$weight_lb * 0.453592

new_women

## 4.4. women의 height_cm와 weight_kg를 이용하여 bmi 파생 변수를 생성하세요.
### (bmi = 체중(kg) / 신장(m) * 신장(m))
new_women$bmi <- new_women$weight_kg / ((new_women$height_cm/100)**2)

new_women

## 4.5. bmi 값에 따라 비만 여부를 result 파생 변수로 생성하세요. (bmi: 20이하(저체중), 20초과25이하(표준), 25초과(과체중))
new_women$result <- ifelse(new_women$bmi > 25, "과체중",
                           ifelse(new_women$bmi > 20, "표준", "저체중"))

new_women

# 5. mtcars 데이터를 이용하여 다음에 해당하는 R코드를 작성하세요.
?mtcars
names(mtcars)

## 5.1. 엔진 실린더(cyl) 변수가 6인 데이터만 추출해보세요.
mtcars %>%
  filter(cyl == 6)


## 5.2. cyl가 4이고 연비(mpg)가 25보다 큰 데이터만 추출해보세요.
mtcars %>%
  filter(cyl == 4 & mpg > 25)


## 5.3. 변속기(am)가 0(automatic)인 자동차의 mpg, cyl, disp를 추출해보세요.
mtcars %>%
  filter(am == 0) %>%
  select(mpg, cyl, disp)

# 6. mtcars 데이터를 이용하여 다음 내용을 작성하세요.
## 6.1. 연비(mpg)가 높은 순으로 자동차를 출력하세요.
mtcars %>%
  arrange(-mpg)

## 6.2. 엔진 실린더(cyl)를 기준으로 오름차순 정렬하고, 
## 같은 값인 경우 연비(mpg)를 기준으로 내림차순 정렬하여 데이터를 출력하세요.
mtcars %>%
  arrange(cyl, -mpg)
