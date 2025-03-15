"
I'm a data item that behaves as a button. 
"
Class {
	#name : #ToGeneralButtonMenuItem,
	#superclass : #ToMenuItemElement,
	#traits : 'TToClickable',
	#classTraits : 'TToClickable classTrait',
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #initialization }
ToGeneralButtonMenuItem >> initialize [

	super initialize.
	self initializeAsClickable
]
