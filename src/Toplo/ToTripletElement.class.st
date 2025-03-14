Class {
	#name : #ToTripletElement,
	#superclass : #ToElement,
	#traits : 'TToWithOrientableLayout + TToTripletElement',
	#classTraits : 'TToWithOrientableLayout classTrait + TToTripletElement classTrait',
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToTripletElement >> defaultLayout [ 

	^ BlLinearLayout horizontal.

]

{ #category : #skin }
ToTripletElement >> installRawStyle [

	super installRawStyle.
	self childrenDo: [ :child |
		child constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].

	
]

{ #category : #configuration }
ToTripletElement >> newToploConfiguration [ 

	^ ToTripletElementConfiguration new
]
