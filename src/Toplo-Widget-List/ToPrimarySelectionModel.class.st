Class {
	#name : #ToPrimarySelectionModel,
	#superclass : #ToSelectionModel,
	#instVars : [
		'unselectableSelectionModel',
		'disabledSelectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToPrimarySelectionModel >> disabledSelectionModel [

	^ disabledSelectionModel
]

{ #category : #accessing }
ToPrimarySelectionModel >> disabledSelectionModel: aSelectionModel [

	disabledSelectionModel := aSelectionModel
]

{ #category : #testing }
ToPrimarySelectionModel >> hasUnselectableInInterval: anInterval [

	^ anInterval anySatisfy: [ :idx | unselectableSelectionModel containsIndex: idx ]

]

{ #category : #testing }
ToPrimarySelectionModel >> isUnselectableIndex: anIndex [

	^ unselectableSelectionModel containsIndex: anIndex

]

{ #category : #accessing }
ToPrimarySelectionModel >> nextSelectableIndexStartingAt: anIndex [

	unselectableSelectionModel ifEmpty: [
		^ super nextSelectableIndexStartingAt: anIndex ].
	anIndex to: unselectableSelectionModel itemCount do: [ :idx |
		(unselectableSelectionModel containsIndex: idx) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #'api - hooks' }
ToPrimarySelectionModel >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self unselectableSelectionModel: anElement unselectableSelectionModel.
	self disabledSelectionModel: anElement disabledSelectionModel
]

{ #category : #'api - hooks' }
ToPrimarySelectionModel >> onUninstalledIn: anElement [ 

	unselectableSelectionModel := nil.
	super onUninstalledIn: anElement.

]

{ #category : #accessing }
ToPrimarySelectionModel >> previousSelectableIndexStartingAt: anIndex [
	unselectableSelectionModel ifEmpty: [
		^ super previousSelectableIndexStartingAt: anIndex ].

	anIndex to: 1 by: -1 do: [ :idx |
		(unselectableSelectionModel containsIndex: idx) ifFalse: [ ^ idx ] ].
	^ 0
]

{ #category : #updating }
ToPrimarySelectionModel >> selectIndex: anIndex [

	(self unselectableSelectionModel containsIndex: anIndex) ifTrue: [ ^ self ].
	super selectIndex: anIndex
]

{ #category : #updating }
ToPrimarySelectionModel >> selectIndex: aFirstIndex to: aSecondIndex [

	super selectIndex: aFirstIndex to: aSecondIndex.
	aFirstIndex to: aSecondIndex do: [ :idx |
		(self unselectableSelectionModel containsIndex: idx) ifTrue: [
			self deselectIndex: idx ] ]
]

{ #category : #updating }
ToPrimarySelectionModel >> shift: aGap from: aStartIndex for: anEventTarget [

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
ToPrimarySelectionModel >> unselectableSelectionModel [

	^ unselectableSelectionModel
]

{ #category : #accessing }
ToPrimarySelectionModel >> unselectableSelectionModel: aSelectionModel [

	unselectableSelectionModel := aSelectionModel
]
