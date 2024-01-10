Class {
	#name : #ToSelectNodeHolder,
	#superclass : #Object,
	#instVars : [
		'select',
		'node',
		'data',
		'position'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #accessing }
ToSelectNodeHolder >> data [

	^ data
]

{ #category : #accessing }
ToSelectNodeHolder >> data: anObject [

	data := anObject
]

{ #category : #accessing }
ToSelectNodeHolder >> listElement [

	^ select listElement
]

{ #category : #accessing }
ToSelectNodeHolder >> node [

	^ node
]

{ #category : #accessing }
ToSelectNodeHolder >> node: aSelectNode [

	node := aSelectNode
]

{ #category : #accessing }
ToSelectNodeHolder >> position [

	^ position
]

{ #category : #accessing }
ToSelectNodeHolder >> position: anInteger [

	position := anInteger
]

{ #category : #accessing }
ToSelectNodeHolder >> select [

	^ select
]

{ #category : #accessing }
ToSelectNodeHolder >> select: aSelect [

	select := aSelect
]
