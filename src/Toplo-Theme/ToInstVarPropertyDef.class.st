Class {
	#name : #ToInstVarPropertyDef,
	#superclass : #ToPropertyDef,
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #'instance creation' }
ToInstVarPropertyDef class >> name: aName [ 

	^ self new
		  name: aName;
		  yourself
]

{ #category : #operating }
ToInstVarPropertyDef >> read: anObject [

	^ anObject perform: self name asSymbol
]

{ #category : #operating }
ToInstVarPropertyDef >> write: aPropertyValue to: anObject [

	anObject perform: self name asSymbol asMutator with: aPropertyValue
]
