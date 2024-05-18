Class {
	#name : #ToScrollableBarDataSourceManager,
	#superclass : #Object,
	#instVars : [
		'innerLinearBarElement'
	],
	#category : #'Toplo-Widget-List-InnerLinearBar'
}

{ #category : #accessing }
ToScrollableBarDataSourceManager >> innerLinearBarElement: aScrollableBarElement [

	innerLinearBarElement := aScrollableBarElement 
]

{ #category : #'items - hooks' }
ToScrollableBarDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [
]

{ #category : #'items - hooks' }
ToScrollableBarDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	| holder offsetPosition holders |
	holders := Array streamContents: [ :stream |
		           1 to: anItemCount do: [ :idx |
			           holder := innerLinearBarElement dataSource
				                     createHolder: innerLinearBarElement.
			           offsetPosition := aPositionStart + idx - 1.
			           holder infiniteElement: innerLinearBarElement.
			           innerLinearBarElement dataSource
				           bindHolder: holder
				           at: offsetPosition.
			           stream nextPut: holder ] ].
	innerLinearBarElement addHolders: holders
]

{ #category : #'items - hooks' }
ToScrollableBarDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [
]

{ #category : #'items - hooks' }
ToScrollableBarDataSourceManager >> onItemsChanged [


]
