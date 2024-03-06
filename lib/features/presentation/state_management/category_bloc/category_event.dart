abstract class CategoryEvent {
  const CategoryEvent();
}

class GetCategories extends CategoryEvent {
  const GetCategories();
}

class DisposeCategoryState extends CategoryEvent {
  const DisposeCategoryState();
}
