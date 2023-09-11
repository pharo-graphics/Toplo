Class {
	#name : #ToInstVarPropertyDefinition,
	#superclass : #ToPropertyDefinition,
	#category : #'Toplo-Theme-Look'
}

{ #category : #'instance creation' }
ToInstVarPropertyDefinition class >> name: aName [ 

	^ self new
		  name: aName;
		  yourself
]

{ #category : #operating }
ToInstVarPropertyDefinition >> read: anObject [

	^ anObject perform: self name asSymbol
]

{ #category : #operating }
ToInstVarPropertyDefinition >> write: aPropertyValue to: anObject [

	anObject perform: self name asSymbol asMutator with: aPropertyValue
]
