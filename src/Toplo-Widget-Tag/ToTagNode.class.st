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

{ #category : #accessing }
ToTagNode >> tagElement: aTagElement [

	| infiniteConstraints |
	infiniteConstraints := aTagElement constraints infinite.
	infiniteConstraints holder: self holder.
	self addChild: aTagElement

]
