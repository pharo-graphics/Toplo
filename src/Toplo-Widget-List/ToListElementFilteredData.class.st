Class {
	#name : #ToListElementFilteredData,
	#superclass : #Object,
	#instVars : [
		'data',
		'dataSourcePos'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToListElementFilteredData >> data [

	^ data
]

{ #category : #accessing }
ToListElementFilteredData >> data: anObject [

	data := anObject
]

{ #category : #accessing }
ToListElementFilteredData >> dataSourcePos [

	^ dataSourcePos
]

{ #category : #accessing }
ToListElementFilteredData >> dataSourcePos: anInteger [

	dataSourcePos := anInteger
]
