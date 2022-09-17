###################
# 3주차 주별 과제 #
###################

# 다음 표는 뷰티몰의 회원등급관리 데이터입니다.
# 
# 이름  회원등급  구매액
# aaa     VIP      35000
# bbb     gold     25000
# ccc   welcome    15000
# ddd     gold     23000
# eee     VIP      42000


# 1. 위 표의 내용을 아래와 같은 실행결과가 나오도록 데이터 프레임 구조로 만들어 변수에 저장하고, 출력해보세요.
# 
# name   grade price
# 1  aaa     VIP 35000
# 2  bbb    gold 25000
# 3  ccc welcome 15000
# 4  ddd    gold 23000
# 5  eee     VIP 42000

df_members <- data.frame(name = c('aaa', 'bbb', 'ccc', 'ddd', 'eee'),
                         grade = c('VIP', 'gold', 'welcome', 'gold', 'VIP'),
                         price = c(35000, 25000, 15000, 23000, 42000))
df_members


# 2. 기초통계량 함수를 이용해 구매액의 최대값, 최소값, 평균값, 중앙값을 순서대로 구해보세요.

max(df_members$price) # 최대값
min(df_members$price) # 최소값
mean(df_members$price) # 평균값
median(df_members$price) # 중앙값


# 3. 문자열 함수를 이용해 gold를 silver로 변경한 후 바뀐 데이터 프레임을 출력해보세요.
# 
# name   grade price
# 1  aaa     VIP 35000
# 2  bbb  silver 25000
# 3  ccc welcome 15000
# 4  ddd  silver 23000
# 5  eee     VIP 42000

df_members$grade <- gsub('gold', 'silver', df_members$grade)
df_members

# 4. 논리식을 활용하여 회원등급이 VIP이면서 구매액이 39000원 이상인 회원의 모든 정보를 추출하세요.
# 
# name grade price
# 5  eee   VIP 42000

df_members[df_members$grade == 'VIP' & df_members$price >= 39000, ]

# 5. 논리식을 활용하여 회원등급이 silver인 회원의 이름만 데이터프레임 형태로 추출하세요.
# 
# name
# 2  bbb
# 4  ddd

df_members[df_members$grade == 'silver',]['name']


# 6. ggplot2를 이용해 이름별 구매액을 점 그래프로 그려보세요. 이름이 가로, 구매액이 세로에 표시되도록 하세요.

ggplot(df_members, aes(x=name, y=price))+
  geom_point()


