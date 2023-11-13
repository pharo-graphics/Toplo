Class {
	#name : 'ToCheckState',
	#superclass : 'ToIntrinsicState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToCheckState >> lookEventClass [

	^ self rawState ifNil: [ ToIndeterminateLookEvent ] ifNotNil: [ :rs |
		  rs
			  ifTrue: [ ToCheckedLookEvent ]
			  ifFalse: [ ToUncheckedLookEvent ] ]
]
