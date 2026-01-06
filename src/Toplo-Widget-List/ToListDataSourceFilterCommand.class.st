Class {
	#name : #ToListDataSourceFilterCommand,
	#superclass : #ToListDataSourceCommand,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #application }
ToListDataSourceFilterCommand >> applyIn: anInfiniteElement [

	anInfiniteElement applyDataSourceFilterCommand: self
]

{ #category : #'infinite compatibility' }
ToListDataSourceFilterCommand >> applyOnPosition: aPosition [
	"When the position of an ElementHolder is required.
	Determine how provided position will change. Return the position after command is processed"
	
	^ aPosition
]

{ #category : #'infinite compatibility' }
ToListDataSourceFilterCommand >> dispatchToLayout: aLayout [

	"aLayout onItemsAddedAt: self positionStart count: self itemCount"
]

{ #category : #'infinite compatibility' }
ToListDataSourceFilterCommand >> isFilter [

	^ true
]

{ #category : #'infinite compatibility' }
ToListDataSourceFilterCommand >> isUpdate [

	^ true
]

{ #category : #'infinite compatibility' }
ToListDataSourceFilterCommand >> offsetPositionsIn: anInfiniteElement [

	self applyIn: anInfiniteElement.
	"anInfiniteElement
		offsetPositionRecordsForInsert: self positionStart
		itemCount: self itemCount"
]
