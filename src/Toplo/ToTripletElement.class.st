Class {
	#name : #ToTripletElement,
	#superclass : #ToElement,
	#traits : 'TToOrientable + TToTripletElement',
	#classTraits : 'TToOrientable classTrait + TToTripletElement classTrait',
	#category : #'Toplo-Core-Triplet'
}

{ #category : #initialization }
ToTripletElement >> defaultLayout [ 

	^ ToTripletLayout horizontal.

]

{ #category : #initialization }
ToTripletElement >> initialize [ 

	super initialize.
	self initializeAsTripletElement
]

{ #category : #configuration }
ToTripletElement >> newWidgetConfiguration [ 

	^ ToTripletElementConfiguration new
]
