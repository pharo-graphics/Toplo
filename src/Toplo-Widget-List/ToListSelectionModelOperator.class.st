Class {
	#name : #ToListSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'private - operations' }
ToListSelectionModelOperator >> checkPivot [

	self pivot ifNil: [
		self pivot: self currentIndex.
		self distance: 0 ]
]

{ #category : #accessing }
ToListSelectionModelOperator >> currentIndex [

	^ self selectionModel currentIndex 
]

{ #category : #accessing }
ToListSelectionModelOperator >> currentIndex: anIndex [

	self selectionModel currentIndex: anIndex
]

{ #category : #'private - operations' }
ToListSelectionModelOperator >> distance [
	
	^ self selectionModel distance
]

{ #category : #'private - operations' }
ToListSelectionModelOperator >> distance: aGap [
	
	self selectionModel distance: aGap
]

{ #category : #'private - operations' }
ToListSelectionModelOperator >> goTowardNext [ 

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ false ].
			self markPointedPosition: 1 ]
		ifFalse: [
			self currentIndex < self itemCount ifFalse: [
				self markPointedPosition: 1.
				^ true ].
			self markPointedPosition: self currentIndex + 1 ].
	^ true
]

{ #category : #'private - operations' }
ToListSelectionModelOperator >> goTowardPrevious [

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ false ].
			self markPointedPosition: self itemCount ]
		ifFalse: [
			self currentIndex > 1 ifFalse: [
				self markPointedPosition: self itemCount.
				^ true ].
			self markPointedPosition: self currentIndex - 1 ].
	^ true
]

{ #category : #accessing }
ToListSelectionModelOperator >> itemCount [

	^ self dataSource itemCount
]

{ #category : #'private - operations' }
ToListSelectionModelOperator >> markPointedPosition: anInteger [

	self selectionModel markPointedPosition: anInteger
]

{ #category : #'private - operations' }
ToListSelectionModelOperator >> pivot [

	^ self selectionModel pivot
]

{ #category : #'private - operations' }
ToListSelectionModelOperator >> pivot: anIndex [

	self selectionModel pivot: anIndex
]

{ #category : #operations }
ToListSelectionModelOperator >> selectNext [

	self goTowardNext ifTrue: [ self selectOnlyIndex: self currentIndex ]
]

{ #category : #operations }
ToListSelectionModelOperator >> selectOrDeselectNext [

	self currentIndex < self itemCount ifFalse: [ ^ self ].
	self selectOrDeselectWithGap: 1
]

{ #category : #operations }
ToListSelectionModelOperator >> selectOrDeselectPrevious [

	self currentIndex <= 1 ifTrue: [ ^ self ].
	self selectOrDeselectWithGap: -1
]

{ #category : #'private - operations' }
ToListSelectionModelOperator >> selectOrDeselectWithGap: aGap [

	| nextIdx prevDistance deselect currDistance |
	self checkPivot.

	prevDistance := self distance.
	nextIdx := self currentIndex + aGap.
	self distance: self pivot - nextIdx.

	deselect := prevDistance abs - self distance abs ~= -1.
	deselect
		ifTrue: [
			| idx |
			idx := nextIdx - aGap.
			currDistance := self distance.
			self deselectIndex: idx.
			self distance: currDistance ]
		ifFalse: [
			[
			currDistance := self distance.
			self selectIndex: nextIdx.
			self distance: currDistance.
			nextIdx < self itemCount and: [
				nextIdx > 1 and: [ self selectionModel containsIndex: nextIdx + aGap ] ] ] whileTrue: [
				nextIdx := nextIdx + aGap.
				self distance: self distance - aGap ] ].

	self currentIndex: nextIdx
]

{ #category : #operations }
ToListSelectionModelOperator >> selectPrevious [

	self goTowardPrevious ifTrue: [
		self selectOnlyIndex: self currentIndex ]
]

{ #category : #operations }
ToListSelectionModelOperator >> selectToIndex: index [

	| curr |
	curr := self currentIndex.
	self selectIndex: curr to: index.
	self markPointedPosition: index.
	self pivot: curr.
	self distance: index - curr.
]
