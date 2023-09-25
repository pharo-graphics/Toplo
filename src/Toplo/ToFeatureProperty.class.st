Class {
	#name : #ToFeatureProperty,
	#superclass : #ToWriteableProperty,
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
ToFeatureProperty >> write: aPropertyValue to: anObject [

	anObject perform: self name asSymbol asMutator with: aPropertyValue
]
