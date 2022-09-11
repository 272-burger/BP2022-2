# 1. R스튜디오와 친숙해지기 

# Console: 명령어를 실행하는 창 / 결과를 확인할 수 있는 창

# Script: 명령어 / 메모를 입력하는 창

print("연수 최고")

# Environment: 변수 목록 확인 

# File: 파일 경로 확인

###################################

# 2. 데이터의 구조
# 변수: 데이터를 저장하는 공간
## (변수 이름) <- (값)
## 변수명 규칙 **문자로 시작 

a <- 7 # a라는 변수에 7 저장
a # a 변수 출력

name <- "최연수"
name

dept <- 'business'
dept

# 데이터 연산
## 산술 / 비교 / 논리 연산
## 1. 산술연산자: 사칙연산, 나머지, 몫, 제곱

b <- 5
c <- 3

b + c
b - c
b * c
b / c

b %/% c #몫
b %% c #나머지
b ^ c #제곱

## 2. 비교연산자: 두 데이터의 크기 비교, 논리값 반환

d <- 15
e <- 30

d > e
d <= e
d == e
d != e

## 3. 논리연산자: 조건이 2개 이상일 때. 
## AND: 두 조건을 모두 만족
## OR: 두 조건 중 하나를 만족

n <- "seoul"
m <- 33

# 지역은 부산이고, 온도는 30도 이상인 경우 
(n == "busan") & (m >= 30)

age <- 6
height <- 120

# 나이가 7세 이상이거나 키가 120 이상인 경우
(age >= 7) | (height >= 120)

# 데이터 타입
## 실수형, 문자형, 논리형, 범주형

## 범주형: c() / class() / factor()
x1 <- c(1, 2, 3) #데이터를 하나로 결합하는 함수
x1
class(x1) #데이터 타입을 확인할 수 있는 함수

x2 <- c("a", "b", "c")
x2
class(x2)

x3 <- c("1", "2", "3")
class(x3)

x4 <- c(TRUE, FALSE, T , F)
x4
class(x4)

x5 <- factor(c(1, 2, 3)) #범주형 -> 분류 번호
x5
class(x5)

# 데이터 형태
## 단일형: 한 가지 데이터 타입으로 이루어진 형태
## 다중형: 다양한 데이터 타입으로 구성ex. 숫자와 문자 데이터가 함께 담아져 있으면 다중형 

## 벡터: 한 개나 여러 개의 값으로 구성된 데이터 구조
v1 <- c(1, 2, 3, 4, 5)
v1

v2 <- c(1, "a")
v2 # 숫자로 넣어준 1이 문자로 들어감
class(v2) 

city <- c("seoul", "daejeon")
city

v3 <- c(1:5) #연속값은 콜론을 이용해 넣어줄 수 있음
v3

## seq(from, to, by)
## by 옵션값을 지정하지 않으면 기본값은 1
## 음수값 -> 감소: 시작값 > 끝값

e1 <- seq(1, 10)
e1

e2 <- seq(1, 8, 2)
e2

e3 <- seq(1, 8, by = 2)
e3

e4 <- seq(20, 5, by = -5)
e4

## rep(x, times | each)
## times: x 반복 횟수
## each: x 원소 각각의 반복 횟수

f1 <- rep(1, 5)
f1

f2 <- c(1:3)
f3 <- rep(f2, times = 2)
f3

f4 <- rep(f2, each = 2)
f4

## 벡터의 각 원소에 접근하는 방법
## [대괄호]를 활용해 벡터 요소의 일부를 가져올 수 있음
## 벡터명[선택하고자하는원소번호] / 벡터명[시작원소번호:끝원소번호]

f5 <- c(1:5)
f5

f5[1] # 첫 번째 원소
f5[5]
f5[2:5] # 두 번째부터 다섯 번째 원소

#################################
# 3. 다중형 데이터 형태와 파일 입출력
## 리스트: 모든 데이터 구조를 포함, list()
## 벡터(단일형) vs 리스트(다중형)

g1 <- c("aaa", "seoul", 80) 
g1 # 벡터(단일형): 숫자 -> 문자

g2 <- list("aaa", "seoul", 80)
g2 # 리스트(다중형): 문자는 문자로, 숫자는 숫자로

## cf. str(): 변수의 속성을 자세히 알려주는 함수
str(g1) 
str(g2)
class(g2)

## 리스트의 각 원소에 접근하는 방법
g3 <- list(name = "aaa",
           region = "seoul",
           region = c(80, 95, 90))
g3

### 원소명으로 접근하기
g3["name"]
g3["region"] #같은 명칭이 두 개 있으면 먼저 있는 애가 출력됨

### 번호로 접근하기
g3[1]
g3[2]
g3[3]

### 원소의 값만 출력하기 1. 대괄호 두 개 2. 달러 표시
g3[["name"]]
g3[["region"]]
g3[[2]]
g3[[3]]

g3$name
g3$region

#g3$1 #error

# 데이터 프레임
## 표와 같이 행과 열로 구성
## 숫자형, 문자형 등 다중형 데이터 저장 가능
### 헤더: 첫 번째 행

### how to make DF 1
name <- c("aaa", "bbb", "ccc")
major <- c("경영학과", "물리학과", "영문학과")
grade <- c(4, 3, 2)
score <- c(4.2, 3.7, 3.5)
student <- data.frame(name, major, grade, score)
student

### how to make DF 2
student <- data.frame(name = c("aaa", "bbb", "ccc"),
                      major = c("경영학과", "물리학과", "영문학과"),
                      grade = c(4, 3, 2),
                      score = c(4.2, 3.7, 3.5))
student

### DF에서 원소 추출
### 지정된 열의 모든 값 출력
student[2]
student[,2]

### 지정된 행의 모든 값 출력
student[1,]

### 지정된 행과 열이 교차되는 지점의 값 출력
student[1,2]

### 지정하면 변수명의 열 값이 출력
student$major
student["score"] # 열 추출 
student[["score"]] # 열의 값만 추출

### 해당위치의 원소 값 변경
student[3,2] <- "수학과"
student

# 파일 입출력
## DF를 csv 파일로 저장하기 write.csv()
write.csv(student, file = "student.csv", fileEncoding = 'cp949') # 프로젝트를 만들어줬던 폴더에 저장

## 외부 파일 가져오기
df <- read.csv("student.csv", fileEncoding = "CP949")
df
