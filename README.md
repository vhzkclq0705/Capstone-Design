# Capstone-Design
서버, ML과 연동하여 만든 첫 프로젝트이자 컴퓨터공학부 졸업작품 입니다.

만들어보고 싶었던 기능들을 계획 없이 하나씩 추가하다 보니 코드 정리가 하나도 안되어있습니다.

꾸준한 공부를 통해 어지러운 코드들을 조금씩 정리하여 코드를 보기 쉽게, 더 효율적이게 작성하고 기록할 예정입니다.

## 기획 의도
자취생들로만 이루어져 있는 저희 팀은 식재료에 대한 고민을 많이 했습니다.

집에서 밥을 많이 해먹기 때문에, 집에 있는 식재료들을 관리하기 힘들고 식재료들로 어떤 음식을 해야할지 잘 몰라서 식재료 관련 앱을 만들기로 했습니다.

## 핵심 기능
- 카메라 인식을 통한 실시간 식재료 인식 후 인식한 식재료를 리스트에 추가
- 식재료로 만들 수 있는 레시피를 크롤링 후 웹뷰를 통해 보여줌
- 달력에 식재료 유통기한이 보기 쉽게 표시
- 타 유저의 식재료 확인

## 실행 화면(2배속)
![AI](https://user-images.githubusercontent.com/75382687/166254770-721fb994-d2cc-404d-b650-45fba3fac897.gif) ![Crawling](https://user-images.githubusercontent.com/75382687/166256311-14043162-3ba3-40b6-bfab-7de4f34bfbbf.gif)

     실시간 식재료 인식               크롤링

## 앱 시연 영상 링크

[아이디어붐](http://www.ideaboom.net/project/project/view?seq=1139)

## 코드 리팩토링
- 1차 리팩토링 (2022.04.28)
  > ViewController 데이터 전달 시 Model의 형태로 전달
  > 
  > isDeleting() 내부 중복 코드 삭제

- 2차 리팩토링 (2022.05.02)
  > Model에 들어있는 dummy값들 모두 삭제
  > 
  > 서버의 url 변경으로 인한 코드 수정 

- 3차 리팩토링 (2022.05.25)
  > MVVM패턴 일부 적용
  > 
  > API 통합을 위해 Networking 파일 생성 (진행 중)
  > 
  > 서버 주소를 한 곳에서 불러오기 위해 Address 열거형 타입 생성
  > 
  > Escaping Closure를 이용한 API 데이터 전달
  > 
  > MainVC에 표시될 Cell을 xib 파일로 분리
  > 
  > 크롤링해서 받아온 이미지 url을 쉽게 적용하기 위해 Kingfisher 라이브러리 적용
  
- 4차 리팩토링 (2022.05.29)
  > MVVM 패턴 모두 적용 완료
  > 
  > Networking 구현 완료(Escaping Closure -> Result 타입으로 변환 예정)
  > 
  > 크롤링을 위한 Crawling 파일 생성
  > 
  > 기능이 겹치는 ViewController들 일부 통합
  > 
  > cancle 기능만 있는 AlertController 전역화
  > 
  > 식재료 통합 관리를 위한 FoodManager를 싱글톤 패턴으로 생성

## 사용한 라이브러리
- Alamofire
- SideMenu
- SwiftSoup
- FSCalendar
- Kingfisher
