Class {
	#name : 'ToCheckState',
	#superclass : 'ToPersistentState',
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
