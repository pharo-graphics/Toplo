Class {
	#name : #ToTagNode,
	#superclass : #ToBarNode,
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #initialization }
ToTagNode >> initialize [

	super initialize.
	removable := true
]

{ #category : #testing }
ToTagNode >> isRemovable [

	^ removable and: [  self nodesCount = 1 ]
]

{ #category : #skin }
ToTagNode >> newRawSkin [ 

	^ ToTagNodeSkin new
]

{ #category : #accessing }
ToTagNode >> nodesCount [ 

	^ self holder tagModel nodesCount
]

{ #category : #accessing }
ToTagNode >> removable: aBoolean [

	removable := aBoolean
]

{ #category : #accessing }
ToTagNode >> removeButton [ 

	^ self childWithId: #removeButton ifNone: [  ]
]

{ #category : #private }
ToTagNode >> removeFromBar [

	self holder removeNodeFromBar 
]
