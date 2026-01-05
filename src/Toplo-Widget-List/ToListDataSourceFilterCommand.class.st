Class {
	#name : #ToListDataSourceFilterCommand,
	#superclass : #BlInfiniteDataSourceCommand,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #commands }
ToListDataSourceFilterCommand >> applyFilterIn: anInfiniteElement [

	anInfiniteElement applyDataSourceFilterCommand: self
]

{ #category : #commands }
ToListDataSourceFilterCommand >> applyOnPosition: aPosition [
	"When the position of an ElementHolder is required.
	Determine how provided position will change. Return the position after command is processed"
	
	^ aPosition
]

{ #category : #commands }
ToListDataSourceFilterCommand >> dispatchToLayout: aLayout [

	aLayout onItemsAddedAt: self positionStart count: self itemCount
]

{ #category : #testing }
ToListDataSourceFilterCommand >> isFilter [

	^ true
]

{ #category : #testing }
ToListDataSourceFilterCommand >> isUpdate [

	^ true
]

{ #category : #commands }
ToListDataSourceFilterCommand >> offsetPositionsIn: anInfiniteElement [

	self applyFilterIn: anInfiniteElement.
	anInfiniteElement
		offsetPositionRecordsForInsert: self positionStart
		itemCount: self itemCount
]
