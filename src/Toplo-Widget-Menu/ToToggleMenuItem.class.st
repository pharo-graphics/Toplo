"
I'm a menu item with toggle behavior. 
I'm one of the leave of menu composite.
"
Class {
	#name : #ToToggleMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #initialization }
ToToggleMenuItem >> initialize [

	super initialize.
	self closeOnPicking: false.
	self initializeAsCheckable 
]

{ #category : #skin }
ToToggleMenuItem >> newRawSkin [ 

	^ ToToggleMenuItemSkin new
]
