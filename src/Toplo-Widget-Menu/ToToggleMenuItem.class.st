"
I'm a menu item with toggle behavior. 
I'm one of the leave of menu composite.
"
Class {
	#name : #ToToggleMenuItem,
	#superclass : #ToMenuItem,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #initialization }
ToToggleMenuItem >> initialize [

	super initialize.
	self closeOnPicking: false.
	self initializeAsCheckable 
]

{ #category : #'t - element with action' }
ToToggleMenuItem >> newClickAction: aValuable [

	^ self newCheckAction: aValuable
]

{ #category : #skin }
ToToggleMenuItem >> newRawSkin [ 

	^ ToToggleMenuItemSkin new
]
