Trait {
	#name : #TToListDataSourceHolder,
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #accessing }
TToListDataSourceHolder >> dataSource [

	^ self explicitRequirement 
]

{ #category : #accessing }
TToListDataSourceHolder >> dataSourceManager [

	^ self explicitRequirement 
]

{ #category : #accessing }
TToListDataSourceHolder >> defaultDataSource [

	^ self explicitRequirement 
]

{ #category : #accessing }
TToListDataSourceHolder >> defaultDataSourceObserver [

	^ self explicitRequirement 
]

{ #category : #accessing }
TToListDataSourceHolder >> initializeDataSource [

	^ self explicitRequirement 
]

{ #category : #accessing }
TToListDataSourceHolder >> listElement [

	^ self explicitRequirement 
]

{ #category : #accessing }
TToListDataSourceHolder >> listElement: aListElement [

	^ self explicitRequirement 
]

{ #category : #'instance creation' }
TToListDataSourceHolder >> newNodeHolderFromDataSource: aDataSource [

	^ self listElement nodeManager newHolder
]

{ #category : #'data source updates' }
TToListDataSourceHolder >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	self explicitRequirement 
]

{ #category : #'data source updates' }
TToListDataSourceHolder >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	self explicitRequirement 
]

{ #category : #'data source updates' }
TToListDataSourceHolder >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	self explicitRequirement 
]

{ #category : #'data source updates' }
TToListDataSourceHolder >> onItemsChanged [

	self explicitRequirement 
]
