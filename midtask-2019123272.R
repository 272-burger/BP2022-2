###################1번#####################
# 1.1 ggplot2 패키지 안에 있는 실습데이터 msleep를 df_ms라는 
# 이름의 데이터 프레임 형태로 불러오세요.

# as.data.frame을 활용해서 ggplot2 패키지 부르지 않고 msleep 데이터프레임으로 가져오기 
df_ms <- as.data.frame(ggplot2::msleep)
df_ms

# 1.2 msleep의 도움말(매뉴얼)을 살펴보세요. 데이터와 각 변수에 대한 설명을 보고 정리해서 간단히 
# 주석으로 남기도록 하세요. (참고로 ggplot2패키지를 로드하지 않았다는 가정 하에 진행하세요).
? msleep # 데이터셋 정보 확인하기 
# 포유류 수면 데이터셋 
## 83행, 11열(이름, 속, 초식/육식/잡식 여부, 목, 보전 상태 등급, 총 수면시간, 램 수면시간, 수면 사이클 시간, 깨어있는 시간, 뇌 무게, 몸 무게)

# 1.3 데이터 파악하기에서 배운 모든 함수를 사용해서 데이터를 파악하세요. 
# 이때 출력된 결과를 보고 파악 한 내용을 간단히 주석으로 남기도록 하세요. 
# 특히 데이터 내부구조를 반드시 확인하여 기재하세요.

# 1) 데이터 앞부분 보기 
head(df_ms, n = 5) # 1 ~ 5행 출력, 몇몇 칼럼에 대해 결측값이 존재함을 확인할 수 있다

# 2) 데이터 뒷부분 보기
tail(df_ms, n =5) # 79 ~ 83행 출력, bodywt 변수의 경우 데이터들 간의 편차가 클 것 같다 
                  # Bottle-nosed dolphin의 bodywt의 값이 유난히 큼


# 3) 데이터 세트 변수명 보기
names(df_ms) # 변수 총 11개

# 4) 데이터 세트 내부구조 보기
str(df_ms) # 문자형 데이터타입을 가진 변수 5개 (name, genus, vore, order, conservation)
           # 숫자형 데이터타입을 가진 변수 6개 (sleep_total, sleep_rem, sleep_cycle, awake, brainwt, bodywt)

# 5) 데이터 세트 데이터 차원 보기
dim(df_ms) # 83행 11열

# 6) 데이터 세트 기초통계량 요약 보기
summary(df_ms) # 숫자형 데이터를 가진 변수 중 결측치가 존재하는 변수들(sleep_rem, sleep_cycle, brainwt)을 확인해 볼 수 있다

###################2번#####################
# 2.1 모든 변수에 대하여 각각 결측치가 있는 변수인지 확인하세요.

table(is.na(df_ms$name)) # FALSE
table(is.na(df_ms$genus)) # FALSE
table(is.na(df_ms$vore)) # TRUE(결측치) 7
table(is.na(df_ms$order)) # FALSE
table(is.na(df_ms$conservation)) # TRUE 29
table(is.na(df_ms$sleep_total)) # FALSE
table(is.na(df_ms$sleep_rem)) # TRUE 22
table(is.na(df_ms$sleep_cycle)) # TRUE 51
table(is.na(df_ms$awake)) # FALSE
table(is.na(df_ms$brainwt)) # TRUE 27
table(is.na(df_ms$bodywt)) # FALSE

# 2.2 변수의 데이터타입이 문자열(chr)로 되어 있는 변수 중에 
# 결측치가 있는 변수에 대해서 결측치들을 “Unknown”으로 변환하세요.

# 문자형 데이터타입을 가진 변수 중 결측치가 있는 변수: vore, conservation
df_ms$vore <- ifelse(is.na(df_ms$vore), "Unknown", df_ms$vore) # 조건문 활용하여 결측치가 있는 경우 Unknown으로 대체
table(is.na(df_ms$vore)) # 결측치 대체됐는지 확인

df_ms$conservation <- ifelse(is.na(df_ms$conservation), "Unknown", df_ms$conservation) 
table(is.na(df_ms$conservation)) 

# 2.3 극단치가 있는지 확인이 필요한 모든 변수에 대해 각각 극단치를 확인하세요.

