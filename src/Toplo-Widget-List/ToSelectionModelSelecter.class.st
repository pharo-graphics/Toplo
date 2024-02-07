Class {
	#name : #ToSelectionModelSelecter,
	#superclass : #Object,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'operator',
		'target',
		'currentIndex'
	],
	#category : #'Toplo-Widget-List-Selection-Updater'
}

{ #category : #adding }
ToSelectionModelSelecter >> addCommand: aCommand [

	self operator addCommand: aCommand
]

{ #category : #'command application' }
ToSelectionModelSelecter >> apply [

	self operator applyOn: self target
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
	self currentIndex: 0.
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectAllIndexes: anArray [

	self operator deselectAllIndexes: anArray.
	self currentIndex: anArray first
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndex: anIndex [

	self operator deselectIndex: anIndex.
	self currentIndex: anIndex
]

{ #category : #private }
ToSelectionModelSelecter >> goTowardNext [ 

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ false ].
			self currentIndex: 1 ]
		ifFalse: [
			self currentIndex < self itemCount ifFalse: [
				self currentIndex: 1.
				^ true ].
			self currentIndex: self currentIndex + 1 ].
	^ true
]

{ #category : #private }
ToSelectionModelSelecter >> goTowardPrevious [

	self currentIndex isZero
		ifTrue: [
			self itemCount isZero ifTrue: [ ^ false ].
			self currentIndex: self itemCount ]
		ifFalse: [
			self currentIndex > 1 ifFalse: [
				self currentIndex: self itemCount.
				^ true ].
			self currentIndex: self currentIndex - 1 ].
	^ true
]

{ #category : #initialization }
ToSelectionModelSelecter >> initialize [ 

	super initialize.
	currentIndex := 0
]

{ #category : #accessing }
ToSelectionModelSelecter >> itemCount [

	^ self selectionModel itemCount
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

{ #category : #operations }
ToSelectionModelSelecter >> selectAll [

	self operator selectAll.
	self currentIndex: 0
]

{ #category : #operations }
ToSelectionModelSelecter >> selectAllIndexes: anArray [

	self operator selectAllIndexes: anArray.
	self currentIndex: anArray first
]

{ #category : #operations }
ToSelectionModelSelecter >> selectIndex: anIndex [

	self operator selectIndex: anIndex.
	self currentIndex: anIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self operator selectIndex: aStartIndex to: anEndIndex.
	self currentIndex: anEndIndex
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectNext [

	self goTowardNext ifTrue: [ self selectOnlyIndex: self currentIndex ]
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectNextIn: anElement event: aShortcutEvent [

	self selectNext.
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndex: anIndex [

	self operator selectOnlyIndex: anIndex.
	self currentIndex: anIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndexes: anArray [

	self operator selectOnlyIndexes: anArray.
	self currentIndex: anArray first
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectOrDeselectNext [

	self currentIndex < self itemCount ifFalse: [ ^ self ].
	self selectWithGap: 1.
	self apply
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectOrDeselectNextIn: anElement event: aShortcutEvent [

	self selectOrDeselectNext.
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectOrDeselectPrevious [

	self currentIndex <= 1 ifTrue: [ ^ self ].
	self selectWithGap: -1.
	self apply.

]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectOrDeselectPreviousIn: anElement event: aShortcutEvent [

	self selectOrDeselectPrevious.
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectPrevious [

	self goTowardPrevious ifTrue: [ self selectOnlyIndex: self currentIndex ]
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectPreviousIn: anElement event: aShortcutEvent [

	self selectPrevious.
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #'shortcuts operations' }
ToSelectionModelSelecter >> selectToIndex: index [

	| curr |
	curr := self currentIndex.
	self selectIndex: curr to: index.
	self currentIndex: index
]

{ #category : #private }
ToSelectionModelSelecter >> selectWithGap: aGap [

	| nextIdx |
	nextIdx := self currentIndex + aGap.
	[
	self selectIndex: nextIdx.
	nextIdx < self itemCount and: [
		nextIdx > 1 and: [
			self selectionModel containsIndex: nextIdx + aGap ] ] ] whileTrue: [
		nextIdx := nextIdx + aGap ].
	self currentIndex: nextIdx
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
