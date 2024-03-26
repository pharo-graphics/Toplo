Class {
	#name : #ToListElementSelectionModel,
	#superclass : #ToSelectionModel,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToListElementSelectionModel >> additionalSelectionModels [

	^ self subclassResponsibility 
]

{ #category : #copying }
ToListElementSelectionModel >> copySelectionFrom: anotherSelectionModel [

	super copySelectionFrom: anotherSelectionModel.
	self unselectableSelectionModelDo: [ :sm |
		sm copySelectionFrom:
			anotherSelectionModel unselectableSelectionModel ].
	self disabledSelectionModelDo: [ :sm |
		sm copySelectionFrom: anotherSelectionModel disabledSelectionModel ].
	self hiddenSelectionModelDo: [ :sm |
		sm copySelectionFrom: anotherSelectionModel hiddenSelectionModel ]
]

{ #category : #updating }
ToListElementSelectionModel >> disableIndex: anIndex [

	self disabledSelectionModelDo: [ :sm | sm selectIndex: anIndex ]
]

{ #category : #accessing }
ToListElementSelectionModel >> disabledSelectionModel [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToListElementSelectionModel >> disabledSelectionModelDo: aBlock [

	self disabledSelectionModel ifNil: [ ^ self ].
	aBlock value: self disabledSelectionModel
]

{ #category : #updating }
ToListElementSelectionModel >> enableAll [

	self disabledSelectionModelDo: [ :sm | sm deselectAll ]
]

{ #category : #updating }
ToListElementSelectionModel >> enableIndex: anIndex [

	self disabledSelectionModelDo: [ :sm | sm deselectIndex: anIndex ]
]

{ #category : #testing }
ToListElementSelectionModel >> hasUnselectableInInterval: anInterval [

	self unselectableSelectionModelDo: [ :sm |
		^ anInterval anySatisfy: [ :idx | sm containsIndex: idx ] ].
	^ super hasUnselectableInInterval: anInterval
]

{ #category : #accessing }
ToListElementSelectionModel >> hiddenSelectionModel [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToListElementSelectionModel >> hiddenSelectionModelDo: aBlock [

	self hiddenSelectionModel ifNil: [ ^ self ].
	aBlock value: self hiddenSelectionModel
]

{ #category : #updating }
ToListElementSelectionModel >> hideIndex: anIndex [

	self hiddenSelectionModelDo: [ :sm | sm selectIndex: anIndex ]
]

{ #category : #updating }
ToListElementSelectionModel >> hideOnlyIndexes: aCollection [

	self hiddenSelectionModelDo: [ :sm | sm selectOnlyIndexes: aCollection ]
]

{ #category : #testing }
ToListElementSelectionModel >> isDisabledIndex: anIndex [

	self disabledSelectionModelDo: [ :sm | ^ sm containsIndex: anIndex ].
	^ super isDisabledIndex: anIndex
]

{ #category : #testing }
ToListElementSelectionModel >> isHiddenIndex: anIndex [

	self hiddenSelectionModelDo: [ :sm | ^ sm containsIndex: anIndex ].
	^ super isHiddenIndex: anIndex
]

{ #category : #testing }
ToListElementSelectionModel >> isUnselectableIndex: anIndex [

	self unselectableSelectionModelDo: [ :sm |
		^ (sm containsIndex: anIndex) or: [ self isHiddenIndex: anIndex ] ].
	^ super isUnselectableIndex: anIndex
]

{ #category : #accessing }
ToListElementSelectionModel >> nextSelectableIndexStartingAt: anIndex [

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
ToListElementSelectionModel >> otherSelectionModels [

	^ Array streamContents: [ :stream |
		  stream nextPutAll: self standardAdditionalSelectionModels.
		  stream nextPutAll: self additionalSelectionModels ]
]

{ #category : #accessing }
ToListElementSelectionModel >> previousSelectableIndexStartingAt: anIndex [

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
ToListElementSelectionModel >> selectIndex: anIndex [

	self unselectableSelectionModelDo: [ :sm | (sm containsIndex: anIndex) ifTrue: [ ^ self ] ].
	super selectIndex: anIndex
]

{ #category : #updating }
ToListElementSelectionModel >> selectIndex: aFirstIndex to: aSecondIndex [

	self flag: 'To be optimized'.
	super selectIndex: aFirstIndex to: aSecondIndex.
	self unselectableSelectionModelDo: [ :sm |
		aFirstIndex to: aSecondIndex do: [ :idx |
		(sm containsIndex: idx) ifTrue: [ self deselectIndex: idx ] ] ]
]

{ #category : #updating }
ToListElementSelectionModel >> selectableAll [

	self unselectableSelectionModelDo: [ :sm | sm deselectAll ]
]

{ #category : #updating }
ToListElementSelectionModel >> selectableIndex: anIndex [

	self unselectableSelectionModelDo: [ :sm | sm deselectIndex: anIndex ]
]

{ #category : #updating }
ToListElementSelectionModel >> shift: aGap from: aStartIndex for: anEventTarget [

	(aGap < 0 and: [ self itemCount >= aStartIndex ]) ifTrue: [
		| count |
		count := aGap abs.
		self deselectIndex: aStartIndex to: aStartIndex + count - 1 ].
	self otherSelectionModels do: [ :sm |
		sm shift: aGap from: aStartIndex ].

	" ** super send after **"
	super shift: aGap from: aStartIndex for: anEventTarget
]

{ #category : #accessing }
ToListElementSelectionModel >> standardAdditionalSelectionModels [

	^ {
		  self disabledSelectionModel.
		  self hiddenSelectionModel.
		  self unselectableSelectionModel } select: [ :sm | sm notNil ]
]

{ #category : #updating }
ToListElementSelectionModel >> transferIndex: anIndex from: anotherPrimarySelectionModel as: targetIndex [

	super transferIndex: anIndex from: anotherPrimarySelectionModel as: targetIndex.
	anotherPrimarySelectionModel disabledSelectionModelDo: [ :sm | (sm containsIndex: anIndex)
		ifTrue: [ self disabledSelectionModelDo: [ :osm | osm selectIndex: targetIndex ] ]
		ifFalse: [ self disabledSelectionModelDo: [ :osm | osm  deselectIndex: targetIndex ] ] ].
	anotherPrimarySelectionModel unselectableSelectionModelDo: [ :sm | (sm containsIndex: anIndex)
		ifTrue: [ self unselectableSelectionModelDo: [ :osm | osm selectIndex: targetIndex ] ]
		ifFalse: [ self unselectableSelectionModelDo: [ :osm | osm  deselectIndex: targetIndex ] ] ].
	anotherPrimarySelectionModel hiddenSelectionModelDo: [ :sm | (sm containsIndex: anIndex)
		ifTrue: [ self hiddenSelectionModelDo: [ :osm | osm selectIndex: targetIndex ] ]
		ifFalse: [ self hiddenSelectionModelDo: [ :osm | osm  deselectIndex: targetIndex ] ] ]
]

{ #category : #updating }
ToListElementSelectionModel >> unhideAll [

	self hiddenSelectionModelDo: [ :sm | sm deselectAll ]
]

{ #category : #updating }
ToListElementSelectionModel >> unhideIndex: anIndex [

	self hiddenSelectionModelDo: [ :sm | sm deselectIndex: anIndex ]
]

{ #category : #updating }
ToListElementSelectionModel >> unhideIndexes: aCollection [

	self hiddenSelectionModelDo: [ :sm | sm deselectIndexes: aCollection ]
]

{ #category : #updating }
ToListElementSelectionModel >> unselectableIndex: anIndex [

	self unselectableSelectionModelDo: [ :sm | sm selectIndex: anIndex ]
]

{ #category : #accessing }
ToListElementSelectionModel >> unselectableSelectionModel [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToListElementSelectionModel >> unselectableSelectionModelDo: aBlock [

	self unselectableSelectionModel ifNil: [ ^ self ].
	aBlock value: self unselectableSelectionModel
]