# 숫자형 변수들(sleep_total, sleep_rem, sleep_cycle, awake, brainwt, bodywt)에 대해 극단치 확인
# 모두 연속형이므로 상자그림 통계로 극단치(상자밖 데이터)를 찾는다
library(dplyr) # dplyr 패키지의 filter() 함수로 극단치에 해당하는 행 출력하여 확인
# 극단치 = 최소값(수염 아래 경계선), 최대값(수염 위 경계선)을 벗어난 값 

## sleep_total
boxplot(df_ms$sleep_total)$stat # 최소: 1.90, 최대: 19.90
df_ms %>%
  filter(df_ms$sleep_total > 19.90 | df_ms$sleep_total < 1.90) # 없음

## sleep_rem
boxplot(df_ms$sleep_rem)$stat # 최소: 0.1,  최대: 3.9
df_ms %>%
  filter(df_ms$sleep_rem > 3.9 | df_ms$sleep_rem < 0.1) # 3개 

## sleep_cycle
boxplot(df_ms$sleep_cycle)$stat # 최소: 0.1166667, 최대: 1.0000000
df_ms %>%
  filter(df_ms$sleep_cycle > 1.0000000 | df_ms$sleep_cycle < 0.1166667) # 4개

## awake
boxplot(df_ms$awake)$stat # 최소: 4.10, 최대: 22.10
df_ms %>%
  filter(df_ms$awake > 22.10 | df_ms$awake < 4.10) # 없음

## brainwt
boxplot(df_ms$brainwt)$stat # 최소: 0.00014, 최대: 0.32500
df_ms %>%
  filter(df_ms$brainwt > 0.32500 | df_ms$brainwt < 0.00014) # 7개 

## bodywt
boxplot(df_ms$bodywt)$stat # 최소: 0.005, 최대: 100.000
df_ms %>%
  filter(df_ms$bodywt > 100.000 | df_ms$bodywt < 0.005) # 11개 



# 2.4 극단치가 있는 변수 중 무게(wt)와 관련된 변수는 이 결측치 작업을 할 필요가 없습니다. 
# 나머지 극단치가 있는 변수에 대해서 결측치 처리를 한 뒤, 결측치의 수를 확인하세요.

# sleep_rem, sleep_cycle 변수에 대한 극단치를 결측치로 처리
# ifelse 조건문으로 극단치 조건에 해당하는 경우 NA로 처리, 아닌 경우 원래 데이터 유지

## sleep_rem 결측치 3개 
table(is.na(df_ms$sleep_rem)) # 극단치 결측치 처리 전 결측치 수 확인: 22개 

df_ms$sleep_rem <- ifelse(df_ms$sleep_rem > 3.9 | df_ms$sleep_rem < 0.1, NA, df_ms$sleep_rem)
table(is.na(df_ms$sleep_rem)) # 결측치 작업 후 총 TRUE(결측치): 25개

## sleep_cycle 결측치 4개 
table(is.na(df_ms$sleep_cycle)) # 극단치 결측치 처리 전 결측치 수 확인: 51개 

df_ms$sleep_cycle <- ifelse(df_ms$sleep_cycle > 1.0000000 | df_ms$sleep_cycle < 0.1166667, NA, df_ms$sleep_cycle)
table(is.na(df_ms$sleep_cycle)) # 결측치 작업 후 총 TRUE(결측치): 55개

###################3번#####################
# 3.1 총수면량에서 렘(rem)수면량을 제외한 비렘수면량(sleep_nonrem)을 
# 파생변수로 만들어 보세요.

# 변수 sleep_total에서 변수 sleep_rem을 빼서 새로운 파생변수 sleep_nonrem에 할당
df_ms$sleep_nonrem <- df_ms$sleep_total - df_ms$sleep_rem

# 3.2 총수면량과 렘(rem)수면량, 비렘수면량에 대해서 분 단위(in hours to minutes)로 계산된 파생변수를 각각 만들어 보세요.
# (기존 변수명 뒤에 '_min'을 붙이세요). 시간 단위로 되어 있는 변수를 분 단위 변수로 변경할 때 수식에 유의하도록 하세요.

# 시간 단위 변수를 분 단위로 바꾸기 위해 60을 곱한다 
df_ms$sleep_total_min <- df_ms$sleep_total * 60
df_ms$sleep_rem_min <- df_ms$sleep_rem * 60
df_ms$sleep_nonrem_min <- df_ms$sleep_nonrem * 60

