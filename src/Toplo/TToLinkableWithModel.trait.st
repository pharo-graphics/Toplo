Trait {
	#name : #TToLinkableWithModel,
	#category : #'Toplo-Core'
}

{ #category : #'t - linkableWithModel' }
TToLinkableWithModel >> newModelLink [

	^ self linkClass new
]

{ #category : #'t - linkableWithModel' }
TToLinkableWithModel >> newModelLinkWith: aModel feature: aFeatureName [

	^ self newModelLink
		  link: self
		  withModel: aModel
		  reader: aFeatureName asSymbol
		  writer: aFeatureName asSymbol asMutator
]

{ #category : #'t - linkableWithModel' }
TToLinkableWithModel >> newModelLinkWith: aModel reader: aReader writer: aWriter [

	^ self newModelLink
		  link: self
		  withModel: aModel
		  reader: aReader
		  writer: aWriter
]
