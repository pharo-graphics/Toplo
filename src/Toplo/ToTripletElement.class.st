Class {
	#name : #ToTripletElement,
	#superclass : #ToElement,
	#traits : 'TToOrientable + TToTripletElement',
	#classTraits : 'TToOrientable classTrait + TToTripletElement classTrait',
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
ToTripletElement >> newWidgetConfiguration [ 

	^ ToTripletElementConfiguration new
]
