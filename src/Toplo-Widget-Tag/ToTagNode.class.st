Class {
	#name : #ToTagNode,
	#superclass : #ToBarNode,
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #skin }
ToTagNode >> newRawSkin [ 

	^ ToTagNodeSkin new
]

{ #category : #accessing }
ToTagNode >> nodesCount [ 

	^ self holder tagModel nodesCount
]
