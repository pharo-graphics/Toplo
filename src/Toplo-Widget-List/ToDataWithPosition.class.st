Class {
	#name : #ToDataWithPosition,
	#superclass : #Object,
	#instVars : [
		'data',
		'dataSourcePos'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToDataWithPosition >> data [

	^ data
]

{ #category : #accessing }
ToDataWithPosition >> data: anObject [

	data := anObject
]

{ #category : #accessing }
ToDataWithPosition >> dataSourcePos [

	^ dataSourcePos
]

{ #category : #accessing }
ToDataWithPosition >> dataSourcePos: anInteger [

	dataSourcePos := anInteger
]
