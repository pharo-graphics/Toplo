Trait {
	#name : #TToLinkable,
	#category : #'Toplo-Core'
}

{ #category : #'t - linkable' }
TToLinkable >> linkCheckWith: aModel action: aValuable [ 

	^ self newCheckActionLink
		  link: self
		  withModel: aModel
		  action: aValuable
]

{ #category : #'t - linkable' }
TToLinkable >> linkCheckWith: aModel feature: aFeatureName [

	^ self newCheckPropertyLink
		  link: self
		  withModel: aModel
		  reader: aFeatureName asSymbol
		  writer: aFeatureName asSymbol asMutator
]

{ #category : #'t - linkable' }
TToLinkable >> linkCheckWith: aModel reader: aReader writer: aWriter [

	^ self newCheckPropertyLink
		  link: self
		  withModel: aModel
		  reader: aReader
		  writer: aWriter
]

{ #category : #'t - linkable' }
TToLinkable >> linkClickAction: aValuable [

	^ self linkClickWith: self action: aValuable
]

{ #category : #'t - linkable' }
TToLinkable >> linkClickWith: aModel action: aValuable [ 

	^ self newClickActionLink
		  link: self
		  withModel: aModel
		  action: aValuable
]

{ #category : #'t - linkable' }
TToLinkable >> newCheckActionLink [

	^ self checkActionLinkClass new
]

{ #category : #'t - linkable' }
TToLinkable >> newCheckPropertyLink [

	^ self checkPropertyLinkClass new
]

{ #category : #'t - linkable' }
TToLinkable >> newClickActionLink [

	^ self clickActionLinkClass new
]
