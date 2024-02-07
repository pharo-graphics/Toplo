Class {
	#name : #ToSelectionModelSelecter,
	#superclass : #Object,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'operator',
		'target',
		'currentIndex',
		'distance',
		'pivot',
		'selectionCommandChecker'
	],
	#category : #'Toplo-Widget-List-Selection-Updater'
}

{ #category : #adding }
ToSelectionModelSelecter >> addCommand: aCommand [

	self operator addCommand: aCommand
]

{ #category : #'command application' }
ToSelectionModelSelecter >> apply [

	self selectionCommandChecker ifNotNil: [ :checker |
		operator command ifNotNil: [ :c | c applyOn: checker ] ].
	self operator applyOn: self target
]

{ #category : #private }
ToSelectionModelSelecter >> checkPivot [

	self pivot ifNil: [
		self pivot: self currentIndex.
		self distance: 0 ]
]

{ #category : #accessing }
ToSelectionModelSelecter >> currentIndex [

	^ currentIndex
]

{ #category : #accessing }
ToSelectionModelSelecter >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectAll [

	self operator deselectAll.
	self markPointedPosition: 0
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectAllIndexes: anArray [

	self operator deselectAllIndexes: anArray.
	self markPointedPosition: anArray first
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndex: anIndex [

	self operator deselectIndex: anIndex.
	self markPointedPosition: anIndex
]

{ #category : #accessing }
ToSelectionModelSelecter >> distance [

	^ distance
]

{ #category : #accessing }
ToSelectionModelSelecter >> distance: anInteger [

	distance := anInteger
]

{ #category : #private }
ToSelectionModelSelecter >> goTowardNext [ 

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

{ #category : #private }
ToSelectionModelSelecter >> goTowardPrevious [

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
ToSelectionModelSelecter >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #private }
ToSelectionModelSelecter >> markPointedPosition: anInteger [

	" pivot and distance are used for shift-arrow-up and down management "
	self pivot: nil.
	self distance: nil.
	self currentIndex: anInteger.

]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onInstalledIn: anEventTarget [

	self target: anEventTarget.
	self operator: anEventTarget selectionModel newOperator.
	self operator requester: anEventTarget

]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onUninstalledIn: anEventTarget [

	self operator requester: nil.
	self operator: nil.
	self target: nil.

	

]

{ #category : #accessing }
ToSelectionModelSelecter >> operator [

	^ operator
]

{ #category : #accessing }
ToSelectionModelSelecter >> operator: aSelectionModelOperator [

	operator := aSelectionModelOperator
]

{ #category : #accessing }
ToSelectionModelSelecter >> pivot [

	^ pivot
]

{ #category : #accessing }
ToSelectionModelSelecter >> pivot: anInteger [

	pivot := anInteger
]

{ #category : #operations }
ToSelectionModelSelecter >> selectAll [

	self operator selectAll.
	self markPointedPosition: 0
]

{ #category : #operations }
ToSelectionModelSelecter >> selectAllIndexes: anArray [

	self operator selectAllIndexes: anArray.
	self markPointedPosition: anArray first
]

{ #category : #operations }
ToSelectionModelSelecter >> selectIndex: anIndex [

	self operator selectIndex: anIndex.
	self markPointedPosition: anIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self operator selectIndex: aStartIndex to: anEndIndex.
	self markPointedPosition: anEndIndex
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectNextIn: anElement event: aShortcutEvent [

	self goTowardNext ifTrue: [
		self selectOnlyIndex: self currentIndex ].
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndex: anIndex [

	self operator selectOnlyIndex: anIndex.
	self markPointedPosition: anIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndexes: anArray [

	self operator selectOnlyIndexes: anArray.
	self markPointedPosition: anArray first
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectOrDeselectNextIn: anElement event: aShortcutEvent [

	self currentIndex < self itemCount ifFalse: [ ^ self ].
	self selectOrDeselectWithGap: 1.
	self apply.
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectOrDeselectPreviousIn: anElement event: aShortcutEvent [

	self currentIndex <= 1 ifTrue: [ ^ self ].
	self selectOrDeselectWithGap: -1.
	self apply.
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #private }
ToSelectionModelSelecter >> selectOrDeselectWithGap: aGap [

	| nextIdx prevDistance deselect currDistance |
	self checkPivot.

	prevDistance := self distance.
	nextIdx := self currentIndex + aGap.
	self distance: self pivot - nextIdx.

	deselect := (prevDistance abs - self distance abs) ~= -1.
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

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectPreviousIn: anElement event: aShortcutEvent [

	self goTowardPrevious ifTrue: [
		self selectOnlyIndex: self currentIndex ].
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectToIndex: index [

	| curr |
	curr := self currentIndex.
	self selectIndex: curr to: index.
	self markPointedPosition: index.
	self pivot: curr.
	self distance: index - curr.
]

{ #category : #accessing }
ToSelectionModelSelecter >> selectionCommandChecker [

	^ selectionCommandChecker 
]

{ #category : #accessing }
ToSelectionModelSelecter >> selectionCommandChecker: aSelectionCommandChecker [

	selectionCommandChecker := aSelectionCommandChecker
]

{ #category : #accessing }
ToSelectionModelSelecter >> selectionModel [

	^ self target selectionModel
]

{ #category : #accessing }
ToSelectionModelSelecter >> target [

	^ target
]

{ #category : #accessing }
ToSelectionModelSelecter >> target: anEventTarget [

	target := anEventTarget
]
