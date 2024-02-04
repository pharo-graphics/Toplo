Class {
	#name : #ToListSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'private - command handling' }
ToListSelectionModelOperator >> addIndexesSelectionCommand: aCommand [

	self markPointedPosition: aCommand indexes first
]

{ #category : #'private - command handling' }
ToListSelectionModelOperator >> addIntervalSelectionCommand: aCommand [

	self markPointedPosition: aCommand interval last
]

{ #category : #operations }
ToListSelectionModelOperator >> addOrRemoveNext [

	self currentIndex < self itemCount ifFalse: [ ^ self ].
	self addOrRemoveWithGap: 1
]

{ #category : #operations }
ToListSelectionModelOperator >> addOrRemovePrevious [

	self currentIndex <= 1 ifTrue: [ ^ self ].
	self addOrRemoveWithGap: -1
]

{ #category : #'private - operations' }
ToListSelectionModelOperator >> addOrRemoveWithGap: aGap [

	| nextIdx prevDistance deselect |
	self checkPivot.

	prevDistance := self distance.
	nextIdx := self currentIndex + aGap.
	self distance: self pivot - nextIdx.

	deselect := prevDistance abs - self distance abs ~= -1.
	deselect
		ifTrue: [
			| idx |
			idx := nextIdx - aGap.
			self deselectIndex: idx ]
		ifFalse: [
			[
			self selectIndex: nextIdx.
			nextIdx < self itemCount and: [
				nextIdx > 1 and: [ self selectionModel containsIndex: nextIdx + aGap ] ] ] whileTrue: [
				nextIdx := nextIdx + aGap.
				self distance: self distance - aGap ] ].

	self currentIndex: nextIdx
]

{ #category : #'private - command handling' }
ToListSelectionModelOperator >> addWholeSelectionCommand: aCommand [

	self markPointedPosition: 0
]

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

	" pivot and distance are used for shift-arrow-up and down management "
	self pivot: nil.
	self distance: nil.
	self currentIndex: anInteger.

]

{ #category : #'event dispatching' }
ToListSelectionModelOperator >> onSelectionRequestSuccess: aSelectionRequestEvent [

	super onSelectionRequestSuccess: aSelectionRequestEvent.
	aSelectionRequestEvent command applyOn: self
]

{ #category : #'private - operations' }
ToListSelectionModelOperator >> pivot [

	^ self selectionModel pivot
]

{ #category : #'private - operations' }
ToListSelectionModelOperator >> pivot: anIndex [

	self selectionModel pivot: anIndex
]

{ #category : #'private - command handling' }
ToListSelectionModelOperator >> removeIndexesSelectionCommand: aCommand [

	self markPointedPosition: aCommand indexes first
]

{ #category : #'private - command handling' }
ToListSelectionModelOperator >> removeIntervalSelectionCommand: aCommand [

	self markPointedPosition: aCommand interval first
]

{ #category : #'private - command handling' }
ToListSelectionModelOperator >> removeWholeSelectionCommand: aCommand [

	self markPointedPosition: 0
]

{ #category : #operations }
ToListSelectionModelOperator >> selectNext [

	self goTowardNext ifTrue: [ self selectOnlyIndex: self currentIndex ]
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
	self markPointedPosition: index.
	self pivot: curr.
	self distance: index - curr.
	curr < index
		ifTrue: [ self selectIndex: curr - 1 to: index ]
		ifFalse: [ self selectIndex: index - 1 to: curr ]
]
