Class {
	#name : #ToExplicitPropertyDefinition,
	#superclass : #ToPropertyDefinition,
	#instVars : [
		'writer',
		'reader'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #'instance creation' }
ToExplicitPropertyDefinition class >> name: aName reader: aReadValuable writer: aWriteValuable [

	^ self new
		  name: aName;
		  reader: aReadValuable;
		  writer: aWriteValuable;
		  yourself
]

{ #category : #operating }
ToExplicitPropertyDefinition >> read: anObject [

	^ self reader value: anObject
]

{ #category : #accessing }
ToExplicitPropertyDefinition >> reader [

	^ reader
]

{ #category : #accessing }
ToExplicitPropertyDefinition >> reader: aValuable [

	reader := aValuable
]

{ #category : #operating }
ToExplicitPropertyDefinition >> write: anPropertyValue to: anObject [

	self writer value: anObject value: anPropertyValue
]

{ #category : #accessing }
ToExplicitPropertyDefinition >> writer [

	^ writer
]

{ #category : #accessing }
ToExplicitPropertyDefinition >> writer: aValuable [

	writer := aValuable
]
