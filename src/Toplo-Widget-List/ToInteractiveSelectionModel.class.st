Class {
	#name : #ToInteractiveSelectionModel,
	#superclass : #ToSelectionModel,
	#instVars : [
		'unselectableSelectionModel',
		'disabledSelectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToInteractiveSelectionModel >> disabledSelectionModel [

	^ disabledSelectionModel
]

{ #category : #accessing }
ToInteractiveSelectionModel >> disabledSelectionModel: aSelectionModel [

	disabledSelectionModel := aSelectionModel
]

{ #category : #testing }
ToInteractiveSelectionModel >> hasUnselectableInInterval: anInterval [

	^ anInterval anySatisfy: [ :idx | unselectableSelectionModel containsIndex: idx ]

]

{ #category : #testing }
ToInteractiveSelectionModel >> isUnselectableIndex: anIndex [

	^ unselectableSelectionModel containsIndex: anIndex

]

{ #category : #accessing }
ToInteractiveSelectionModel >> nextSelectableIndexStartingAt: anIndex [

	unselectableSelectionModel ifEmpty: [
		^ super nextSelectableIndexStartingAt: anIndex ].
	anIndex to: unselectableSelectionModel itemCount do: [ :idx |
		(unselectableSelectionModel containsIndex: idx) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #'api - hooks' }
ToInteractiveSelectionModel >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self unselectableSelectionModel: anElement unselectableSelectionModel.
	self disabledSelectionModel: anElement disabledSelectionModel
]

{ #category : #'api - hooks' }
ToInteractiveSelectionModel >> onUninstalledIn: anElement [ 

	unselectableSelectionModel := nil.
	super onUninstalledIn: anElement.

]

{ #category : #accessing }
ToInteractiveSelectionModel >> previousSelectableIndexStartingAt: anIndex [
	unselectableSelectionModel ifEmpty: [
		^ super previousSelectableIndexStartingAt: anIndex ].

	anIndex to: 1 by: -1 do: [ :idx |
		(unselectableSelectionModel containsIndex: idx) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #updating }
ToInteractiveSelectionModel >> selectIndex: anIndex [

	(self unselectableSelectionModel containsIndex: anIndex) ifTrue: [ ^ self ].
	super selectIndex: anIndex
]

{ #category : #updating }
ToInteractiveSelectionModel >> selectIndex: aFirstIndex to: aSecondIndex [

	super selectIndex: aFirstIndex to: aSecondIndex.
	aFirstIndex to: aSecondIndex do: [ :idx |
		(self unselectableSelectionModel containsIndex: idx) ifTrue: [
			self deselectIndex: idx ] ]
]

{ #category : #updating }
ToInteractiveSelectionModel >> shift: aGap from: aStartIndex for: anEventTarget [

	(aGap < 0 and: [ self itemCount >= aStartIndex ]) ifTrue: [
		| count |
		count := aGap abs.
		disabledSelectionModel
			deselectIndex: aStartIndex
			to: aStartIndex + count - 1.
		self deselectIndex: aStartIndex to: aStartIndex + count - 1 ].
	unselectableSelectionModel shift: aGap from: aStartIndex.
	disabledSelectionModel shift: aGap from: aStartIndex.
	super shift: aGap from: aStartIndex for: anEventTarget.

]

{ #category : #accessing }
ToInteractiveSelectionModel >> unselectableSelectionModel [

	^ unselectableSelectionModel
]

{ #category : #accessing }
ToInteractiveSelectionModel >> unselectableSelectionModel: aSelectionModel [

	unselectableSelectionModel := aSelectionModel
]
