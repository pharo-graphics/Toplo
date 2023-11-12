Class {
	#name : 'ToDisabledState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToDisabledState >> lookEventClass [

	^ ToDisabledLookEvent
]
