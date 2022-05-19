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
- <img width = "25%" src = "https://user-images.githubusercontent.com/64088377/168579712-495d2583-95ba-4482-88c7-fdaa33585145.png">


### TabBar Controller
- 하단 탭의 버튼으로 페이지 별 보여지는 화면을 다르게 구현 하였습니다.

### 맛집 티켓 (CollectionView)
- CollectionView를 활용하여 사용자가 등록한 맛집들을 한눈에 볼 수 있도록 구현 하였습니다.

### BottomSheet (ActionSheet)
<img width="25%" src = "https://user-images.githubusercontent.com/64088377/168580941-99d1efd4-928d-4cd5-b48b-ef6625052982.gif">
- '...' 버튼을 누르면 하단에서 ActionSheet를 보여주며 '맛집 이름 변경', '맛집 삭제'를 할 수 있습니다.


### 음식점 찾기
<img width="25%" src = "https://user-images.githubusercontent.com/64088377/168581632-07b60bb3-5c1a-47a5-b04a-859eba29569e.gif">
- 등록되어 있는 음식점을 filter, contain 메소드를 이용해서 사용자가 찾고자 하는 음식점을 직관적으로 추려내게 구현 하였습니다.

### 즐겨찾기 메뉴 예외 처리
<img width="25%" src = "https://user-images.githubusercontent.com/64088377/168582222-d1cd5a27-44c3-4b8e-824a-4cc5871c799f.png">
- 등록된 즐겨찾기 메뉴가 없을 시 '즐겨찾기 메뉴 추가 문구'를 보여주게 하였습니다.


### 해당 맛집 메뉴타입별 숫자 보여주기
- 등록된 맛집의 메뉴 타입별로 메뉴갯수를 나타내게 하였습니다.


### Empty State (CollectionView, TableView)
- 데이터가 없을시 빈 화면이 아닌 맛집 데이터 추가를 유도하는 View를 보여주도록 하였습니다.


----

## MenuList page (메뉴리스트 페이지)
<img width="25%" src = "https://user-images.githubusercontent.com/64088377/168582735-dc804477-5649-42ce-b5cf-0795892bda57.png">

- TableView를 사용하여 등록한 `메뉴`와 `한줄팁`을 보기쉽게 구현 하였습니다.
- Main page에서 받아온 데이터를 navigation title, tableViewCell에 보여주도록 하였습니다.
- `좋아요`, `먹어볼래요`, `별로에요` 버튼 클릭시 `filter 메소드`를 사용하여 타입별로 나타내게 하였습니다.
   -> 위 타입별로 filter 하게되면 index를 가져오는데 어려움이있어 Model 구조를 변경 하였습니다.
- `좋아요` 타입에서 ⭐️ 터치시 메인페이지에 등록된 메뉴가 보이도록 즐겨찾기 기능 구현 하였습니다.



-----

## MenuAdd page (메뉴 추가 페이지)

- 메뉴 추가시 `해당 맛집`에 추가 되게 구현 하였습니다.
- UserDefaults를 활용하여 사용자가 등록한 맛집들을 로컬에 저장하게 하였습니다. 

-----

## MenuDetail page (메뉴 상세 페이지)
<img width="25%" src = "https://user-images.githubusercontent.com/64088377/169181539-1ce587dd-3cf3-41ee-a01a-0d96385c44da.gif">

- 메뉴 리스트의 선택된 cell의 데이터를 가져와서 보여주게 하였습니다.
- 우측 상단 navItem에 `수정`, `저장` 버튼에 따라 이벤트를 주게 하였습니다. (수정모드 <-> 변경내용저장)
- 타입(`좋아요`, `먹어볼래요`, `별로에요`)이 수정전 타입과 다르게 변경되면 `menuList페이지` 에서도 수정된 타입으로 메뉴가 이동하게 구현 하였습니다.

### 추후 구현할 기능
- [ ] 메뉴 사진 등록기능
- [ ] 메뉴 사진 상세 modal
- [x] 수정,완료 버튼 터치시 조건에 맞게 표현
- [x] 메뉴리스트에서 선택된 cell의 데이터 가져오기
