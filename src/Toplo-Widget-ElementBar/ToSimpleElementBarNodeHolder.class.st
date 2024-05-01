Class {
	#name : #ToSimpleElementBarNodeHolder,
	#superclass : #ToElementBarNodeHolder,
	#instVars : [
		'data',
		'position'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #accessing }
ToSimpleElementBarNodeHolder >> data [

	^ data
]

{ #category : #accessing }
ToSimpleElementBarNodeHolder >> data: anObject [

	data := anObject
]

{ #category : #accessing }
ToSimpleElementBarNodeHolder >> nodesCount [

	^ 1
]

{ #category : #accessing }
ToSimpleElementBarNodeHolder >> position [

	^ position
]

{ #category : #accessing }
ToSimpleElementBarNodeHolder >> position: anInteger [

	position := anInteger
]
