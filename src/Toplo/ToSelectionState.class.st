Class {
	#name : 'ToSelectionState',
	#superclass : 'ToIntrinsicState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToSelectionState >> lookEventClass [

	^ self rawState
		  ifTrue: [ ToSelectedLookEvent ]
		  ifFalse: [ ToDeselectedLookEvent ]
]
