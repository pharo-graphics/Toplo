Class {
	#name : #ToInnerFiniteListDataSourceManager,
	#superclass : #Object,
	#instVars : [
		'innerBarElement'
	],
	#category : #'Toplo-Widget-List-InnerFiniteList'
}

{ #category : #accessing }
ToInnerFiniteListDataSourceManager >> innerBarElement: anInnerBarElement [

	innerBarElement := anInnerBarElement
]

{ #category : #'data source updates' }
ToInnerFiniteListDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeChanged: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToInnerFiniteListDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeInserted: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToInnerFiniteListDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeRemoved: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToInnerFiniteListDataSourceManager >> onItemsChanged [

	innerBarElement onItemsChanged
]

{ #category : #'data source updates' }
ToInnerFiniteListDataSourceManager >> postponeAction: aValuable for: aTarget [

	innerBarElement enqueueTask:
		(BlTaskAction new action: [ aValuable cull: aTarget ])
]

{ #category : #'data source updates' }
ToInnerFiniteListDataSourceManager >> postponeCommand: aCommand [

	aCommand action value
]
