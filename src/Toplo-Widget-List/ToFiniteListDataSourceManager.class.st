Class {
	#name : #ToFiniteListDataSourceManager,
	#superclass : #Object,
	#instVars : [
		'innerBarElement'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #accessing }
ToFiniteListDataSourceManager >> innerBarElement: anInnerBarElement [

	innerBarElement := anInnerBarElement
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeChanged: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeInserted: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeRemoved: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemsChanged [

	innerBarElement onItemsChanged
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> postponeAction: aValuable for: aTarget [

	innerBarElement enqueueTask:
		(BlTaskAction new action: [ aValuable cull: aTarget ])
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> postponeCommand: aCommand [

	aCommand action value
]
