Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToClickable',
	#classTraits : 'TToClickable classTrait',
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #initialization }
ToGeneralButton >> defaultBackground [

	^ Color transparent 
]

{ #category : #initialization }
ToGeneralButton >> defaultBorder [

	^ Color transparent 
]

{ #category : #initialization }
ToGeneralButton >> defaultEventHandler [ 

	^ ToSkinnableEventHandler new 
]

{ #category : #initialization }
ToGeneralButton >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 4 
]

{ #category : #initialization }
ToGeneralButton >> defaultPadding [

	^ BlInsets
		  top: 5
		  left: 10
		  bottom: 5
		  right: 10
]

{ #category : #initialization }
ToGeneralButton >> hoveredBackground [

	^ Color transparent 
]

{ #category : #initialization }
ToGeneralButton >> hoveredBorder [

	^ Color lightGray alpha: 0.2 
]

{ #category : #initialization }
ToGeneralButton >> initialize [

	super initialize.
	self addEventHandler: self defaultEventHandler
]

{ #category : #skin }
ToGeneralButton >> initializeRawStyle [ 

	super initializeRawStyle.
	self padding: self defaultPadding.
	self geometry: self defaultGeometry.
	self border: self defaultBorder
]

{ #category : #initialization }
ToGeneralButton >> pressedBackground [

	^ Color transparent 
]

{ #category : #initialization }
ToGeneralButton >> pressedBorder [

	^ Color lightGray alpha: 0.6 
]

{ #category : #skin }
ToGeneralButton >> rawSkin [

	^ ToGeneralButtonSkin new
]
