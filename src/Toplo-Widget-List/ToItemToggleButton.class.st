"
I'm a menu item with toggle behavior. 
I'm one of the leave of menu composite.
"
Class {
	#name : #ToItemToggleButton,
	#superclass : #ToElement,
	#traits : 'TToOrientable + TToTripletElement + TToItem + TToClickable + TToCheckable',
	#classTraits : 'TToOrientable classTrait + TToTripletElement classTrait + TToItem classTrait + TToClickable classTrait + TToCheckable classTrait',
	#instVars : [
		'tripletProperties'
	],
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
	self initializeAsTripletElement.
	self initializeAsCheckable.
	self clickEventClass: ToCheckableCheckEvent
]

{ #category : #'t - orientable - accessing' }
ToItemToggleButton >> layoutStrategy [

	^ self layout

	
]

{ #category : #layout }
ToItemToggleButton >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	self configureLayout.
	super onLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #'t - triplet element - private accessing' }
ToItemToggleButton >> tripletProperties [

	^ tripletProperties
]

{ #category : #'t - triplet element - private accessing' }
ToItemToggleButton >> tripletProperties: aTripletElementProperties [

	tripletProperties := aTripletElementProperties
]
