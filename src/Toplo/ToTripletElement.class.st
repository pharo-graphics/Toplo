Class {
	#name : #ToTripletElement,
	#superclass : #ToTripletContainer,
	#traits : 'TToTripletElement',
	#classTraits : 'TToTripletElement classTrait',
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToTripletElement >> initialize [ 

	super initialize.
	self initializeAsTripletElement
]

{ #category : #configuration }
ToTripletElement >> newToConfiguration [ 

	^ ToTripletElementConfiguration new
]
