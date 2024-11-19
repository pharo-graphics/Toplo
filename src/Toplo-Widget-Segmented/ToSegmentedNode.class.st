Class {
	#name : #ToSegmentedNode,
	#superclass : #ToBarNode,
	#classTraits : 'TToCheckable classTrait',
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

	^ self firstChild
]

{ #category : #accessing }
ToSegmentedNode >> checkableElement: aCheckable [

	self addChild: aCheckable
]

{ #category : #'t - list node' }
ToSegmentedNode >> clickEventHandlerClasses [

	^  {  } 
]

{ #category : #testing }
ToSegmentedNode >> isFirst [

	^ self holder position = 1
]

{ #category : #testing }
ToSegmentedNode >> isLast [

	^ self holder position = self holder dataSource itemCount 
]

{ #category : #skin }
ToSegmentedNode >> newRawSkin [ 

	^ ToSegmentedNodeSkin new
]
