Class {
	#name : 'ToElementWithPlaceholderForTest',
	#superclass : 'BlElement',
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#category : 'Toplo-Tests-Core',
	#package : 'Toplo-Tests',
	#tag : 'Core'
}

{ #category : 't - element with placeholder' }
ToElementWithPlaceholderForTest >> newPlaceholder [

	^ self placeholderClass new
]
