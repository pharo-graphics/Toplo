Class {
	#name : #ToSelectHeaderNodeHolder,
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
ToSelectHeaderNodeHolder >> data [

	^ data
]

{ #category : #accessing }
ToSelectHeaderNodeHolder >> data: anObject [

	data := anObject
]

{ #category : #accessing }
ToSelectHeaderNodeHolder >> listElement [

	^ select listElement
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
ToSelectHeaderNodeHolder >> position [

	^ position
]

{ #category : #accessing }
ToSelectHeaderNodeHolder >> position: anInteger [

	position := anInteger
]

{ #category : #accessing }
ToSelectHeaderNodeHolder >> select [

	^ select
]

{ #category : #accessing }
ToSelectHeaderNodeHolder >> select: aSelect [

	select := aSelect
]
