Class {
	#name : 'ToHoveredState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToHoveredState >> lookEventClass [

	^ ToHoveredLookEvent
]
