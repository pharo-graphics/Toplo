Class {
	#name : #ToTokensModel,
	#superclass : #ToploModel,
	#instVars : [
		'strategy',
		'tokens'
	],
	#category : #'Toplo-IDE-theme-serialization'
}

{ #category : #converting }
ToTokensModel >> asSourceCodeOn: aStream [

	aStream << self selector.
	aStream << '<r><r>'.
	aStream << self comment.
	aStream << '<r><r>'.
	aStream << (self strategy asSourceCodeWith: self tokens)
]

{ #category : #initialization }
ToTokensModel >> initialize [

	strategy := ToTokensHeritFromParentStrategy new.
]

{ #category : #accessing }
ToTokensModel >> selector [

	^ 'defaultTokenProperties'
]

{ #category : #accessing }
ToTokensModel >> strategy [

	^ strategy
]

{ #category : #accessing }
ToTokensModel >> strategy: anObject [

	strategy := anObject
]

{ #category : #accessing }
ToTokensModel >> tokens [

	^ tokens
]

{ #category : #accessing }
ToTokensModel >> tokens: anObject [

	tokens := anObject
]
