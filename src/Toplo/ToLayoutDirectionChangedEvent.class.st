Class {
	#name : 'ToLayoutDirectionChangedEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'sending' }
ToLayoutDirectionChangedEvent >> sendTo: anObject [

	anObject layoutDirectionChangedEvent: self
]
