Class {
	#name : #ToFilterData,
	#superclass : #Object,
	#instVars : [
		'data',
		'dataSourcePos'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #accessing }
ToFilterData >> data [

	^ data
]

{ #category : #accessing }
ToFilterData >> data: anObject [

	data := anObject
]

{ #category : #accessing }
ToFilterData >> dataSourcePos [

	^ dataSourcePos
]

{ #category : #accessing }
ToFilterData >> dataSourcePos: anInteger [

	dataSourcePos := anInteger
]
