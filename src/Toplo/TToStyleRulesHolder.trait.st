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
TToStyleRulesHolder >> removeStyleRule: aStyleRule [

	self rawStyleRules: (self rawStyleRules copyWithout: aStyleRule)
]

{ #category : #'t - style rules holder' }
TToStyleRulesHolder >> styleRules [

	^ self rawStyleRules 
]

{ #category : #'t - style rules holder' }
TToStyleRulesHolder >> styleRules: aStyleRuleCollection [

	self rawStyleRules: aStyleRuleCollection
]
