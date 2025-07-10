Class {
	#name : #ToSelectionState,
	#superclass : #ToIntrinsicState,
	#instVars : [
		'selected',
		'focused',
		'selectionOption'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToSelectionState >> applyOn: anElement fromQueue: aQueue [

	anElement
		withAllChildrenBreadthFirstDo: [ :child |
				| se |
				se := self skinEvent.
				child spaceDo: [ :sp | se fillFromTime: child space time ].
				child dispatchEvent: se.
				self onAppliedOn: child fromQueue: aQueue ]
		while: [ :child | child selectionSkinEventsPrevented not ]
]

{ #category : #accessing }
ToSelectionState >> focused [

	^ focused
]

{ #category : #accessing }
ToSelectionState >> focused: aBoolean [

	focused := aBoolean
]

{ #category : #accessing }
ToSelectionState >> selected [

	^ selected
]

{ #category : #accessing }
ToSelectionState >> selected: aBoolean [

	selected := aBoolean
]

{ #category : #accessing }
ToSelectionState >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToSelectionState >> selectionOption: aSelectionElementOption [

	selectionOption := aSelectionElementOption
]

{ #category : #accessing }
ToSelectionState >> skinEventClass [

	^ self selected
		  ifTrue: [ ToSelectedSkinEvent ]
		  ifFalse: [ ToDeselectedSkinEvent ]
]
