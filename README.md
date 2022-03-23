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

# Version Target 
- iOS 13.0

# 기능

## Main page (메인 페이지)
### TabBar Controller
- 하단 탭의 버튼으로 페이지 별 보여지는 화면을 다르게 구현

### BottomSheet (Custom)
- 하단에서 작은 창이 올라오며 간단한 버튼을 구현 

### 음식점 찾기
- 등록되어 있는 음식점을 filter메소드를 이용해서 사용자가 찾고자 하는 음식점을 직관적으로 추려내게 구현

### Empty State (CollectionView, TableView)
- 데이터가 없을시 빈 화면이 아닌 맛집 데이터 추가를 유도하는 View를 보여줌

----

## Detail page (상세 페이지)
- Main page에서 받아온 데이터를 네비게이션 제목, tableViewCell에 보여줌

### 체크리스트
- [x] FoodModiModel 구조체 구조 수정 
- [x] 메뉴리스트 Cell에 보여주기
- [ ] 메뉴리스트 삭제 기능
- [ ] type 별로 array filter (like, curious, warning)
- [ ] 중복 맛집명의 경우로 데이터 추가시 안되게 토스트 띄워주기

## MenuAdd page (메뉴 추가 페이지)
