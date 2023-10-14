Class {
	#name : 'ToPlaceholderLayer',
	#superclass : 'BlOverlayElement',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'converting' }
ToPlaceholderLayer >> asPlaceholderLayer [

	^ self
]

{ #category : 'initialization' }
ToPlaceholderLayer >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self preventMouseEvents.

]
