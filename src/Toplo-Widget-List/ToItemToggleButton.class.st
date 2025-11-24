"
I'm a menu item with toggle behavior. 
I'm one of the leave of menu composite.
"
Class {
	#name : #ToItemToggleButton,
	#superclass : #ToElement,
	#traits : 'TToOrientable + TToTripletContainer + TToTripletElement + TToLabeledIcon + TToItem + TToClickable + TToCheckable',
	#classTraits : 'TToOrientable classTrait + TToTripletContainer classTrait + TToTripletElement classTrait + TToLabeledIcon classTrait + TToItem classTrait + TToClickable classTrait + TToCheckable classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemToggleButton >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToItemToggleButton >> initialize [

	super initialize.
	self addEventHandler: ToClickableEventHandler new.
	self initializeAsTripletElement.
	self initializeAsCheckable.
	self clickEventClass: ToCheckableChangedEvent
]

{ #category : #configuration }
ToItemToggleButton >> newToConfiguration [ 

	^ ToTripletElementConfiguration new
]
