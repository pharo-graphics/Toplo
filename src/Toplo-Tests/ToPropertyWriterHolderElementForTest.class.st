Class {
	#name : 'ToPropertyWriterHolderElementForTest',
	#superclass : 'Object',
	#traits : 'TToPropertyWriterHolder',
	#classTraits : 'TToPropertyWriterHolder classTrait',
	#instVars : [
		'writers'
	],
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 'initialization' }
ToPropertyWriterHolderElementForTest >> initialize [ 

	super 	initialize.
	writers := #(  )
]

{ #category : 't - property writer holder - accessing' }
ToPropertyWriterHolderElementForTest >> rawWriters [

	^ writers
]

{ #category : 't - property writer holder - accessing' }
ToPropertyWriterHolderElementForTest >> rawWriters: aPropertyWriterCollection [

	writers := aPropertyWriterCollection
]
