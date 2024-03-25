Class {
	#name : #ToListElementSelectionModel,
	#superclass : #ToSelectionModel,
	#instVars : [
		'disabledSelectionModel',
		'hiddenSelectionModel',
		'unselectableSelectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #copying }
ToListElementSelectionModel >> copySelectionFrom: anotherSelectionModel [

	super copySelectionFrom: anotherSelectionModel.
	self unselectableSelectionModel copySelectionFrom:
		anotherSelectionModel unselectableSelectionModel.
	self disabledSelectionModel copySelectionFrom:
		anotherSelectionModel disabledSelectionModel.
	self hiddenSelectionModel copySelectionFrom:
		anotherSelectionModel hiddenSelectionModel
]

{ #category : #updating }
ToListElementSelectionModel >> disableIndex: anIndex [

	self disabledSelectionModel selectIndex: anIndex
]

{ #category : #accessing }
ToListElementSelectionModel >> disabledSelectionModel [

	^ disabledSelectionModel
]

{ #category : #updating }
ToListElementSelectionModel >> enableAll [

	self disabledSelectionModel deselectAll
]

{ #category : #updating }
ToListElementSelectionModel >> enableIndex: anIndex [

	self disabledSelectionModel deselectIndex: anIndex
]

{ #category : #testing }
ToListElementSelectionModel >> hasUnselectableInInterval: anInterval [

	^ anInterval anySatisfy: [ :idx | self unselectableSelectionModel containsIndex: idx ]

]

{ #category : #accessing }
ToListElementSelectionModel >> hiddenSelectionModel [

	^ hiddenSelectionModel
]

{ #category : #updating }
ToListElementSelectionModel >> hideIndex: anIndex [

	self hiddenSelectionModel selectIndex: anIndex
]

{ #category : #updating }
ToListElementSelectionModel >> hideOnlyIndexes: aCollection [

	self hiddenSelectionModel selectOnlyIndexes: aCollection
]

{ #category : #testing }
ToListElementSelectionModel >> isUnselectableIndex: anIndex [

	^ (self unselectableSelectionModel containsIndex: anIndex) or: [
		  self hiddenSelectionModel containsIndex: anIndex ]
]

{ #category : #accessing }
ToListElementSelectionModel >> nextSelectableIndexStartingAt: anIndex [

	(self unselectableSelectionModel isEmpty and: [
		 self hiddenSelectionModel isEmpty ]) ifTrue: [
		^ super nextSelectableIndexStartingAt: anIndex ].

	anIndex to: self itemCount do: [ :idx |
		((self unselectableSelectionModel containsIndex: idx) or: [
			 self hiddenSelectionModel containsIndex: idx ]) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #accessing }
ToListElementSelectionModel >> previousSelectableIndexStartingAt: anIndex [

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

	(self unselectableSelectionModel containsIndex: anIndex) ifTrue: [ ^ self ].
	super selectIndex: anIndex
]

{ #category : #updating }
ToListElementSelectionModel >> selectIndex: aFirstIndex to: aSecondIndex [

	super selectIndex: aFirstIndex to: aSecondIndex.
	aFirstIndex to: aSecondIndex do: [ :idx |
		(self unselectableSelectionModel containsIndex: idx) ifTrue: [
			self deselectIndex: idx ] ]
]

{ #category : #updating }
ToListElementSelectionModel >> selectableAll [

	self unselectableSelectionModel deselectAll
]

{ #category : #updating }
ToListElementSelectionModel >> selectableIndex: anIndex [

	self unselectableSelectionModel deselectIndex: anIndex
]

{ #category : #updating }
ToListElementSelectionModel >> shift: aGap from: aStartIndex for: anEventTarget [

	(aGap < 0 and: [ self itemCount >= aStartIndex ]) ifTrue: [
		| count |
		count := aGap abs.
		"self disabledSelectionModel
			deselectIndex: aStartIndex
			to: aStartIndex + count - 1."
		self deselectIndex: aStartIndex to: aStartIndex + count - 1 ].
	self unselectableSelectionModel shift: aGap from: aStartIndex.
	self disabledSelectionModel shift: aGap from: aStartIndex.

	" ** super send after **"
	super shift: aGap from: aStartIndex for: anEventTarget
]

{ #category : #updating }
ToListElementSelectionModel >> transferIndex: anIndex from: anotherPrimarySelectionModel as: targetIndex [

	super transferIndex: anIndex from: anotherPrimarySelectionModel as: targetIndex.
	(anotherPrimarySelectionModel disabledSelectionModel containsIndex: anIndex)
		ifTrue: [ self disabledSelectionModel selectIndex: targetIndex ]
		ifFalse: [ self disabledSelectionModel deselectIndex: targetIndex ].
	(anotherPrimarySelectionModel unselectableSelectionModel containsIndex: anIndex)
		ifTrue: [ self unselectableSelectionModel selectIndex: targetIndex ]
		ifFalse: [ self unselectableSelectionModel deselectIndex: targetIndex ].
	(anotherPrimarySelectionModel hiddenSelectionModel containsIndex: anIndex)
		ifTrue: [ self hiddenSelectionModel selectIndex: targetIndex ]
		ifFalse: [ self hiddenSelectionModel deselectIndex: targetIndex ]
]

{ #category : #updating }
ToListElementSelectionModel >> unhideAll [

	self hiddenSelectionModel deselectAll
]

{ #category : #updating }
ToListElementSelectionModel >> unhideIndex: anIndex [

	self hiddenSelectionModel deselectIndex: anIndex
]

{ #category : #updating }
ToListElementSelectionModel >> unhideIndexes: aCollection [

	self hiddenSelectionModel deselectIndexes: aCollection
]

{ #category : #updating }
ToListElementSelectionModel >> unselectableIndex: anIndex [

	self unselectableSelectionModel selectIndex: anIndex
]

{ #category : #accessing }
ToListElementSelectionModel >> unselectableSelectionModel [

	^ unselectableSelectionModel
]
