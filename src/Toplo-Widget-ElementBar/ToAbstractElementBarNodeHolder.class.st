Class {
	#name : #ToAbstractElementBarNodeHolder,
	#superclass : #Object,
	#instVars : [
		'node',
		'elementBar'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #accessing }
ToAbstractElementBarNodeHolder >> elementBar [

	^ elementBar
]

{ #category : #accessing }
ToAbstractElementBarNodeHolder >> elementBar: anElementBar [

	elementBar := anElementBar
]

{ #category : #accessing }
ToAbstractElementBarNodeHolder >> node [

	^ node
]

{ #category : #accessing }
ToAbstractElementBarNodeHolder >> node: aSelectNode [

	node := aSelectNode
]

{ #category : #accessing }
ToAbstractElementBarNodeHolder >> nodesCount [

	^ self subclassResponsibility
]
