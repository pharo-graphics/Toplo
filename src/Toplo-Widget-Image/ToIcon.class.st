Class {
	#name : #ToIcon,
	#superclass : #ToElement,
	#traits : 'TToImageHolder',
	#classTraits : 'TToImageHolder classTrait',
	#category : #'Toplo-Widget-Image-Core'
}

{ #category : #'t - labeled icon' }
ToIcon class >> iconImage: anInnerImage [

	^ self innerImage: anInnerImage
]

{ #category : #initialization }
ToIcon >> defaultLayout [

	^ BlLinearLayout new 
]

{ #category : #'t - labeled icon' }
ToIcon >> iconImage: anInnerImage [

	self innerImage: anInnerImage
]

{ #category : #initialization }
ToIcon >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self fitContent.

	self initializeAsImageHolder 
]
