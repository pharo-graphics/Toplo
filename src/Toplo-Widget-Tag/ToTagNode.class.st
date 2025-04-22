Class {
	#name : #ToTagNode,
	#superclass : #ToBarNode,
	#instVars : [
		'tagElement'
	],
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'t - removable node' }
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

{ #category : #accessing }
ToTagNode >> tagElement [

	^ tagElement
]

{ #category : #accessing }
ToTagNode >> tagElement: aTagElement [

	| infiniteConstraints |
	tagElement := aTagElement.
	infiniteConstraints := aTagElement constraints infinite.
	infiniteConstraints holder: self holder.
	self addChild: aTagElement

]
