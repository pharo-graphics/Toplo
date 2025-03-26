"
I'm a menu item with toggle behavior. 
I'm one of the leave of menu composite.
"
Class {
	#name : #ToToggleMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'closeOnPicking'
	],
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item' }
ToToggleMenuItem >> closeOnPicking [ 

	^ closeOnPicking ifNil: [ closeOnPicking := false ]
]

{ #category : #'t - menu item' }
ToToggleMenuItem >> closeOnPicking: aBoolean [

	closeOnPicking := aBoolean
]

{ #category : #initialization }
ToToggleMenuItem >> initialize [

	super initialize.
	self initializeAsCheckable 
]

{ #category : #skin }
ToToggleMenuItem >> newRawSkin [ 

	^ ToToggleMenuItemSkin new
]
