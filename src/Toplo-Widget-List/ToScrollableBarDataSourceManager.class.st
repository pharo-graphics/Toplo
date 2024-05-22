Class {
	#name : #ToScrollableBarDataSourceManager,
	#superclass : #Object,
	#instVars : [
		'innerLinearBarElement'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #accessing }
ToScrollableBarDataSourceManager >> innerLinearBarElement: aScrollableBarElement [

	innerLinearBarElement := aScrollableBarElement 
]

{ #category : #'data source updates' }
ToScrollableBarDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [
]

{ #category : #'data source updates' }
ToScrollableBarDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	innerLinearBarElement onItemRangeInserted: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToScrollableBarDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [
]

{ #category : #'data source updates' }
ToScrollableBarDataSourceManager >> onItemsChanged [


]
