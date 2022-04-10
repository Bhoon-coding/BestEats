# Besteats
> 배만 채우면 되던 시대는 이제 옛날 얘기!!  
어떻게 먹어야 맛있게 먹을수 있을까를 고민하는 시대가 됐다.  
기록하고 나만의 레시피로 맛있게 먹자🍗  

## 이런분들에게 추천!  

- 음식점 마다 나에게 맞는 간이나 매운맛의 강도가 다 다르지 않았나?
- 오랜만에 방문한 맛집. 어떻게 먹어야 맛있었지? 다음엔 이걸 먹어봐야겠다고 했는데 그게 뭐였지? 


# 기술 스택
- Swift(v5.3.2)

# 개발 도구
- Xcode(v13.1)
- Snapkit
- Storyboard (메인화면)

# Version Target 
- iOS 13.0

# 기능

## Main page (메인 페이지)

### TabBar Controller
- 하단 탭의 버튼으로 페이지 별 보여지는 화면을 다르게 구현 하였습니다.

### BottomSheet (ActionSheet)
- '...' 버튼을 누르면 하단에서 ActionSheet를 보여주며 '맛집 이름 변경', '맛집 삭제'를 할 수 있습니다.

### 음식점 찾기
- 등록되어 있는 음식점을 filter, contain 메소드를 이용해서 사용자가 찾고자 하는 음식점을 직관적으로 추려내게 구현 하였습니다.

### 즐겨찾기 메뉴 예외 처리
- 등록된 즐겨찾기 메뉴가 없을 시 '즐겨찾기 메뉴 추가 문구'를 보여주게 하였습니다.


### 해당 맛집 메뉴타입별 숫자 보여주기
- 등록된 맛집의 메뉴 타입별로 메뉴갯수를 나타내게 하였습니다.


### Empty State (CollectionView, TableView)
- 데이터가 없을시 빈 화면이 아닌 맛집 데이터 추가를 유도하는 View를 보여주도록 하였습니다.

#### 체크리스트
- [x] 맛집리스트 Cell 중간 베스트메뉴명 설정 
- [x] 맛집메뉴명 변경하는 기능 추가 필요
- [x] 맛집리스트 Cell 하단 타입별 메뉴 갯수 추가. (디자인 수정 필요)
- [x] 맛집리스트 Cell 삭제 기능
- [x] 등록된 맛집리스트 검색
 

----

## Detail page (상세 페이지)
- TableView를 사용하여 등록한 `메뉴`와 `한줄팁`을 보기쉽게 구현 하였습니다.
- Main page에서 받아온 데이터를 navigation title, tableViewCell에 보여주도록 하였습니다.
- `좋아요`, `먹어볼래요`, `별로에요` 버튼 클릭시 `filter 메소드`를 사용하여 타입별로 나타내게 하였습니다.
- `좋아요` 타입에서 ⭐️ 터치시 메인페이지에 등록된 메뉴가 보이도록 즐겨찾기 기능 구현 하였습니다.

### 체크리스트
- [x] FoodModiModel 구조체 구조 수정 
- [x] 메뉴리스트 Cell에 보여주기
- [x] 메뉴리스트 삭제 기능
- [x] type 별로 array filter (like, curious, warning)
- [ ] 중복 맛집명의 경우로 데이터 추가시 안되게 토스트 띄워주기
- [x] 해당 타입의 메뉴리스트가 없을시 Empty State 화면 보여주기

-----

## MenuAdd page (메뉴 추가 페이지)
- 메뉴 추가시 `해당 맛집`에 추가 되게 구현 하였습니다.
