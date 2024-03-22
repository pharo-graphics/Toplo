Class {
	#name : #ToListStandardSelectionModel,
	#superclass : #ToListSelectionModel,
	#instVars : [
		'unselectableSelecter',
		'disabledSelecter',
		'hiddenSelecter'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToListStandardSelectionModel >> disabledSelecter [

	^ disabledSelecter
]

{ #category : #accessing }
ToListStandardSelectionModel >> disabledSelectionModel [

	^ self disabledSelecter selectionModel
]

{ #category : #accessing }
ToListStandardSelectionModel >> hiddenSelecter [

	^ hiddenSelecter
]

{ #category : #accessing }
ToListStandardSelectionModel >> hiddenSelectionModel [

	^ self hiddenSelecter selectionModel
]

{ #category : #testing }
ToListStandardSelectionModel >> isUnselectableIndex: anIndex [

	^ (self unselectableSelectionModel containsIndex: anIndex) or: [
		  self hiddenSelectionModel containsIndex: anIndex ]
]

{ #category : #accessing }
ToListStandardSelectionModel >> nextSelectableIndexStartingAt: anIndex [

	(self unselectableSelectionModel isEmpty and: [
		 self hiddenSelectionModel isEmpty ]) ifTrue: [
		^ super nextSelectableIndexStartingAt: anIndex ].

	anIndex to: self itemCount do: [ :idx |
		((self unselectableSelectionModel containsIndex: idx) or: [
			 self hiddenSelectionModel containsIndex: idx ]) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #accessing }
ToListStandardSelectionModel >> previousSelectableIndexStartingAt: anIndex [

	(self unselectableSelectionModel isEmpty and: [
		 self hiddenSelectionModel isEmpty ]) ifTrue: [
		^ super previousSelectableIndexStartingAt: anIndex ].

	anIndex to: 1 by: -1 do: [ :idx |
		((self unselectableSelectionModel containsIndex: idx) or: [
			 self hiddenSelectionModel containsIndex: idx ]) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #updating }
ToListStandardSelectionModel >> selectIndex: anIndex [

	(self unselectableSelectionModel containsIndex: anIndex) ifTrue: [ ^ self ].
	super selectIndex: anIndex
]

{ #category : #updating }
ToListStandardSelectionModel >> selectIndex: aFirstIndex to: aSecondIndex [

	super selectIndex: aFirstIndex to: aSecondIndex.
	aFirstIndex to: aSecondIndex do: [ :idx |
		(self unselectableSelectionModel containsIndex: idx) ifTrue: [
			self deselectIndex: idx ] ]
]

{ #category : #updating }
ToListStandardSelectionModel >> shift: aGap from: aStartIndex for: anEventTarget [

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

{ #category : #accessing }
ToListStandardSelectionModel >> unselectableSelecter [

	^ unselectableSelecter
]

{ #category : #accessing }
ToListStandardSelectionModel >> unselectableSelectionModel [

	^ self unselectableSelecter selectionModel
]
