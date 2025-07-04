Class {
	#name : #ToSmartProperty,
	#superclass : #ToWritableProperty,
	#instVars : [
		'writer',
		'reader'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #'instance creation' }
ToSmartProperty class >> name: aName reader: aReadValuable writer: aWriteValuable [

	^ self new
		  name: aName;
		  reader: aReadValuable;
		  writer: aWriteValuable;
		  yourself
]

{ #category : #operating }
ToSmartProperty >> read: anObject [

	^ reader cull: anObject
]

{ #category : #accessing }
ToSmartProperty >> reader [

	^ reader
]

{ #category : #accessing }
ToSmartProperty >> reader: aValuableOrASymbol [

	reader := aValuableOrASymbol isSymbol
		          ifTrue: [ [ :e | e perform: aValuableOrASymbol ] ]
		          ifFalse: [ aValuableOrASymbol ]
]

{ #category : #operating }
ToSmartProperty >> write: aValue to: anObject [

	writer ifNil: [
		reader isSymbol
			ifTrue: [ self writer: reader asMutator ]
			ifFalse: [
				Error signal:
					'inconsistent property definition (no defined writer)' ] ].
	writer cull: anObject cull: aValue.
	^ anObject
]

{ #category : #accessing }
ToSmartProperty >> writer [

	^ writer
]

{ #category : #accessing }
ToSmartProperty >> writer: aValuableOrASymbol [

	writer := aValuableOrASymbol isSymbol
		          ifTrue: [ [ :e :v | e perform: aValuableOrASymbol with: v ] ]
		          ifFalse: [ aValuableOrASymbol ]
]
