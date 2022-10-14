# 6. 행이름 다루기

data('WorldPhones')
?WorldPhones
class(WorldPhones)

wwp <- as.data.frame(WorldPhones)
View(wwp) # 행에 연도

library(ggplot2)
View(mpg) # 행이 숫자로 인덱싱
View(mtcars) # 행에 모델명

wwp2 <- read.csv('wwp.csv')
View(wwp2)
## 행이름이 있는 데이터 불러오기
wwp2 <- read.csv('wwp.csv', row.names = 1) # 첫 번째 칼럼을 행이름으로
View(wwp2)

## 행이름 관련 함수들
library(dplyr)

wwp_all <- bind_rows(wwp, wwp2)
View(wwp_all)

library(tibble)

# 행이름이 있는지 없는지를 판별해 주는 함수
has_rownames(wwp)
has_rownames(mpg)

wwp_new <- wwp 

## 행이름 제거 remove_rownames
remove_rownames(wwp_new) 
View(wwp_new)


## 행이름을 칼럼으로 (재할당해줘야 함)
wwp <- rownames_to_column(wwp, var = 'year')
wwp2 <- rownames_to_column(wwp2, var = 'year')

### 그 다음에 두 데이터프레임을 합치면 위에서와 달리 에러 없이 합칠 수 있음
wwp_all <- bind_rows(wwp, wwp2)
wwp_all <- column_to_rownames(wwp_all, var = 'year')
View(wwp_all)

## (행이름 없는 데이터) 행번호를 새로운 칼럼으로 생성 rowid_to_column()
rowid_to_column(mpg)


# 7. 그래프
## 데이터의 전체적인 특성 파악

## 7.1 파이차트
pie(c(30, 55, 40))

df <- c(30, 55, 40)

install.packages("extrafont")
library(extrafont)

pie(df, 
    labels = c('A사', 'B사', 'C사'),
    col = c('red', 'blue', 'green'),
    main = "회사별 판매량",
    clockwise = TRUE,
    init.angle = 90)

data('Titanic')
class(Titanic)
tt <- as.data.frame(Titanic)
View(tt)

df_sur <- tt %>%
  filter(Survived == "Yes") %>%
  group_by(Class) %>%
  summarise(total = sum(Freq))

pie(df_sur$total,
    labels = df_sur$Class,
    main = "Titanic survivor",
    col = c("blue", "green", "yellow", "red"),
    init.angle = 90,
    clockwise = T)

## ggplot2 패키지 
## 7.2 막대그래프
df <- data.frame(var1 = c("A", "B", "C"),
                 var2 = c(4, 6, 5))
df

library(ggplot2)
ggplot(data = df, aes(x = reorder(var1, -var2), y = var2)) +
  geom_col()


ggplot(data = df_sur, aes(x = reorder(Class, -total), y = total)) +
  geom_col()

## 빈도막대그래프
df <- data.frame(var1 = c(1, 1, 1, 2, 2, 3, 3, 3, 3),
                 var2 = c(4, 4, 5, 5, 5, 5, 2, 2, 2))


df

ggplot(data = df, aes(x = var1)) +
  geom_bar()


ggplot(data = df, aes(x = var2)) +
  geom_bar()

ggplot(data = diamonds, aes(x = cut)) +
  geom_bar()

## 7.3 히스토그램
### 데이터가 그룹으로 지정되어 있지 않은 경우에 데이터를 일정 범주로 나누어 그 범주에 속한 데이터의 개수를 막대그래프로 나타낸다.

ggplot(data = diamonds, aes(x = carat)) + 
  geom_histogram() + 
  xlim(0, 3) + # x축 범위 설정 
  
hist(diamonds$carat)

## 7.4 선그래프
df <- data.frame(var1 = c(1, 2, 3, 4, 5, 6),
                   var2 = c(10, 5, 8, 6, 7, 9))
df
  
ggplot(data = df, aes(x = var1, y = var2)) + 
  geom_line()


dia_cnt <- diamonds %>%
  group_by(carat) %>%
  summarise(cnt = n())

ggplot(data = dia_cnt, aes(x = carat,
                           y = cnt)) + 
  geom_line() +
  xlim(0, 4)

## 7.5 산점도
## 두 개의 데이터를 각각 x축과 y축의 값으로 하는 점들을 좌표 평면에 나타내어 만드는 그래프
ggplot(data = df, 
       aes(x = var1, y = var2)) +
  geom_point()

ggplot(data = iris, aes(x = Sepal.Length, 
                        y = Sepal.Width,
                        color = Species)) + 
  geom_point()


## 7.6 상자그림
## 데이터를 어떤 특성에 따라 집단으로 분류하고 각 집단의
## 데이터를 상자그림으로 그려 비교하면 데이터의 특징을 파악하는데 효과적일 수 있다
ggplot(data = iris, 
       aes(x = Species, 
           y = Sepal.Width,
           color = Species)) +
  geom_boxplot()

