Class {
	#name : #ToTokensHeritFromParentStrategy,
	#superclass : #ToTokensStrategy,
	#category : #'Toplo-IDE-theme-serialization'
}

{ #category : #converting }
ToTokensHeritFromParentStrategy >> asSourceCodeWith: aCollection [

	^ '^ super defaultTokenProperties'
]