names(df_ms) # 데이터프레임에 파생변수  "sleep_nonrem", "sleep_total_min", "sleep_rem_min", "sleep_nonrem_min" 생긴 것 확인

###################4번#####################
# 4.1 식성 구분(육/잡/초/충/모름)이 들어 있는 변수의 각 식성별 빈도수를 빈도표로 확인해보세요.

# ggplot2 패키지의 빈도막대그래프 geom_bar()로 식성별 빈도수 확인 
library(ggplot2) # ggplot2 패키지 불러오기

ggplot(data = df_ms, aes(x = df_ms$vore)) +
  geom_bar() # 그래프를 통해 빈도는 초>잡>육>모름>충 순임을 확인할 수 있다 

# 4.2 잡식동물(omni)의 총수면량(분 단위), 렘수면량(분 단위), 비렘수면량(분 단위)을 
# 내장함수를 사용하는 방법과 dplyr 패키지 방식을 각각 사용하여 추출해보세요.

# 1) 내장함수 사용 
df_ms[df_ms$vore == "omni",][c('sleep_total_min', 'sleep_rem_min', 'sleep_nonrem_min')]
## df_ms[df_ms$vore == "omni",]: vore가 omni에 해당하는 행과
## [c('sleep_total_min', 'sleep_rem_min', 'sleep_nonrem_min')]: c()로 묶어 지정한 열에 해당하는 데이터 프레임 추출


# 2) dplyr 패키지 방식 사용
df_ms %>%
  filter(vore == "omni") %>%
  select(sleep_total_min, sleep_rem_min, sleep_nonrem_min)
## filter(): 조건에 맞는 행 추출
## select(): 필요한 열만 추출

# 4.3 식성 구분(육/잡/초/충/모름)별로 총수면량(시간 단위)의 평균을 
# 내장함수를 사용하는 방법과 dplyr 패키지 방식을 각각 사용하여 구해보세요.

# 1) 내장함수 사용 
mean(df_ms[df_ms$vore == "carni",'sleep_total']) # 시간 단위 
mean(df_ms[df_ms$vore == "herbi",'sleep_total'])
mean(df_ms[df_ms$vore == "insecti",'sleep_total'])
mean(df_ms[df_ms$vore == "omni",'sleep_total'])
mean(df_ms[df_ms$vore == "Unknown",'sleep_total'])
# 조건에 해당하는 데이터를 추출해서 기초통계량 함수인 mean()으로 평균 구한다. 

# 2) dplyr 패키지 방식 사용
df_ms %>%
  group_by(vore) %>%
  summarise(mean_sleeptime = mean(sleep_total)) # 시간 단위
## group_by()로 vore별 평균 sleep_total 데이터프레임 형태로 출력


# 4.4 식성 구분(육/잡/초/충/모름)별 총수면량(분 단위)을 막대그래프로 나타내보세요. 
# 이때 막대그래프는 평균이 높은 순으로 보여지게 하세요.

# 식성 구분별 평균 총수면량(분 단위) 데이터 프레임
df_vore_mean <- df_ms %>%
  group_by(vore) %>%
  summarise(mean_sleeptime = mean(sleep_total_min)) 

# geom_col() 막대그래프
# reorder() 함수로 mean_sleeptime_min에 대해 내림차순 정렬 
ggplot(data = df_vore_mean, aes(x = reorder(vore, -mean_sleeptime), y = mean_sleeptime)) +
  geom_col()



###################5번#####################
# 5.1 아래의 표는 멸종 위협에 대해서 High와 Low, Non으로 구분한 표입니다. 
# red_list라는 이름의 데이터 프레임으로 만들어보세요.

# data.frame()으로 데이터 프레임 생성
red_list <- data.frame(conservation = c("en", "vu", "nt", "cd", "lc", "domesticated"),
                       risk = c("high", "high", "low", "low", "low", "non"))

red_list

# 5.2 red_list 데이터 프레임을 활용하여 df_ms 데이터에 risk 라는 변수가 
# 오른쪽에 파생변수로 추가 되도록 하세요.

# df_ms 데이터 프레임의 "conservation"을 기준으로 결합: left_join 
df_ms <- left_join(df_ms, red_list, by = "conservation")


