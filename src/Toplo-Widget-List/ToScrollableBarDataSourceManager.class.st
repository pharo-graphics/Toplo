Class {
	#name : #ToScrollableBarDataSourceManager,
	#superclass : #Object,
	#instVars : [
		'scrollableBarElement'
	],
	#category : #'Toplo-Widget-List-InnerLinearBar'
}

{ #category : #'items - hooks' }
ToScrollableBarDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [
]

{ #category : #'items - hooks' }
ToScrollableBarDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	| holder offsetPosition holders |
	holders := Array streamContents: [ :stream |
		           1 to: anItemCount do: [ :idx |
			           holder := scrollableBarElement dataSource createHolder:
				                     scrollableBarElement.
			           offsetPosition := aPositionStart + idx - 1.
			           holder infiniteElement: scrollableBarElement.
			           scrollableBarElement dataSource
				           bindHolder: holder
				           at: offsetPosition.
			           stream nextPut: holder ] ].
scrollableBarElement addHolders: holders
]

{ #category : #'items - hooks' }
ToScrollableBarDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [
]

{ #category : #'items - hooks' }
ToScrollableBarDataSourceManager >> onItemsChanged [


]

{ #category : #accessing }
ToScrollableBarDataSourceManager >> scrollableBarElement: aScrollableBarElement [

	scrollableBarElement := aScrollableBarElement 
]
