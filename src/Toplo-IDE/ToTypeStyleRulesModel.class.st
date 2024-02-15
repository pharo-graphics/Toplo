Class {
	#name : #ToTypeStyleRulesModel,
	#superclass : #ToStyleRulesModel,
	#instVars : [
		'dictionary'
	],
	#category : #'Toplo-IDE-theme-serialization'
}

{ #category : #converting }
ToTypeStyleRulesModel >> asSourceCodeOn: aStream [

	| visitor |
	aStream << self selector.
	aStream << '<r><r>'.
	aStream << self comment.
	aStream << '<r><r>'.

	self dictionary valuesDo: [ :model |
		aStream << 'self '.
		aStream << model selector.
		aStream << '.<r>' ].
	
visitor := ToThemeToSourceCodeVisitor new.
	self styleRules do: [ :each |
		each accept: visitor.
		aStream << visitor contents.
		aStream << '.<r>'.
		visitor reset ]
]

{ #category : #accessing }
ToTypeStyleRulesModel >> dictionary [

	^ dictionary
]

{ #category : #initialization }
ToTypeStyleRulesModel >> initialize [

	super initialize.
	dictionary := Dictionary new 
]

{ #category : #accessing }
ToTypeStyleRulesModel >> styleRules: aCollection [

	styleRules := aCollection reject: [ :each |
		              each selector isTypeSelector ].
	aCollection
		select: [ :each | each selector isTypeSelector ]
		thenDo: [ :each |
			self dictionary
				at: each selector type
				ifPresent: [ :styleRuleModel | styleRuleModel addStyleRules: { each } ]
				ifAbsentPut: [
					ToStyleRulesModel new
						styleRules: (OrderedCollection new add: each; yourself);
						selector:
							'initialize' , each selector type printString , 'StyleRules' ] ]
]
