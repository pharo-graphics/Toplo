Class {
	#name : 'ToSelectionState',
	#superclass : 'ToIntrinsicState',
	#instVars : [
		'selected'
	],
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToSelectionState >> lookEventClass [

	^ self selected
		  ifTrue: [ ToSelectedLookEvent ]
		  ifFalse: [ ToDeselectedLookEvent ]
]

{ #category : 'accessing' }
ToSelectionState >> selected [

	^ selected
]

{ #category : 'accessing' }
ToSelectionState >> selected: anObject [

	selected := anObject
]
