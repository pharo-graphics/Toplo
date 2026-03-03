Class {
	#name : #ToTripletContainer,
	#superclass : #ToElement,
	#traits : 'TToOrientable + TToDirectional + TToTripletContainer',
	#classTraits : 'TToOrientable classTrait + TToDirectional classTrait + TToTripletContainer classTrait',
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToTripletContainer >> defaultLayout [ 

	^ BlLinearLayout horizontal.

]

{ #category : #initialization }
ToTripletContainer >> initialize [ 

	super initialize.
	self initializeAsTripletContainer
]

{ #category : #skin }
ToTripletContainer >> installRawStyle [

	super installRawStyle.
	self childrenDo: [ :child |
		child constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].

	
]

{ #category : #configuration }
ToTripletContainer >> newToConfiguration [ 

	^ ToTripletContainerConfiguration new
]
