Class {
	#name : #ToSelectInnerNodeHolder,
	#superclass : #ToSelectAbstractInnerNodeHolder,
	#instVars : [
		'dataItem',
		'position'
	],
	#category : #'Toplo-Widget-Select-InnerNode'
}

{ #category : #accessing }
ToSelectInnerNodeHolder >> dataItem [

	^ dataItem
]

{ #category : #accessing }
ToSelectInnerNodeHolder >> dataItem: anObject [

	dataItem := anObject
]

{ #category : #accessing }
ToSelectInnerNodeHolder >> nodesCount [

	^ 1
]

{ #category : #accessing }
ToSelectInnerNodeHolder >> position [

	^ position
]

{ #category : #accessing }
ToSelectInnerNodeHolder >> position: anInteger [

	position := anInteger
]
