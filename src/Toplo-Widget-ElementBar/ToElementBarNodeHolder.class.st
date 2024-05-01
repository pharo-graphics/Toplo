Class {
	#name : #ToElementBarNodeHolder,
	#superclass : #Object,
	#instVars : [
		'node',
		'elementBar'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #accessing }
ToElementBarNodeHolder >> elementBar [

	^ elementBar
]

{ #category : #accessing }
ToElementBarNodeHolder >> elementBar: anElementBar [

	elementBar := anElementBar
]

{ #category : #accessing }
ToElementBarNodeHolder >> node [

	^ node
]

{ #category : #accessing }
ToElementBarNodeHolder >> node: aSelectNode [

	node := aSelectNode
]

{ #category : #accessing }
ToElementBarNodeHolder >> nodesCount [

	^ self subclassResponsibility
]
