Class {
	#name : 'ToPropertyWritersHolderElementForTest',
	#superclass : 'Object',
	#traits : 'TToPropertyWritersHolder',
	#classTraits : 'TToPropertyWritersHolder classTrait',
	#instVars : [
		'propertyWriters'
	],
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 'initialization' }
ToPropertyWritersHolderElementForTest >> initialize [ 

	super 	initialize.
	self rawPropertyWriters: #(  )
]

{ #category : 't - property writers holder - accessing' }
ToPropertyWritersHolderElementForTest >> rawPropertyWriters [

	^ propertyWriters
]

{ #category : 't - property writers holder - accessing' }
ToPropertyWritersHolderElementForTest >> rawPropertyWriters: aPropertyWriterCollection [

	propertyWriters := aPropertyWriterCollection
]
