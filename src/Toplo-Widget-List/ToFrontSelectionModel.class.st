Class {
	#name : #ToFrontSelectionModel,
	#superclass : #ToCompositeSelectionModel,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #updating }
ToFrontSelectionModel >> disableIndex: anIndex [

	self disabledSelectionModelDo: [ :sm | sm selectIndex: anIndex ]
]

{ #category : #accessing }
ToFrontSelectionModel >> disabledSelectionModel [

	^ self subSelectionModelWithId: ToListDisabledSelectionChangedEvent
]

{ #category : #accessing }
ToFrontSelectionModel >> disabledSelectionModelDo: aBlock [

	self disabledSelectionModel ifNil: [ ^ self ].
	aBlock value: self disabledSelectionModel
]

{ #category : #updating }
ToFrontSelectionModel >> enableAll [

	self disabledSelectionModelDo: [ :sm | sm deselectAll ]
]

{ #category : #updating }
ToFrontSelectionModel >> enableIndex: anIndex [

	self disabledSelectionModelDo: [ :sm | sm deselectIndex: anIndex ]
]

{ #category : #accessing }
ToFrontSelectionModel >> hiddenSelectionModel [

	^ self subSelectionModelWithId: ToListHiddenSelectionChangedEvent 
]

{ #category : #accessing }
ToFrontSelectionModel >> hiddenSelectionModelDo: aBlock [

	self hiddenSelectionModel ifNil: [ ^ self ].
	aBlock value: self hiddenSelectionModel
]

{ #category : #updating }
ToFrontSelectionModel >> hideIndex: anIndex [

	self hiddenSelectionModelDo: [ :sm | sm selectIndex: anIndex ]
]

{ #category : #updating }
ToFrontSelectionModel >> hideOnlyIndexes: aCollection [

	self hiddenSelectionModelDo: [ :sm | sm selectOnlyIndexes: aCollection ]
]

{ #category : #testing }
ToFrontSelectionModel >> isDisabledIndex: anIndex [

	self disabledSelectionModelDo: [ :sm | ^ sm containsIndex: anIndex ].
	^ super isDisabledIndex: anIndex
]

{ #category : #testing }
ToFrontSelectionModel >> isHiddenIndex: anIndex [

	self hiddenSelectionModelDo: [ :sm | ^ sm containsIndex: anIndex ].
	^ super isHiddenIndex: anIndex
]

{ #category : #testing }
ToFrontSelectionModel >> isUnselectableIndex: anIndex [

	self unselectableSelectionModelDo: [ :sm |
		^ (sm containsIndex: anIndex) or: [ self isHiddenIndex: anIndex ] ].
	^ super isUnselectableIndex: anIndex
]

{ #category : #accessing }
ToFrontSelectionModel >> nextSelectableIndexStartingAt: anIndex [

	(self unselectableSelectionModel isNil or: [
		 self hiddenSelectionModel isNil ]) ifTrue: [
		^ super nextSelectableIndexStartingAt: anIndex ].
	
	(self unselectableSelectionModel isEmpty and: [
		 self hiddenSelectionModel isEmpty ]) ifTrue: [
		^ super nextSelectableIndexStartingAt: anIndex ].

	anIndex to: self itemCount do: [ :idx |
		((self unselectableSelectionModel containsIndex: idx) or: [
			 self hiddenSelectionModel containsIndex: idx ]) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #accessing }
ToFrontSelectionModel >> previousSelectableIndexStartingAt: anIndex [

	(self unselectableSelectionModel isNil or: [
		 self hiddenSelectionModel isNil ]) ifTrue: [
		^ super previousSelectableIndexStartingAt: anIndex ].

	(self unselectableSelectionModel isEmpty and: [
		 self hiddenSelectionModel isEmpty ]) ifTrue: [
		^ super previousSelectableIndexStartingAt: anIndex ].

	anIndex to: 1 by: -1 do: [ :idx |
		((self unselectableSelectionModel containsIndex: idx) or: [
			 self hiddenSelectionModel containsIndex: idx ]) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #updating }
ToFrontSelectionModel >> selectIndex: anIndex [

	self unselectableSelectionModelDo: [ :sm | (sm containsIndex: anIndex) ifTrue: [ ^ self ] ].
	super selectIndex: anIndex
]

{ #category : #updating }
ToFrontSelectionModel >> selectIndex: aFirstIndex to: aSecondIndex [

	self flag: 'To be optimized'.
	super selectIndex: aFirstIndex to: aSecondIndex.
	self unselectableSelectionModelDo: [ :sm |
		aFirstIndex to: aSecondIndex do: [ :idx |
		(sm containsIndex: idx) ifTrue: [ self deselectIndex: idx ] ] ]
]

{ #category : #updating }
ToFrontSelectionModel >> selectableAll [

	self unselectableSelectionModelDo: [ :sm | sm deselectAll ]
]

{ #category : #updating }
ToFrontSelectionModel >> selectableIndex: anIndex [

	self unselectableSelectionModelDo: [ :sm | sm deselectIndex: anIndex ]
]

{ #category : #updating }
ToFrontSelectionModel >> unhideAll [

	self hiddenSelectionModelDo: [ :sm | sm deselectAll ]
]

{ #category : #updating }
ToFrontSelectionModel >> unhideIndex: anIndex [

	self hiddenSelectionModelDo: [ :sm | sm deselectIndex: anIndex ]
]

{ #category : #updating }
ToFrontSelectionModel >> unhideIndexes: aCollection [

	self hiddenSelectionModelDo: [ :sm | sm deselectIndexes: aCollection ]
]

{ #category : #updating }
ToFrontSelectionModel >> unselectableIndex: anIndex [

	self unselectableSelectionModelDo: [ :sm | sm selectIndex: anIndex ]
]

{ #category : #accessing }
ToFrontSelectionModel >> unselectableSelectionModel [

	^ self subSelectionModelWithId: ToListUnselectableSelectionChangedEvent 
]

{ #category : #accessing }
ToFrontSelectionModel >> unselectableSelectionModelDo: aBlock [

	self unselectableSelectionModel ifNil: [ ^ self ].
	aBlock value: self unselectableSelectionModel
]
