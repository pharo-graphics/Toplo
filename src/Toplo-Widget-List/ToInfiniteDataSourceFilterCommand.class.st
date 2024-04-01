Class {
	#name : #ToInfiniteDataSourceFilterCommand,
	#superclass : #BlInfiniteDataSourceCommand,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #commands }
ToInfiniteDataSourceFilterCommand >> applyFilterIn: anInfiniteElement [

	anInfiniteElement applyDataSourceFilterCommand: self
]

{ #category : #commands }
ToInfiniteDataSourceFilterCommand >> applyOnPosition: aPosition [
	"When the position of an ElementHolder is required.
	Determine how provided position will change. Return the position after command is processed"
	
	^ aPosition
]

{ #category : #commands }
ToInfiniteDataSourceFilterCommand >> dispatchToLayout: aLayout [

	aLayout onItemsAddedAt: self positionStart count: self itemCount
]

{ #category : #testing }
ToInfiniteDataSourceFilterCommand >> isAdd [

	^ false
]

{ #category : #testing }
ToInfiniteDataSourceFilterCommand >> isFilter [

	^ true
]

{ #category : #testing }
ToInfiniteDataSourceFilterCommand >> isUpdate [

	^ true
]

{ #category : #commands }
ToInfiniteDataSourceFilterCommand >> offsetPositionsIn: anInfiniteElement [

	self applyFilterIn: anInfiniteElement.
	anInfiniteElement
		offsetPositionRecordsForInsert: self positionStart
		itemCount: self itemCount
]
