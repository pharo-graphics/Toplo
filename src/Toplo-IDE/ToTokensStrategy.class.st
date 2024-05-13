Class {
	#name : #ToTokensStrategy,
	#superclass : #Object,
	#category : #'Toplo-IDE-theme-serialization'
}

{ #category : #converting }
ToTokensStrategy >> asSourceCodeWith: aCollection [
	"Return a string ready on the format <^ x> where x is the tokens"
	self shouldBeImplemented
	
]

{ #category : #asserting }
ToTokensStrategy >> shouldCompile [

	^ true
]
