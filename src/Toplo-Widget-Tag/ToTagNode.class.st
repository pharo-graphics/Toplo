Class {
	#name : #ToTagNode,
	#superclass : #ToBarNode,
	#category : #'Toplo-Widget-Tag-Tag'
}

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

{ #category : #private }
ToTagNode >> removeFromBar [

	self isRemovable ifFalse: [ ^ self ].
	self holder removeNodeFromBar 
]
