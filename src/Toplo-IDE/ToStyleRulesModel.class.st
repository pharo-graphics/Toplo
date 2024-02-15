Class {
	#name : #ToStyleRulesModel,
	#superclass : #ToploModel,
	#instVars : [
		'styleRules',
		'selector'
	],
	#category : #'Toplo-IDE-theme-serialization'
}

{ #category : #adding }
ToStyleRulesModel >> addStyleRules: aCollection [

	self styleRules: self styleRules , aCollection
]

{ #category : #converting }
ToStyleRulesModel >> asSourceCodeOn: aStream [

	| visitor |
	aStream << self selector.
	aStream << '<r><r>'.
	aStream << self comment.
	aStream << '<r><r>'.


	visitor := ToThemeToSourceCodeVisitor new.
	self styleRules do: [ :each |
		each accept: visitor.
		aStream << visitor contents.
		aStream << '.<r>'.
		visitor reset ].
]

{ #category : #accessing }
ToStyleRulesModel >> selector [

	^ selector
]

{ #category : #accessing }
ToStyleRulesModel >> selector: anObject [

	selector := anObject
]

{ #category : #accessing }
ToStyleRulesModel >> styleRules [

	^ styleRules
]

{ #category : #accessing }
ToStyleRulesModel >> styleRules: anObject [

	styleRules := anObject
]
