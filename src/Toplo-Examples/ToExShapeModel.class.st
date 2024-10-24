Class {
	#name : #ToExShapeModel,
	#superclass : #Object,
	#instVars : [
		'num',
		'background',
		'shape'
	],
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #comparing }
ToExShapeModel >> <= other [

	^ num <= other num
]

{ #category : #accessing }
ToExShapeModel >> background [

	^ background
]

{ #category : #accessing }
ToExShapeModel >> background: anObject [

	background := anObject
]

{ #category : #accessing }
ToExShapeModel >> num [

	^ num
]

{ #category : #accessing }
ToExShapeModel >> num: anObject [

	num := anObject
]

{ #category : #accessing }
ToExShapeModel >> shape [

	^ shape
]

{ #category : #accessing }
ToExShapeModel >> shape: aShape [

	shape := aShape
]
