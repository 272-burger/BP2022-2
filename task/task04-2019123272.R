# 1. mtcars 데이터를 이용하여 다음 내용을 작성하세요.
data("mtcars")
View(mtcars) # 데이터 구조 확인

## 1.1. dplyr 패키지의 함수를 사용하여 무게(wt)가 무거운 순으로 
## 상위 5종의 자동차를 1위부터 5위 순서대로 출력하세요.
library(dplyr) # dplyr 패키지 불러오기

mtcars %>%
  arrange(-wt) %>% # wt에 대하여 내림차순 정렬
  head(5) # 상위 5개의 행 출력

## 1.2 dplyr 패키지의 함수를 사용하여 엔진 실린더(cyl)가 8인 자동차들 중에
## 연비(mpg)가 낮은 하위 5종의 자동차를 하위 5위부터 1위 순서대로 출력하세요.

mtcars %>%
  filter(cyl == 8) %>% # cyl가 8인 자동차 추출
  arrange(-mpg) %>% # 하위 5위부터 1위 출력: 내림차순 후 꼬리에서부터 5개 출력 
  tail(5)

# 2. mtcars 데이터를 이용하여 다음과 같은 파생 변수를 생성해보세요.
## 2.1 dplyr 패키지의 함수를 사용하여 year 칼럼을 추가하고 모든 데이터 값은 1974가 되도록 출력하세요. 
## (같은 값으로 할당할 때는 해당하는 값을 등호로 변수 또는 칼럼명과 연결하면 됩니다.)

mtcars %>%
  mutate(year = 1974) # dplyr의 mutate 함수를 사용해서 year 칼럼 추가
# cf. 이때 재할당 안 했으므로 원본 mtcars 데이터프레임은 추가되지 않고 그대로

## 2.2. 내장함수를 사용하여 am의 값이 0이면 automatic, 
## 1이면 manual인 trans1 변수를 추가하세요.

mtcars$trans1 <- ifelse(mtcars$am == 0, "automatic", "manual") # $ 활용하여 칼럼 추가 (실제로 추가됨)
mtcars

## 2.3. dplyr 패키지의 함수를 사용하여 am의 값이 0이면 automatic, 
## 1이면 manual인 trans2 변수를 추가하세요.

mtcars <- # mtcars에 재할당
  mtcars %>%
  mutate(trans2 = ifelse( # dplyr 패키지의 mutate 함수 활용하여 칼럼 추가
    am == 0, "automatic", "manual"
  ))
mtcars

# 3. mtcars 데이터를 이용하여 다음 문제를 해결해보세요.
## 3.1. dplyr 패키지의 함수를 사용하여 trans2의 값(“automatic”, “manual”)에 
## 따른 평균 연비(mpg), 평균 배기량(disp)를 출력하세요.

mtcars %>%
  group_by(trans2) %>% # 기준이 되는 trans2로 groupby
  summarise(mean_mpg= mean(mpg), # dplyr의 summarise 함수로 데이터 프레임 형태로 평균값 출력
            mean_disp = mean(disp))

## cf. 평균 구하기 전 결측치 있는지 확인
by_trans2 <- mtcars %>%
  group_by(trans2) 

table(is.na(by_trans2$mpg))
table(is.na(by_trans2$disp))

## 3.2. dplyr 패키지의 함수를 사용하여 엔진 실린더별로 
## 몇 대의 자동차가 있는지 출력해보세요.
names(mtcars) # cf. mtcars 칼럼명 확인
table(mtcars["cyl"]) # cf. 실린더 칼럼의 값 table로 확인

mtcars %>%
  group_by(cyl) %>% # 실린더별
  summarise(car_nums = n()) # n()으로 행 개수 출력 (행의 수를 세기 때문에 변수 지정 따로 안 해줘도 됨)

# 4. 
## 4.1. 실습에서 사용된 데이터 프레임 df_a에 대하여 dplyr 패키지의 left_join( ),
## inner_join( ), full_join( ) 함수를 사용하여 df_ex1과 결합하여 각각 
## df_left, df_inner, df_full에 저장해보고, 어떤 차이가 있는지 서술하세요.

