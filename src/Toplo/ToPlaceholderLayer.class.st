Class {
	#name : 'ToPlaceholderLayer',
	#superclass : 'BlOverlayElement',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'initialization' }
ToPlaceholderLayer >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self preventMouseEvents.

]
