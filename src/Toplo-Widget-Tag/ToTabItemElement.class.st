Class {
	#name : #ToTabItemElement,
	#superclass : #ToItemToggleButton,
	#traits : 'TToRemovableItemElement',
	#classTraits : 'TToRemovableItemElement classTrait',
	#instVars : [
		'removeButton'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'t - removable item element' }
ToTabItemElement >> addRemoveButton [

	removeButton ifNotNil: [ ^ self ].
	removeButton := ToIconicRemoveButton new.
	removeButton constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignLeft.
		c ignored vertical alignCenter ].
	self addChild: removeButton.
	self holder listElement isWrapping ifTrue: [ ^ self ].
	removeButton
		addStamp: #'selected-focused-foreground'
		withValue:
		(self valueOfTokenNamed: #'color-primary-selection-focused').
	removeButton
		addStamp: #'selected-unfocused-foreground'
		withValue:
		(self valueOfTokenNamed: #'color-primary-selection-focused').

]

{ #category : #converting }
ToTabItemElement >> asString [

	^ self label asString
]

{ #category : #initialization }
ToTabItemElement >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	self addEventHandlerOn: ToRemoveShotEvent do: [ :event |
		event consume.
		event currentTarget removeFromBar ]
	
]

{ #category : #skin }
ToTabItemElement >> newRawSkin [ 

	^ ToTabItemElementSkin new
]

{ #category : #'t - removable item element' }
ToTabItemElement >> removeButton [

	^ removeButton 
]

{ #category : #removing }
ToTabItemElement >> removeFromBar [

	self isRemovable ifFalse: [ ^ self ].
	self holder removeNodeFromBar 
]

{ #category : #'t - removable item element' }
ToTabItemElement >> removeRemoveButton [

	removeButton ifNil: [ ^ self ].
	removeButton removeFromParent.
	removeButton := nil
]
