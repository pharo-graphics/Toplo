Class {
	#name : #ToSelectNodeHolder,
	#superclass : #Object,
	#instVars : [
		'selectElement',
		'dataItem',
		'position'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #accessing }
ToSelectNodeHolder >> dataItem [

	^ dataItem
]

{ #category : #accessing }
ToSelectNodeHolder >> dataItem: anObject [

	dataItem := anObject
]

{ #category : #initialization }
ToSelectNodeHolder >> initialize [ 

	super initialize.
	position := 0
]

{ #category : #accessing }
ToSelectNodeHolder >> position [

	^ position
]

{ #category : #accessing }
ToSelectNodeHolder >> position: aNumber [

	position := aNumber
]

{ #category : #accessing }
ToSelectNodeHolder >> selectElement [

	^ selectElement
]

{ #category : #accessing }
ToSelectNodeHolder >> selectElement: aSelectElement [

	selectElement := aSelectElement
]
