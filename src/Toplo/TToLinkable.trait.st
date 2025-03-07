Trait {
	#name : #TToLinkable,
	#category : #'Toplo-Core'
}

{ #category : #'t - linkable' }
TToLinkable >> checkAction: aValuable [

	^ self checkAction: aValuable with: self
]

{ #category : #'t - linkable' }
TToLinkable >> checkAction: aValuable with: aModel [ 

	^ self newCheckActionLink
		  link: self
		  withModel: aModel
		  action: aValuable
]

{ #category : #'t - linkable' }
TToLinkable >> checkFeature: aFeatureName with: aModel [

	^ self newCheckPropertyLink
		  link: self
		  withModel: aModel
		  reader: aFeatureName asSymbol
		  writer: aFeatureName asSymbol asMutator
]

{ #category : #'t - linkable' }
TToLinkable >> checkReader: aReader writer: aWriter with: aModel [

	^ self newCheckPropertyLink
		  link: self
		  withModel: aModel
		  reader: aReader
		  writer: aWriter
]

{ #category : #'t - linkable' }
TToLinkable >> clickAction: aValuable [

	^ self clickAction: aValuable with: self
]

{ #category : #'t - linkable' }
TToLinkable >> clickAction: aValuable with: aModel [ 

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
