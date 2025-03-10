Class {
	#name : #ToFeatureProperty,
	#superclass : #ToWritableProperty,
	#instVars : [
		'writerName'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #'instance creation' }
ToFeatureProperty class >> name: aName [ 

	^ self new
		  name: aName;
		  yourself
]

{ #category : #operating }
ToFeatureProperty >> read: anObject [

	^ anObject perform: self name asSymbol
]

{ #category : #operating }
ToFeatureProperty >> write: aValue to: anObject [

	writerName ifNil: [ writerName := self name asSymbol asMutator ].
	anObject perform: writerName asSymbol with: aValue
]

{ #category : #accessing }
ToFeatureProperty >> writerName: aName [

	writerName := aName
]
