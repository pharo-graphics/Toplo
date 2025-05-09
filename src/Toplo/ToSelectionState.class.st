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
