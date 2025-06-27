Class {
	#name : #ToIcon,
	#superclass : #ToElement,
	#traits : 'TToImageHolder',
	#classTraits : 'TToImageHolder classTrait',
	#category : #'Toplo-Widget-Image-Core'
}

{ #category : #'t - image holder - initialization' }
ToIcon >> defaultLayout [

	^ BlLinearLayout new 
]

{ #category : #initialization }
ToIcon >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self fitContent.

	self initializeAsImageHolder 
]
