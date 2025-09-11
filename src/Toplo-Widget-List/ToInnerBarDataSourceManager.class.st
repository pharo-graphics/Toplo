Class {
	#name : #ToInnerBarDataSourceManager,
	#superclass : #Object,
	#instVars : [
		'innerBarElement'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #accessing }
ToInnerBarDataSourceManager >> innerBarElement: anInnerBarElement [

	innerBarElement := anInnerBarElement
]

{ #category : #'data source updates' }
ToInnerBarDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeChanged: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToInnerBarDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeInserted: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToInnerBarDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeRemoved: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToInnerBarDataSourceManager >> onItemsChanged [

	innerBarElement onItemsChanged
]

{ #category : #'data source updates' }
ToInnerBarDataSourceManager >> postponeAction: aValuable for: aTarget [

	innerBarElement enqueueTask:
		(BlTaskAction new action: [ aValuable cull: aTarget ])
]

{ #category : #'data source updates' }
ToInnerBarDataSourceManager >> postponeCommand: aCommand [

	aCommand action value
]
