Class {
	#name : #ToTabNode,
	#superclass : #ToCheckableNode,
	#traits : 'TToRemovableNode',
	#classTraits : 'TToRemovableNode classTrait',
	#instVars : [
		'removeButton'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'t - removable item element' }
ToTabNode >> addRemoveButton [

	removeButton ifNotNil: [ ^ self ].
	removeButton := ToIconicRemoveButton new.
	removeButton constraintsDo: [ :c |
		c ignoreByLayout ].
	self addChild: removeButton
]

{ #category : #initialization }
ToTabNode >> initialize [ 

	super initialize.
	self addEventHandlerOn: ToRemoveButtonClickedEvent do: [ :event |
		event consume.
		event currentTarget item removeFromBar ]
	
]

{ #category : #testing }
ToTabNode >> isRemovable [ 

	^ self item isRemovable
]

{ #category : #'t - bar node' }
ToTabNode >> listElementReferenceBoundsInSpace [

	|  list |
	list := self holder listElement.
	^ list bounds inSpace
]

{ #category : #skin }
ToTabNode >> newRawSkin [ 

	^ ToTabNodeSkin new
]

{ #category : #configuration }
ToTabNode >> newWidgetConfiguration [ 

	^ ToTabNodeConfiguration new
]

{ #category : #'t - removable item element' }
ToTabNode >> removeButton [

	^ removeButton 
]

{ #category : #'t - removable item element' }
ToTabNode >> removeRemoveButton [

	removeButton ifNil: [ ^ self ].
	removeButton removeFromParent.
	removeButton := nil
]
