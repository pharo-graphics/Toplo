Class {
	#name : #ToSegmentedNode,
	#superclass : #ToItemNode,
	#category : #'Toplo-Widget-Segmented-Node'
}

{ #category : #'t - bar node' }
ToSegmentedNode >> autoDistribute: aBoolean [

	super autoDistribute: aBoolean.
	aBoolean ifTrue: [
		self checkableElement constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ] ]
]

{ #category : #accessing }
ToSegmentedNode >> checkableElement [ 

	^ self item
]

{ #category : #accessing }
ToSegmentedNode >> checkableElement: aCheckable [

	self item: aCheckable
]

{ #category : #'t - list node' }
ToSegmentedNode >> clickEventHandlerClasses [

	^  {  } 
]

{ #category : #skin }
ToSegmentedNode >> newRawSkin [ 

	^ ToSegmentedNodeSkin new
]
