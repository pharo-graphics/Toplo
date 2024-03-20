Class {
	#name : #ToHeaderNodeHolder,
	#superclass : #ToSelectHeaderNodeHolder,
	#instVars : [
		'data',
		'position'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #accessing }
ToHeaderNodeHolder >> data [

	^ data
]

{ #category : #accessing }
ToHeaderNodeHolder >> data: anObject [

	data := anObject
]

{ #category : #accessing }
ToHeaderNodeHolder >> nodesCount [

	^ 1
]

{ #category : #accessing }
ToHeaderNodeHolder >> position [

	^ position
]

{ #category : #accessing }
ToHeaderNodeHolder >> position: anInteger [

	position := anInteger
]
