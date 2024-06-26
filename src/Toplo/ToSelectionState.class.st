Class {
	#name : #ToSelectionState,
	#superclass : #ToIntrinsicState,
	#instVars : [
		'selected',
		'focused'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #accessing }
ToSelectionState >> focused [

	^ focused
]

{ #category : #accessing }
ToSelectionState >> focused: aBoolean [

	focused := aBoolean
]

{ #category : #accessing }
ToSelectionState >> lookEventClass [

	^ self selected
		  ifTrue: [ ToSelectedSkinEvent ]
		  ifFalse: [ ToDeselectedSkinEvent ]
]

{ #category : #accessing }
ToSelectionState >> selected [

	^ selected
]

{ #category : #accessing }
ToSelectionState >> selected: aBoolean [

	selected := aBoolean
]
