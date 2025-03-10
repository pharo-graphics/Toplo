"
I'm a menu item with toggle behavior. 
I'm one of the leave of menu composite.
"
Class {
	#name : #ToItemToggleButton,
	#superclass : #ToElement,
	#traits : 'TToWithOrientableLayout + TToTripletElement + TToLabeledIcon + TToItem + TToClickable + TToCheckable',
	#classTraits : 'TToWithOrientableLayout classTrait + TToTripletElement classTrait + TToLabeledIcon classTrait + TToItem classTrait + TToClickable classTrait + TToCheckable classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemToggleButton >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToItemToggleButton >> initialize [

	super initialize.
	self addEventHandler: ToClickableFocusEventHandler new.
	self initializeAsTripletElementOn: self.
	self initializeAsCheckable.
	self clickEventClass: ToCheckableChangedEvent
]
