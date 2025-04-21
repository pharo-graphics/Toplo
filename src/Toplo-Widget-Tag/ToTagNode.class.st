Class {
	#name : #ToTagNode,
	#superclass : #ToBarNode,
	#traits : 'TToRemovableNode',
	#classTraits : 'TToRemovableNode classTrait',
	#instVars : [
		'removeButton'
	],
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'t - removable node' }
ToTagNode >> addRemoveButton [

	removeButton ifNotNil: [ ^ self ].
	removeButton := ToIconicRemoveButton new.
	removeButton constraintsDo: [ :c |
		c ignoreByLayout ].
	self addChild: removeButton
]

{ #category : #testing }
ToTagNode >> isRemovable [

	^ self nodesCount = 1
]

{ #category : #skin }
ToTagNode >> newRawSkin [ 

	^ ToTagNodeSkin new
]

{ #category : #accessing }
ToTagNode >> nodesCount [ 

	^ self holder tagModel nodesCount
]

{ #category : #'t - removable node' }
ToTagNode >> removeButton [

	^ removeButton 
]

{ #category : #private }
ToTagNode >> removeFromBar [

	self isRemovable ifFalse: [ ^ self ].
	self holder removeNodeFromBar 
]

{ #category : #'t - removable node' }
ToTagNode >> removeRemoveButton [

	removeButton ifNil: [ ^ self ].
	removeButton removeFromParent.
	removeButton := nil
]
