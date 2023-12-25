Class {
	#name : #ToElementWithPlaceholderForTest,
	#superclass : #BlElement,
	#traits : 'TToElementWithPlaceholder',
	#classTraits : 'TToElementWithPlaceholder classTrait',
	#category : 'Toplo-Tests-Core'
}

{ #category : #'t - element with placeholder' }
ToElementWithPlaceholderForTest >> newPlaceholder [

	^ self placeholderClass new
]
