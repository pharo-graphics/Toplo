Class {
	#name : 'ToLayoutConstraintsChangedEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'sending' }
ToLayoutConstraintsChangedEvent >> sendTo: anObject [

	anObject layoutConstraintsChangedEvent: self
]
