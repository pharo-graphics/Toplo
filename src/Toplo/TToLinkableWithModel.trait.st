Trait {
	#name : #TToLinkableWithModel,
	#category : #'Toplo-Core'
}

{ #category : #'t - linkableWithModel' }
TToLinkableWithModel >> newActionLink [

	^ self actionLinkClass new
]

{ #category : #'t - linkableWithModel' }
TToLinkableWithModel >> newModelLinkWith: aModel action: aValuable [ 

	^ self newActionLink
		  link: self
		  withModel: aModel
		  action: aValuable
]

{ #category : #'t - linkableWithModel' }
TToLinkableWithModel >> newModelLinkWith: aModel feature: aFeatureName [

	^ self newPropertyLink
		  link: self
		  withModel: aModel
		  reader: aFeatureName asSymbol
		  writer: aFeatureName asSymbol asMutator
]

{ #category : #'t - linkableWithModel' }
TToLinkableWithModel >> newModelLinkWith: aModel reader: aReader writer: aWriter [

	^ self newPropertyLink
		  link: self
		  withModel: aModel
		  reader: aReader
		  writer: aWriter
]

{ #category : #'t - linkableWithModel' }
TToLinkableWithModel >> newPropertyLink [

	^ self propertyLinkClass new
]