df_a <- data.frame(name = c("aaa", "bbb", "ccc", "ddd"),
                   birthyear = c(1984, 1989, 1985, 1991))
df_ex1 <- data.frame(name = c("bbb", "ccc", "eee", "ddd"),
                     gen = c("F", "M", "F", "M"))

df_left <- left_join(df_a, df_ex1, by ="name") # left_join: df_a의 "name"을 기준으로 결합
df_left

df_inner <- inner_join(df_a, df_ex1, by = "name") # inner_join: df_a와 df_ex1의 공통 변수인 "name"을 기준으로 결합
df_inner

df_full <- full_join(df_a, df_ex1, by = "name") # full_join: 지정한 변수 "name"을 기준으로 결합
df_full

## 4.2. dplyr 패키지의 bind_rows( ) 함수를 사용하여 
## df_ex1에 df_ex2의 3개 데이터를 추가해보세요.
df_ex2 <- data.frame(name = c("fff", "ggg", "hhh"),
                     gen = c("M", "M", "F"))

df_all <- bind_rows(df_ex1, df_ex2) # 칼럼명 같아서 알아서 추가됨
df_all 

## 4.3.  dplyr 패키지의 데이터 결합 함수를 사용하여 아래 데이터프레임으로 
## 파생변수 vs_name을 mtcars에 추가하세요.
df_vs_name <- data.frame(vs = c(0, 1),
                         vs_name = c("V-shaped", "straight"))
df_vs_name

mtcars <- left_join(mtcars, df_vs_name, by = "vs") 
mtcars
# mtcars의 "vs"를 기준으로 결합, mtcars에 재할당

# 5. airquality 데이터를 이용하여 다음을 해결하세요.
data("airquality")
View(airquality)
## 5.1. 태양복사 에너지(Solar.R)의 관측값에 몇 개의 결측치가 있는지 확인하세요.
table(is.na(airquality$Solar.R)) # TRUE(결측치) 7개

## 5.2. dplyr 패키지의 함수를 사용하여 Solar.R의 결측치를 모두 제외하고 평균을 구하세요.
airquality %>%
  summarise(mean_Solar.R = mean(Solar.R, na.rm = T)) # na.rm = T로 결측치 제거, summarise 함수로 평균 연산

## 5.3. Solar.R의 결측치를 평균으로 대체하세요.
## (단, 평균은 소수점 첫째자리에서 반올림한 정수값을 직접 입력하여 사용하세요.)
## 평균: 186
airquality_new <- airquality
airquality_new$Solar.R <- ifelse(is.na(airquality$Solar.R), 186, airquality$Solar.R) # 결측치 평균값으로 대체
airquality_new # 실제 데이터 프레임 대체됨

## 5.4. dplyr 패키지의 함수를 사용하여 결측치를 평균으로 대체한 Solar.R의 평균을 구하세요.
airquality %>%
  summarise(mean_Solar.R = mean(Solar.R, na.rm = T)) 

# 6. airquality 데이터를 이용하여 다음을 해결하세요.
## 6.1.변수 Ozone에 몇 개의 결측치가 있는지 알아보세요.
table(is.na(airquality$Ozone)) # TRUE(결측치) 37개

## 6.2. 변수 Ozone에 대한 박스플랏(상자그림)을 그려 이상치(극단치)가 있는지 확인하고, 
## 어떤 값을 벗어난 값이 이상치(극단치)인지 확인하세요.
boxplot(airquality$Ozone)
boxplot(airquality$Ozone)$stats # 최소값 1.0, 최대값 122.0을 벗어난 값이 이상치이다

## 6.3. 변수 Ozone의 모든 이상치(극단치)를 결측치로 바꾸고, 
## 몇 개의 결측치가 추가됐는지 살펴보세요.
airquality$Ozone <- ifelse(airquality$Ozone < 1 | airquality$Ozone > 122, NA, airquality$Ozone)
table(is.na(airquality$Ozone)) # 39개의 결측치 추가

## 6.4. dplyr 패키지의 함수를 사용하여 
## 변수 Ozone의 결측치를 제외한 값들의 평균을 구하세요.
airquality %>%
  summarise(mean_Ozone = mean(airquality$Ozone, na.rm = T)) # na.rm = T 결측치 제거


