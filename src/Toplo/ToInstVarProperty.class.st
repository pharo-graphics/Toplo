Class {
	#name : #ToInstVarProperty,
	#superclass : #ToLookProperty,
	#category : #'Toplo-Core-Properties'
}

{ #category : #'instance creation' }
ToInstVarProperty class >> name: aName [ 

	^ self new
		  name: aName;
		  yourself
]

{ #category : #operating }
ToInstVarProperty >> read: anObject [

	^ anObject perform: self name asSymbol
]

{ #category : #operating }
ToInstVarProperty >> write: aPropertyValue to: anObject [

	anObject perform: self name asSymbol asMutator with: aPropertyValue
]
