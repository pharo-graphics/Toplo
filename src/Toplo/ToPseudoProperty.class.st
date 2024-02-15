Class {
	#name : #ToPseudoProperty,
	#superclass : #ToWritableProperty,
	#instVars : [
		'writer',
		'reader'
	],
	#category : 'Toplo-Core-Properties'
}

{ #category : #'instance creation' }
ToPseudoProperty class >> name: aName reader: aReadValuable writer: aWriteValuable [

	^ self new
		  name: aName;
		  reader: aReadValuable;
		  writer: aWriteValuable;
		  yourself
]

{ #category : #operating }
ToPseudoProperty >> read: anObject [

	^ self reader value: anObject
]

{ #category : #accessing }
ToPseudoProperty >> reader [

	^ reader
]

{ #category : #accessing }
ToPseudoProperty >> reader: aValuable [

	reader := aValuable
]

{ #category : #operating }
ToPseudoProperty >> write: anPropertyValue to: anObject [

	self writer value: anObject value: anPropertyValue.
	^ anObject
]

{ #category : #accessing }
ToPseudoProperty >> writer [

	^ writer
]

{ #category : #accessing }
ToPseudoProperty >> writer: aValuable [

	writer := aValuable
]
