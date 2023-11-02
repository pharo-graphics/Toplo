Class {
	#name : 'ToSkinnableProperty',
	#superclass : 'ToPseudoProperty',
	#category : 'Toplo-Core-Properties',
	#package : 'Toplo',
	#tag : 'Core-Properties'
}

{ #category : 'operating' }
ToSkinnableProperty >> write: anPropertyValue to: anObject [

	| prev r |
	prev := self read: anObject.

	" change the property value actually "
	r := super write: anPropertyValue to: anObject.
	(prev ~= r) ifTrue: [ anObject requestSkin ].

	^ r
]
