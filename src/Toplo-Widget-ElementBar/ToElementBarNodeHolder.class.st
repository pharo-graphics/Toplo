Class {
	#name : #ToElementBarNodeHolder,
	#superclass : #ToAbstractElementBarNodeHolder,
	#instVars : [
		'dataItem',
		'position'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #accessing }
ToElementBarNodeHolder >> dataItem [

	^ dataItem
]

{ #category : #accessing }
ToElementBarNodeHolder >> dataItem: anObject [

	dataItem := anObject
]

{ #category : #accessing }
ToElementBarNodeHolder >> nodesCount [

	^ 1
]

{ #category : #accessing }
ToElementBarNodeHolder >> position [

	^ position
]

{ #category : #accessing }
ToElementBarNodeHolder >> position: anInteger [

	position := anInteger
]