# 5.3 멸종 위기 수준(high/low/non)에 따라 깨어있는 시간의 평균, 중앙값, 최소값, 최대값, 빈도를 구해보세요.

sum(is.na(df_ms$awake)) # 연산하기 전 결측치 있는지 확인

df_ms %>%
  filter(!is.na(risk)) %>% # risk 변수의 결측치 제거 
  group_by(risk) %>% # 멸종 위기 수준에 따라 groupby()
  # 통계치 산출 함수 summarise()
  summarise(mean_awake = mean(awake), # 평균 
            med_awake = median(awake), # 중앙값
            min_awake = min(awake), # 최소값
            max_awake = max(awake), # 최대값
            count_awake = length(awake)) # 빈도; n()로 행의 개수 세어도 같은 결과


# 5.4 멸종 위기 수준(high/low/non)에 따라 렘수면(분 단위)의 평균, 중앙값, 최소값, 최대값, 빈도를 구해보세요.

sum(is.na(df_ms$sleep_rem_min)) # 연산하기 전 결측치 있는지 확인
# 결측치가 있으므로 제거하고 연산해야 한다 

df_ms %>%
  filter(!is.na(risk)) %>% # risk 변수의 결측치 제거 
  group_by(risk) %>% # 멸종 위기 수준에 따라 groupby()
  # 통계치 산출 함수 summarise()
  # 결측치 제거 파라미터 na.rm = T
  summarise(mean_rem = mean(sleep_rem_min, na.rm = T), # 평균 
            med_rem = median(sleep_rem_min,  na.rm = T), # 중앙값
            min_rem = min(sleep_rem_min,  na.rm = T), # 최소값
            max_rem = max(sleep_rem_min,  na.rm = T), # 최대값
            count_rem = length(sleep_rem_min)) # 빈도; n()로 행의 개수 세어도 같은 결과



###################6번#####################
# 6.1 가축(domesticated)만 추출해서 몸무게(x축)와 뇌 무게(y축)를 산점도로 나타내보세요.

# 가축만 추출해서 데이터 프레임 df_domes에 할당
df_domes <- df_ms[df_ms$conservation == "domesticated",]

# 산점도 geom_point()
ggplot(data = df_domes, 
       aes(x = bodywt,
           y = brainwt)) +
  geom_point()

# 6.2 몸무게 중 뇌무게의 백분율을 나타내는 brain_ratio 라는 파생변수를 만들어보세요. 
# 백분율에 유의하세요. 이때, 소수점 아래 두자리까지 표시되도록 반올림하세요.

df_ms$brain_ratio <- round((df_ms$brainwt / df_ms$bodywt) * 100, 2) # 반올림 round(, 2)
df_ms


###################7번#####################
# 7.1 제공된 mammal_theria CSV파일을 불러오세요.
# (변수명 일부가 깨져서 나온다면 fileEncoding="UTF-8-BOM" 파라미터를 설정하세요.)

mammal_theria <- read.csv("mammal_theria.csv")
View(mammal_theria)

# 7.2 df_ms 데이터에 두 분류 칼럼 theria_main와 theria_sub이 오른쪽에 파생변수로 추가되도록 하세요.

df_ms <- left_join(df_ms, mammal_theria, by = "order") # df_ms의 order를 기준으로 left_join

# 7.3 로라시아상목(Laurasiatheria)과 영장상목(Euarchontoglires)만 추출하여 가장 많은 분류명(order) 을 5개 출력하세요.
# 이때 상위 5위부터 상위 1위까지 순서로 보여지도록 하세요.

# theria_sub가 로라시아상목(Laurasiatheria)이거나(OR) 영장상목(Euarchontoglires)인 행만 추출해서 데이터 프레임 df_lau_and_eua로
df_lau_and_eua <- df_ms[df_ms$theria_sub == "Laurasiatheria" | df_ms$theria_sub == "Euarchontoglires", ]
df_lau_and_eua 

# 가장 많은 분류명(order) 5개 상위 5위부터 1위 순으로 정렬 
df_lau_and_eua %>%
  group_by(order) %>% 
  summarise(count_order = length(order)) %>% # 분류명별 행의 개수 count_order 변수로 지정 
  arrange(count_order) %>% # count_order 내림차순 정렬 후 아래부터 5개 자르기 
  tail(5) 


