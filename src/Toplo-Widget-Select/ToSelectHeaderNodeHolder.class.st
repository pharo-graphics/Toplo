Class {
	#name : #ToSelectHeaderNodeHolder,
	#superclass : #Object,
	#instVars : [
		'select',
		'node'
	],
	#category : #'Toplo-Widget-Select-Node'
}

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
ToSelectHeaderNodeHolder >> select [

	^ select
]

{ #category : #accessing }
ToSelectHeaderNodeHolder >> select: aSelect [

	select := aSelect
]
