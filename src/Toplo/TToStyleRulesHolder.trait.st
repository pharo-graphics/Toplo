Trait {
	#name : #TToStyleRulesHolder,
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #'t - style rules holder' }
TToStyleRulesHolder >> addAllStyleRules: aStyleRuleCollection [

	self rawStyleRules: (self rawStyleRules copyWithAll: aStyleRuleCollection)
]

{ #category : #'t - style rules holder' }
TToStyleRulesHolder >> addStyleRule: aStyleRule [

	self rawStyleRules: (self rawStyleRules copyWith: aStyleRule)
]

{ #category : #'t - style rules holder' }
TToStyleRulesHolder >> rawStyleRules [

	^ self explicitRequirement 
]

{ #category : #'t - style rules holder' }
TToStyleRulesHolder >> rawStyleRules: aStyleRuleCollection [

	self explicitRequirement
]

{ #category : #'t - style rules holder' }
TToStyleRulesHolder >> styleRules [

	^ self rawStyleRules 
]

{ #category : #'t - style rules holder' }
TToStyleRulesHolder >> styleRules: aStyleRuleCollection [

	self rawStyleRules: aStyleRuleCollection
]
