Class {
	#name : #ToTabNode,
	#superclass : #ToCheckableNode,
	#category : #'Toplo-Widget-Tag-Tab'
}

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
