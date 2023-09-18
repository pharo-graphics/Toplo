Class {
	#name : #ToPropertyWriterForTest,
	#superclass : #Object,
	#traits : 'TToPropertyWriter',
	#classTraits : 'TToPropertyWriter classTrait',
	#instVars : [
		'propName',
		'value'
	],
	#category : #'Toplo-Theme-Tests-SkinDep'
}

{ #category : #accessing }
ToPropertyWriterForTest >> propName [

	^ propName
]

{ #category : #accessing }
ToPropertyWriterForTest >> propName: anObject [

	propName := anObject
]

{ #category : #accessing }
ToPropertyWriterForTest >> value [

	^ value
]

{ #category : #accessing }
ToPropertyWriterForTest >> value: anObject [

	value := anObject
]

{ #category : #'t - property writer - writing' }
ToPropertyWriterForTest >> writeTo: anObject [

	anObject perform: self propName asSymbol asMutator with: self value
]
