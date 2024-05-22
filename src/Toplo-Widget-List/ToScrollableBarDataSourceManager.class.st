Class {
	#name : #ToScrollableBarDataSourceManager,
	#superclass : #Object,
	#instVars : [
		'innerBarElement'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #accessing }
ToScrollableBarDataSourceManager >> innerBarElement: anInnerBarElement [

	innerBarElement := anInnerBarElement
]

{ #category : #'data source updates' }
ToScrollableBarDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeChanged: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToScrollableBarDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeInserted: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToScrollableBarDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	innerBarElement onItemRangeRemoved: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToScrollableBarDataSourceManager >> onItemsChanged [

	innerBarElement onItemsChanged
]
