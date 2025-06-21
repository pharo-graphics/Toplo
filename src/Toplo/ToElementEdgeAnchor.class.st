Class {
	#name : #ToElementEdgeAnchor,
	#superclass : #ToElementAnchor,
	#instVars : [
		'edgeName',
		'element'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #accessing }
ToElementEdgeAnchor >> edgeName [

	^ edgeName
]

{ #category : #accessing }
ToElementEdgeAnchor >> edgeName: anObject [

	edgeName := anObject
]

{ #category : #accessing }
ToElementEdgeAnchor >> element [

	^ element
]

{ #category : #accessing }
ToElementEdgeAnchor >> element: anObject [

	element := anObject
]

{ #category : #evaluating }
ToElementEdgeAnchor >> value [
	^ element perform: edgeName
]
