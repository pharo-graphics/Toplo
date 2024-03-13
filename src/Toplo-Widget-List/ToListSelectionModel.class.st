Class {
	#name : #ToListSelectionModel,
	#superclass : #ToBasicListSelectionModel,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToListSelectionModel >> disabledSelectionModel [

	^ listElement disabledSelectionModel
]

{ #category : #testing }
ToListSelectionModel >> hasUnselectableInInterval: anInterval [

	^ anInterval anySatisfy: [ :idx | self unselectableSelectionModel containsIndex: idx ]

]

{ #category : #testing }
ToListSelectionModel >> isUnselectableIndex: anIndex [

	^ self unselectableSelectionModel containsIndex: anIndex

]

{ #category : #accessing }
ToListSelectionModel >> nextSelectableIndexStartingAt: anIndex [

	self unselectableSelectionModel ifEmpty: [
		^ super nextSelectableIndexStartingAt: anIndex ].
	anIndex to: self unselectableSelectionModel itemCount do: [ :idx |
		(self unselectableSelectionModel containsIndex: idx) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #'api - hooks' }
ToListSelectionModel >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	listElement := aListElement
]

{ #category : #'api - hooks' }
ToListSelectionModel >> onUninstalledIn: aListElement [ 

	listElement := nil.
	super onUninstalledIn: aListElement.

]

{ #category : #accessing }
ToListSelectionModel >> previousSelectableIndexStartingAt: anIndex [

	self unselectableSelectionModel ifEmpty: [
		^ super previousSelectableIndexStartingAt: anIndex ].

	anIndex to: 1 by: -1 do: [ :idx |
		(self unselectableSelectionModel containsIndex: idx) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #updating }
ToListSelectionModel >> selectIndex: anIndex [

	(self unselectableSelectionModel containsIndex: anIndex) ifTrue: [ ^ self ].
	super selectIndex: anIndex
]

{ #category : #updating }
ToListSelectionModel >> selectIndex: aFirstIndex to: aSecondIndex [

	super selectIndex: aFirstIndex to: aSecondIndex.
	aFirstIndex to: aSecondIndex do: [ :idx |
		(self unselectableSelectionModel containsIndex: idx) ifTrue: [
			self deselectIndex: idx ] ]
]

{ #category : #updating }
ToListSelectionModel >> shift: aGap from: aStartIndex for: anEventTarget [

	(aGap < 0 and: [ self itemCount >= aStartIndex ]) ifTrue: [
		| count |
		count := aGap abs.
		self disabledSelectionModel
			deselectIndex: aStartIndex
			to: aStartIndex + count - 1.
		self deselectIndex: aStartIndex to: aStartIndex + count - 1 ].
	self unselectableSelectionModel shift: aGap from: aStartIndex.
	self disabledSelectionModel shift: aGap from: aStartIndex.
	
	" ** super send after **"
	super shift: aGap from: aStartIndex for: anEventTarget.

]

{ #category : #accessing }
ToListSelectionModel >> unselectableSelectionModel [

	^ listElement unselectableSelectionModel
]
