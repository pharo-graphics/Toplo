Class {
	#name : #ToSelectAbstractInnerNodeHolder,
	#superclass : #Object,
	#instVars : [
		'node',
		'elementBar'
	],
	#category : #'Toplo-Widget-Select-InnerNode'
}

{ #category : #accessing }
ToSelectAbstractInnerNodeHolder >> elementBar [

	^ elementBar
]

{ #category : #accessing }
ToSelectAbstractInnerNodeHolder >> elementBar: anElementBar [

	elementBar := anElementBar
]

{ #category : #accessing }
ToSelectAbstractInnerNodeHolder >> node [

	^ node
]

{ #category : #accessing }
ToSelectAbstractInnerNodeHolder >> node: aSelectNode [

	node := aSelectNode
]

{ #category : #accessing }
ToSelectAbstractInnerNodeHolder >> nodesCount [

	^ self subclassResponsibility
]