###################8번#####################
# 8.1 총수면량(시간 단위)을 아래와 같이 구분하는 sleep_grade 변수를 추가하세요. 
# 각각 몇 동물씩 있는지 빈도표를 확인해보세요.

# 중첩조건문 활용 
df_ms$sleep_grade <- ifelse(df_ms$sleep_total >= 15, "A",
                            ifelse(df_ms$sleep_total >= 10, "B",
                                   ifelse(df_ms$sleep_total >= 5, "C", "D")))

df_ms %>%
  group_by(sleep_grade) %>% # sleep_grade별 행의 개수 세기
  summarise(num_sleep_grade = length(sleep_grade)) # n()으로 행의 개수 세어도 같은 결과 

# 빈도막대그래프 확인
ggplot(data = df_ms, 
       aes(x = sleep_grade)) + 
  geom_bar()

# 8.2 총수면량 중 비렘수면의 백분율을 나타내는 nonrem_ratio 라는 파생변수를 dplyr 사용하여 만들어 보세요.
df_ms <- # 재할당해줘야 df_ms에도 추가됨 
  df_ms %>%
  mutate(nonrem_ratio = (sleep_nonrem / sleep_total) *100) # mutate() 함수로 파생변수 생성 


# 8.3 수면량 등급별 비렘수면 백분율을 막대그래프로 나타내보세요. 
# 이때 막대그래프는 평균이 낮은 순으로 보여지게 하세요.

# 수면량 등급별 평균 비렘수면 백분율 데이터 프레임
df_nonrem_mean <- df_ms %>%
  group_by(sleep_grade) %>% # 수면량 등급으로 group_by
  summarise(nonrem_mean = mean(nonrem_ratio, na.rm = T)) 
df_nonrem_mean

# geom_col() 막대그래프
# reorder() 함수로 nonrem_mean에 대해 오름차순 정렬 
ggplot(data = df_nonrem_mean, aes(x = reorder(sleep_grade, nonrem_mean), y = nonrem_mean)) +
  geom_col()


# 8.4 식성 구분(육/잡/초/충/모름)별 비렘수면 백분율을 막대그래프로 나타내보세요. 
# 이때 막대그래프는 평균이 낮은 순으로 보여지게 하세요.

df_nonrem_mean2 <- df_ms %>%
  group_by(vore) %>%
  summarise(nonrem_mean = mean(nonrem_ratio, na.rm = T)) 
df_nonrem_mean2

ggplot(data = df_nonrem_mean2, aes(x = reorder(vore, nonrem_mean), y = nonrem_mean)) +
  geom_col()

  
###################9번#####################
# 9.1 사람(Human)의 뇌무게 백분율을 확인하여 human_brainwt 이라는 변수에 할당하세요. 
# 이때 숫자를 직접 입력하는 방식을 사용하지 말고 해당하는 값이 할당되도록 하세요.
human_brainwt <- df_ms[df_ms['name'] == 'Human','brain_ratio'] # name이 Human인 행의 brain_ratio값 
human_brainwt

# 9.2 human_brainwt보다 뇌무게 백분율이 높은 그룹을 "High", 낮은 그룹을 "Low", 
# 기준이 되는 사람과 같은 값은 "Human" 이라고 판별한 brain_grade 라는 변수를 만들어서 
# 해당 변수별로 총수면량(시간 단위)의 최소값, 중앙값, 평균, 최대값, 빈도를 출력하세요.

# 중첩조건문으로 brain_grade 변수 추가
df_ms$brain_grade <- ifelse(df_ms$brain_ratio > human_brainwt, "High",
                            ifelse(df_ms$brain_ratio == human_brainwt, "Human", "Low"))
df_ms

# 연산 전 sleep_total 변수 결측치 먼저 확인 
sum(is.na(df_ms$sleep_total)) # 결측치 없음

# brain_grade별총수면량(시간 단위)의 최소값, 중앙값, 평균, 최대값, 빈도 연산 
df_ms %>%
  filter(!is.na(brain_grade)) %>% # brain_grade 결측치 제거 
  group_by(brain_grade) %>%
  summarise(min_sleep = min(sleep_total),
            med_sleep = median(sleep_total),
            mean_sleep = mean(sleep_total),
            max_sleep = max(sleep_total),
            count_sleep = length(sleep_total))