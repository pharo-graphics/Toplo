Class {
	#name : #ToSelectHeaderNodeHolder,
	#superclass : #Object,
	#instVars : [
		'node',
		'headerElement'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #accessing }
ToSelectHeaderNodeHolder >> headerElement [

	^ headerElement
]

{ #category : #accessing }
ToSelectHeaderNodeHolder >> headerElement: aHeaderElement [

	headerElement := aHeaderElement
]

{ #category : #accessing }
ToSelectHeaderNodeHolder >> listElement [

	^ headerElement listElement
]

{ #category : #accessing }
ToSelectHeaderNodeHolder >> node [

	^ node
]

{ #category : #accessing }
ToSelectHeaderNodeHolder >> node: aSelectNode [

	node := aSelectNode
]

{ #category : #accessing }
ToSelectHeaderNodeHolder >> nodesCount [
	^ self subclassResponsibility
]
